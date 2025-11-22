'use strict';

var obsidian = require('obsidian');

/******************************************************************************
Copyright (c) Microsoft Corporation.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
***************************************************************************** */
/* global Reflect, Promise, SuppressedError, Symbol, Iterator */


function __awaiter(thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
}

typeof SuppressedError === "function" ? SuppressedError : function (error, suppressed, message) {
    var e = new Error(message);
    return e.name = "SuppressedError", e.error = error, e.suppressed = suppressed, e;
};

function isExcalidraw(app, f) {
    if (f.extension === 'excalidraw' || /.*\.excalidraw\.md$/g.test(f.path)) {
        return true;
    }
    const fileCache = app.metadataCache.getFileCache(f);
    return (!!(fileCache === null || fileCache === void 0 ? void 0 : fileCache.frontmatter) && !!fileCache.frontmatter['excalidraw-plugin']);
}
function isKanban(app, f) {
    const fileCache = app.metadataCache.getFileCache(f);
    return !!(fileCache === null || fileCache === void 0 ? void 0 : fileCache.frontmatter) && !!fileCache.frontmatter['kanban-plugin'];
}
function isExcluded(app, f) {
    if (isExcalidraw(app, f)) {
        return true;
    }
    if (isKanban(app, f)) {
        return true;
    }
    return false;
}

const stockIllegalSymbols = /[\\/:|#^[\]]/g;
// Must be Strings unless settings dialog is updated.
var HeadingStyle;
(function (HeadingStyle) {
    HeadingStyle["Prefix"] = "Prefix";
    HeadingStyle["Underline"] = "Underline";
})(HeadingStyle || (HeadingStyle = {}));
const DEFAULT_SETTINGS = {
    userIllegalSymbols: [],
    ignoredFiles: {},
    ignoreRegex: '',
    useFileOpenHook: true,
    useFileSaveHook: true,
    newHeadingStyle: HeadingStyle.Prefix,
    replaceStyle: false,
    underlineString: '===',
    renameDebounceTimeout: 1000,
    insertHeadingIfMissing: true,
};
class FilenameHeadingSyncPlugin extends obsidian.Plugin {
    constructor() {
        super(...arguments);
        this.isRenameInProgress = false;
        this.renameDebounceTimer = null;
    }
    waitForTemplater() {
        return __awaiter(this, void 0, void 0, function* () {
            const templaterEnabled = this.app.plugins.enabledPlugins.has('templater-obsidian');
            if (!templaterEnabled) {
                return;
            }
            const templaterEvents = [
                'templater:new-note-from-template',
                'templater:template-appended',
                'templater:overwrite-file',
            ];
            return new Promise((resolve) => {
                // Create one-time event handlers that clean themselves up
                const handlers = templaterEvents.map((event) => {
                    const handler = () => {
                        // Remove all handlers when any event fires
                        handlers.forEach((h) => this.app.workspace.off(h.event, h.fn));
                        resolve(true);
                    };
                    return { event, fn: handler };
                });
                // Register all handlers
                handlers.forEach((h) => this.app.workspace.on(h.event, () => {
                    // console.log(
                    //   `[filename-heading-sync] templater event ${h.event} fired, cleaning up`,
                    // );
                    h.fn();
                }));
                // Timeout fallback that also cleans up
                setTimeout(() => {
                    handlers.forEach((h) => this.app.workspace.off(h.event, h.fn));
                    resolve(true);
                }, 100);
            });
        });
    }
    onload() {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.loadSettings();
            this.registerEvent(this.app.vault.on('rename', (file, oldPath) => {
                if (this.settings.useFileSaveHook) {
                    this.waitForTemplater().then(() => {
                        return this.handleSyncFilenameToHeading(file, oldPath);
                    });
                }
            }));
            this.registerEvent(this.app.vault.on('modify', (file) => {
                if (this.settings.useFileSaveHook) {
                    this.waitForTemplater().then(() => {
                        return this.handleSyncHeadingToFile(file);
                    });
                }
            }));
            this.registerEvent(this.app.workspace.on('file-open', (file) => {
                if (this.settings.useFileOpenHook && file !== null) {
                    this.waitForTemplater().then(() => {
                        return this.handleSyncFilenameToHeading(file, file.path);
                    });
                }
            }));
            this.addSettingTab(new FilenameHeadingSyncSettingTab(this.app, this));
            this.addCommand({
                id: 'page-heading-sync-ignore-file',
                name: 'Ignore current file',
                checkCallback: (checking) => {
                    let leaf = this.app.workspace.activeLeaf;
                    if (leaf) {
                        if (!checking) {
                            const activeFile = this.app.workspace.getActiveFile();
                            if (activeFile) {
                                this.settings.ignoredFiles[activeFile.path] = null;
                            }
                            this.saveSettings();
                        }
                        return true;
                    }
                    return false;
                },
            });
            this.addCommand({
                id: 'sync-filename-to-heading',
                name: 'Sync Filename to Heading',
                editorCallback: (editor, view) => this.forceSyncFilenameToHeading(view.file),
            });
            this.addCommand({
                id: 'sync-heading-to-filename',
                name: 'Sync Heading to Filename',
                editorCallback: (editor, view) => this.forceSyncHeadingToFilename(view.file),
            });
        });
    }
    fileIsIgnored(activeFile, path) {
        // check exclusions
        if (isExcluded(this.app, activeFile)) {
            return true;
        }
        // check manual ignore
        if (this.settings.ignoredFiles[path] !== undefined) {
            return true;
        }
        // check regex
        try {
            if (this.settings.ignoreRegex === '') {
                return false;
            }
            const reg = new RegExp(this.settings.ignoreRegex);
            return reg.exec(path) !== null;
        }
        catch (_a) { }
        return false;
    }
    /**
     * Renames the file with the first heading found
     *
     * @param      {TAbstractFile}  file    The file
     */
    handleSyncHeadingToFile(file) {
        if (!(file instanceof obsidian.TFile)) {
            return;
        }
        if (file.extension !== 'md') {
            // just bail
            return;
        }
        // if currently opened file is not the same as the one that fired the event, skip
        // this is to make sure other events don't trigger this plugin
        if (this.app.workspace.getActiveFile() !== file) {
            return;
        }
        // if ignored, just bail
        if (this.fileIsIgnored(file, file.path)) {
            return;
        }
        // Clear any existing debounce timer
        if (this.renameDebounceTimer) {
            clearTimeout(this.renameDebounceTimer);
        }
        // Set a new debounce timer
        this.renameDebounceTimer = setTimeout(() => {
            this.forceSyncHeadingToFilename(file);
            this.renameDebounceTimer = null;
        }, this.settings.renameDebounceTimeout);
    }
    ensureFileSaved(file) {
        return __awaiter(this, void 0, void 0, function* () {
            for (const leaf of this.app.workspace.getLeavesOfType('markdown')) {
                if (leaf.view instanceof obsidian.MarkdownView &&
                    leaf.view.file === file &&
                    leaf.view.dirty) {
                    yield leaf.view.save();
                }
            }
        });
    }
    forceSyncHeadingToFilename(file) {
        return __awaiter(this, void 0, void 0, function* () {
            if (file === null) {
                return;
            }
            yield this.ensureFileSaved(file);
            this.app.vault.read(file).then((data) => __awaiter(this, void 0, void 0, function* () {
                var _a;
                const lines = data.split('\n');
                const start = this.findNoteStart(lines);
                const heading = this.findHeading(lines, start);
                if (heading === null)
                    return; // no heading found, nothing to do here
                const sanitizedHeading = this.sanitizeHeading(heading.text);
                if (sanitizedHeading.length > 0 &&
                    this.sanitizeHeading(file.basename) !== sanitizedHeading) {
                    const newPath = `${(_a = file.parent) === null || _a === void 0 ? void 0 : _a.path}/${sanitizedHeading}.md`;
                    this.isRenameInProgress = true;
                    try {
                        yield this.app.fileManager.renameFile(file, newPath);
                    }
                    catch (error) {
                        // Rename failed, but we still need to reset the flag
                    }
                    finally {
                        this.isRenameInProgress = false;
                    }
                }
            }));
        });
    }
    /**
     * Syncs the current filename to the first heading
     * Finds the first heading of the file, then replaces it with the filename
     *
     * @param      {TAbstractFile}  file     The file that fired the event
     * @param      {string}         oldPath  The old path
     */
    handleSyncFilenameToHeading(file, oldPath) {
        if (this.isRenameInProgress) {
            return;
        }
        if (!(file instanceof obsidian.TFile)) {
            return;
        }
        if (file.extension !== 'md') {
            // just bail
            return;
        }
        // if oldpath is ignored, hook in and update the new filepath to be ignored instead
        if (this.fileIsIgnored(file, oldPath.trim())) {
            // if filename didn't change, just bail, nothing to do here
            if (file.path === oldPath) {
                return;
            }
            // If filepath changed and the file was in the ignore list before,
            // remove it from the list and add the new one instead
            if (this.settings.ignoredFiles[oldPath]) {
                delete this.settings.ignoredFiles[oldPath];
                this.settings.ignoredFiles[file.path] = null;
                this.saveSettings();
            }
            return;
        }
        this.forceSyncFilenameToHeading(file);
    }
    forceSyncFilenameToHeading(file) {
        return __awaiter(this, void 0, void 0, function* () {
            if (file === null) {
                return;
            }
            yield this.ensureFileSaved(file);
            const sanitizedHeading = this.sanitizeHeading(file.basename);
            this.app.vault.read(file).then((data) => {
                const lines = data.split('\n');
                const start = this.findNoteStart(lines);
                const heading = this.findHeading(lines, start);
                if (heading !== null) {
                    if (this.sanitizeHeading(heading.text) !== sanitizedHeading) {
                        this.replaceHeading(file, lines, heading.lineNumber, heading.style, sanitizedHeading);
                    }
                }
                else if (this.settings.insertHeadingIfMissing) {
                    this.insertHeading(file, lines, start, sanitizedHeading);
                }
            });
        });
    }
    /**
     * Finds the start of the note file, excluding frontmatter
     *
     * @param {string[]} fileLines array of the file's contents, line by line
     * @returns {number} zero-based index of the starting line of the note
     */
    findNoteStart(fileLines) {
        // check for frontmatter by checking if first line is a divider ('---')
        if (fileLines[0] === '---') {
            // find end of frontmatter
            // if no end is found, then it isn't really frontmatter and function will end up returning 0
            for (let i = 1; i < fileLines.length; i++) {
                if (fileLines[i] === '---') {
                    // end of frontmatter found, next line is start of note
                    return i + 1;
                }
            }
        }
        return 0;
    }
    /**
     * Finds the first heading of the note file
     *
     * @param {string[]} fileLines array of the file's contents, line by line
     * @param {number} startLine zero-based index of the starting line of the note
     * @returns {LinePointer | null} LinePointer to heading or null if no heading found
     */
    findHeading(fileLines, startLine) {
        let insideCodeBlock = false;
        for (let i = startLine; i < fileLines.length; i++) {
            const line = fileLines[i].trimEnd(); // Trim end to handle spaces after backticks
            // Check for fenced code block markers (allowing for indentation)
            if (line.trim().startsWith('```')) {
                insideCodeBlock = !insideCodeBlock;
                continue;
            }
            // Skip if inside code block
            if (insideCodeBlock) {
                continue;
            }
            // Check for prefix style heading, ignoring escaped hashes and inline code
            if (line.startsWith('# ')) {
                // Skip if the line is inside inline code (has odd number of backticks before #)
                const backtickCount = (line.match(/`/g) || []).length;
                if (backtickCount % 2 === 0) {
                    // Skip if the # is escaped with \
                    if (!line.startsWith('\\# ')) {
                        return {
                            lineNumber: i,
                            text: line.substring(2),
                            style: HeadingStyle.Prefix,
                        };
                    }
                }
            }
            // Check for underline style heading
            if (fileLines[i + 1] !== undefined &&
                fileLines[i + 1].trim().match(/^=+$/) !== null &&
                line.length > 0 // Ensure the heading line isn't empty
            ) {
                // Skip if the line is inside inline code
                const backtickCount = (line.match(/`/g) || []).length;
                if (backtickCount % 2 === 0) {
                    return {
                        lineNumber: i,
                        text: line,
                        style: HeadingStyle.Underline,
                    };
                }
            }
        }
        return null; // no valid heading found outside code blocks
    }
    regExpEscape(str) {
        return String(str).replace(/[\\^$*+?.()|[\]{}]/g, '\\$&');
    }
    sanitizeHeading(text) {
        // stockIllegalSymbols is a regExp object, but userIllegalSymbols is a list of strings and therefore they are handled separately.
        text = text.replace(stockIllegalSymbols, '');
        const userIllegalSymbolsEscaped = this.settings.userIllegalSymbols.map((str) => this.regExpEscape(str));
        const userIllegalSymbolsRegExp = new RegExp(userIllegalSymbolsEscaped.join('|'), 'g');
        text = text.replace(userIllegalSymbolsRegExp, '');
        return text.trim();
    }
    /**
     * Insert the `heading` at `lineNumber` in `file`.
     *
     * @param {TFile} file the file to modify
     * @param {string[]} fileLines array of the file's contents, line by line
     * @param {number} lineNumber zero-based index of the line to replace
     * @param {string} text the new text
     */
    insertHeading(file, fileLines, lineNumber, heading) {
        const newStyle = this.settings.newHeadingStyle;
        switch (newStyle) {
            case HeadingStyle.Underline: {
                this.insertLineInFile(file, fileLines, lineNumber, `${heading}`);
                this.insertLineInFile(file, fileLines, lineNumber + 1, this.settings.underlineString);
                break;
            }
            case HeadingStyle.Prefix: {
                this.insertLineInFile(file, fileLines, lineNumber, `# ${heading}`);
                break;
            }
        }
    }
    /**
     * Modified `file` by replacing the heading at `lineNumber` with `newHeading`,
     * updating the heading style according the user settings.
     *
     * @param {TFile} file the file to modify
     * @param {string[]} fileLines array of the file's contents, line by line
     * @param {number} lineNumber zero-based index of the line to replace
     * @param {HeadingStyle} oldStyle the style of the original heading
     * @param {string} text the new text
     */
    replaceHeading(file, fileLines, lineNumber, oldStyle, newHeading) {
        const newStyle = this.settings.newHeadingStyle;
        const replaceStyle = this.settings.replaceStyle;
        // If replacing the style
        if (replaceStyle) {
            switch (newStyle) {
                // For underline style, replace heading line...
                case HeadingStyle.Underline: {
                    this.replaceLineInFile(file, fileLines, lineNumber, `${newHeading}`);
                    //..., then add or replace underline.
                    switch (oldStyle) {
                        case HeadingStyle.Prefix: {
                            this.insertLineInFile(file, fileLines, lineNumber + 1, this.settings.underlineString);
                            break;
                        }
                        case HeadingStyle.Underline: {
                            // Update underline with setting.
                            this.replaceLineInFile(file, fileLines, lineNumber + 1, this.settings.underlineString);
                            break;
                        }
                    }
                    break;
                }
                // For prefix style, replace heading line, and possibly delete underline
                case HeadingStyle.Prefix: {
                    this.replaceLineInFile(file, fileLines, lineNumber, `# ${newHeading}`);
                    switch (oldStyle) {
                        case HeadingStyle.Prefix: {
                            // nop
                            break;
                        }
                        case HeadingStyle.Underline: {
                            this.replaceLineInFile(file, fileLines, lineNumber + 1, '');
                            break;
                        }
                    }
                    break;
                }
            }
        }
        else {
            // If not replacing style, match
            switch (oldStyle) {
                case HeadingStyle.Underline: {
                    this.replaceLineInFile(file, fileLines, lineNumber, `${newHeading}`);
                    break;
                }
                case HeadingStyle.Prefix: {
                    this.replaceLineInFile(file, fileLines, lineNumber, `# ${newHeading}`);
                    break;
                }
            }
        }
    }
    /**
     * Modifies the file by replacing a particular line with new text.
     *
     * The function will add a newline character at the end of the replaced line.
     *
     * If the `lineNumber` parameter is higher than the index of the last line of the file
     * the function will add a newline character to the current last line and append a new
     * line at the end of the file with the new text (essentially a new last line).
     *
     * @param {TFile} file the file to modify
     * @param {string[]} fileLines array of the file's contents, line by line
     * @param {number} lineNumber zero-based index of the line to replace
     * @param {string} text the new text
     */
    replaceLineInFile(file, fileLines, lineNumber, text) {
        if (lineNumber >= fileLines.length) {
            fileLines.push(text + '\n');
        }
        else {
            fileLines[lineNumber] = text;
        }
        const data = fileLines.join('\n');
        this.app.vault.modify(file, data);
    }
    /**
     * Modifies the file by inserting a line with specified text.
     *
     * The function will add a newline character at the end of the inserted line.
     *
     * @param {TFile} file the file to modify
     * @param {string[]} fileLines array of the file's contents, line by line
     * @param {number} lineNumber zero-based index of where the line should be inserted
     * @param {string} text the text that the line shall contain
     */
    insertLineInFile(file, fileLines, lineNumber, text) {
        if (lineNumber >= fileLines.length) {
            fileLines.push(text + '\n');
        }
        else {
            fileLines.splice(lineNumber, 0, text);
        }
        const data = fileLines.join('\n');
        this.app.vault.modify(file, data);
    }
    loadSettings() {
        return __awaiter(this, void 0, void 0, function* () {
            this.settings = Object.assign({}, DEFAULT_SETTINGS, yield this.loadData());
        });
    }
    saveSettings() {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.saveData(this.settings);
        });
    }
    onunload() {
        // Clear any pending debounce timer
        if (this.renameDebounceTimer) {
            clearTimeout(this.renameDebounceTimer);
            this.renameDebounceTimer = null;
        }
    }
}
class FilenameHeadingSyncSettingTab extends obsidian.PluginSettingTab {
    constructor(app, plugin) {
        super(app, plugin);
        this.plugin = plugin;
        this.app = app;
    }
    display() {
        let { containerEl } = this;
        let regexIgnoredFilesDiv;
        const renderRegexIgnoredFiles = (div) => {
            // empty existing div
            div.innerHTML = '';
            if (this.plugin.settings.ignoreRegex === '') {
                return;
            }
            try {
                const files = this.app.vault.getFiles();
                const reg = new RegExp(this.plugin.settings.ignoreRegex);
                files
                    .filter((file) => reg.exec(file.path) !== null)
                    .forEach((el) => {
                    new obsidian.Setting(div).setDesc(el.path);
                });
            }
            catch (e) {
                return;
            }
        };
        containerEl.empty();
        containerEl.createEl('h2', { text: 'Filename Heading Sync' });
        containerEl.createEl('p', {
            text: 'This plugin will overwrite the first heading found in a file with the filename.',
        });
        containerEl.createEl('p', {
            text: 'If no header is found, will insert a new one at the first line (after frontmatter).',
        });
        new obsidian.Setting(containerEl)
            .setName('Custom Illegal Characters/Strings')
            .setDesc('Type characters/strings separated by a comma. This input is space sensitive.')
            .addText((text) => text
            .setPlaceholder('[],#,...')
            .setValue(this.plugin.settings.userIllegalSymbols.join())
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.userIllegalSymbols = value.split(',');
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('Ignore Regex Rule')
            .setDesc('Ignore rule in RegEx format. All files listed below will get ignored by this plugin.')
            .addText((text) => text
            .setPlaceholder('MyFolder/.*')
            .setValue(this.plugin.settings.ignoreRegex)
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            try {
                new RegExp(value);
                this.plugin.settings.ignoreRegex = value;
            }
            catch (_a) {
                this.plugin.settings.ignoreRegex = '';
            }
            yield this.plugin.saveSettings();
            renderRegexIgnoredFiles(regexIgnoredFilesDiv);
        })));
        new obsidian.Setting(containerEl)
            .setName('Use File Open Hook')
            .setDesc('Whether this plugin should trigger when a file is opened, and not just on save. Disable this when you notice conflicts with other plugins that also act on file open.')
            .addToggle((toggle) => toggle
            .setValue(this.plugin.settings.useFileOpenHook)
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.useFileOpenHook = value;
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('Use File Save Hook')
            .setDesc('Whether this plugin should trigger when a file is saved. Disable this when you want to trigger sync only manually.')
            .addToggle((toggle) => toggle
            .setValue(this.plugin.settings.useFileSaveHook)
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.useFileSaveHook = value;
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('Insert Heading If Missing')
            .setDesc('Whether to automatically insert a heading when none is found. Disable this to prevent the plugin from adding headings to files without them.')
            .addToggle((toggle) => toggle
            .setValue(this.plugin.settings.insertHeadingIfMissing)
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.insertHeadingIfMissing = value;
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('New Heading Style')
            .setDesc('Which Markdown heading style to use when creating new headings: Prefix ("# Heading") or Underline ("Heading\\n===").')
            .addDropdown((cb) => cb
            .addOption(HeadingStyle.Prefix, 'Prefix')
            .addOption(HeadingStyle.Underline, 'Underline')
            .setValue(this.plugin.settings.newHeadingStyle)
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            if (value === 'Prefix') {
                this.plugin.settings.newHeadingStyle = HeadingStyle.Prefix;
            }
            if (value === 'Underline') {
                this.plugin.settings.newHeadingStyle = HeadingStyle.Underline;
            }
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('Replace Heading Style')
            .setDesc('Whether this plugin should replace existing heading styles when updating headings.')
            .addToggle((toggle) => toggle
            .setValue(this.plugin.settings.replaceStyle)
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.replaceStyle = value;
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('Underline String')
            .setDesc('The string to use when insert Underline-style headings; should be some number of "="s.')
            .addText((text) => text
            .setPlaceholder('===')
            .setValue(this.plugin.settings.underlineString)
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.underlineString = value;
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('Rename Debounce Timeout')
            .setDesc('Delay in milliseconds before renaming the file after typing stops. This prevents frequent renames while typing. Default is 1000ms (2 seconds).')
            .addText((text) => text
            .setPlaceholder('1000')
            .setValue(String(this.plugin.settings.renameDebounceTimeout))
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            const numValue = parseInt(value);
            if (!isNaN(numValue) && numValue > 0) {
                this.plugin.settings.renameDebounceTimeout = numValue;
                yield this.plugin.saveSettings();
            }
        })));
        containerEl.createEl('h2', { text: 'Ignored Files By Regex' });
        containerEl.createEl('p', {
            text: 'All files matching the above RegEx will get listed here',
        });
        regexIgnoredFilesDiv = containerEl.createDiv('test');
        renderRegexIgnoredFiles(regexIgnoredFilesDiv);
        containerEl.createEl('h2', { text: 'Manually Ignored Files' });
        containerEl.createEl('p', {
            text: 'You can ignore files from this plugin by using the "ignore this file" command',
        });
        // go over all ignored files and add them
        for (let key in this.plugin.settings.ignoredFiles) {
            const ignoredFilesSettingsObj = new obsidian.Setting(containerEl).setDesc(key);
            ignoredFilesSettingsObj.addButton((button) => {
                button.setButtonText('Delete').onClick(() => __awaiter(this, void 0, void 0, function* () {
                    delete this.plugin.settings.ignoredFiles[key];
                    yield this.plugin.saveSettings();
                    this.display();
                }));
            });
        }
    }
}

module.exports = FilenameHeadingSyncPlugin;


/* nosourcemap */