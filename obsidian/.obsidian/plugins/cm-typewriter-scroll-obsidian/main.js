'use strict';

var obsidian = require('obsidian');
var state = require('@codemirror/state');
var view = require('@codemirror/view');

/*! *****************************************************************************
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
/* global Reflect, Promise */

var extendStatics = function(d, b) {
    extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
    return extendStatics(d, b);
};

function __extends(d, b) {
    if (typeof b !== "function" && b !== null)
        throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
    extendStatics(d, b);
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
}

function __awaiter(thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
}

function __generator(thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
}

// all credit to azu: https://github.com/azu/codemirror-typewriter-scrolling/blob/b0ac076d72c9445c96182de87d974de2e8cc56e2/typewriter-scrolling.js
var movedByMouse = false;
CodeMirror.commands.scrollSelectionToCenter = function (cm) {
    var cursor = cm.getCursor('head');
    var charCoords = cm.charCoords(cursor, "local");
    var top = charCoords.top;
    var halfLineHeight = (charCoords.bottom - top) / 2;
    var halfWindowHeight = cm.getWrapperElement().offsetHeight / 2;
    var scrollTo = Math.round((top - halfWindowHeight + halfLineHeight));
    cm.scrollTo(null, scrollTo);
};
CodeMirror.defineOption("typewriterScrolling", false, function (cm, val, old) {
    if (old && old != CodeMirror.Init) {
        const linesEl = cm.getScrollerElement().querySelector('.CodeMirror-lines');
        linesEl.style.paddingTop = null;
        linesEl.style.paddingBottom = null;
        cm.off("cursorActivity", onCursorActivity);
        cm.off("refresh", onRefresh);
        cm.off("mousedown", onMouseDown);
        cm.off("keydown", onKeyDown);
        cm.off("beforeChange", onBeforeChange);
    }
    if (val) {
        onRefresh(cm);
        cm.on("cursorActivity", onCursorActivity);
        cm.on("refresh", onRefresh);
        cm.on("mousedown", onMouseDown);
        cm.on("keydown", onKeyDown);
        cm.on("beforeChange", onBeforeChange);
    }
});
function onMouseDown() {
    movedByMouse = true;
}
const modiferKeys = ["Alt", "AltGraph", "CapsLock", "Control", "Fn", "FnLock", "Hyper", "Meta", "NumLock", "ScrollLock", "Shift", "Super", "Symbol", "SymbolLock"];
function onKeyDown(cm, e) {
    if (!modiferKeys.includes(e.key)) {
        movedByMouse = false;
    }
}
function onBeforeChange() {
    movedByMouse = false;
}
function onCursorActivity(cm) {
    const linesEl = cm.getScrollerElement().querySelector('.CodeMirror-lines');
    if (cm.getSelection().length !== 0) {
        linesEl.classList.add("selecting");
    }
    else {
        linesEl.classList.remove("selecting");
    }

    if(!movedByMouse) {
        cm.execCommand("scrollSelectionToCenter");
    }
}
function onRefresh(cm) {
    const halfWindowHeight = cm.getWrapperElement().offsetHeight / 2;
    const linesEl = cm.getScrollerElement().querySelector('.CodeMirror-lines');
    linesEl.style.paddingTop = `${halfWindowHeight}px`;
    linesEl.style.paddingBottom = `${halfWindowHeight}px`; // Thanks @walulula!
    if (cm.getSelection().length === 0) {
        cm.execCommand("scrollSelectionToCenter");
    }
}

var allowedUserEvents = /^(select|input|delete|undo|redo)(\..+)?$/;
var disallowedUserEvents = /^(select.pointer)$/;
var typewriterOffset = state.Facet.define({
    combine: function (values) { return values.length ? Math.min.apply(Math, values) : 0.5; }
});
var resetTypewriterScrollPaddingPlugin = view.ViewPlugin.fromClass(/** @class */ (function () {
    function class_1(view) {
        this.view = view;
    }
    class_1.prototype.update = function (update) {
        if (this.view.contentDOM.style.paddingTop) {
            this.view.contentDOM.style.paddingTop = "";
            this.view.contentDOM.style.paddingBottom = (update.view.dom.clientHeight / 2) + "px";
        }
    };
    return class_1;
}()));
var typewriterScrollPaddingPlugin = view.ViewPlugin.fromClass(/** @class */ (function () {
    function class_2(view) {
        this.view = view;
        this.topPadding = null;
    }
    class_2.prototype.update = function (update) {
        var offset = (update.view.dom.clientHeight * update.view.state.facet(typewriterOffset)) - (update.view.defaultLineHeight / 2);
        this.topPadding = offset + "px";
        if (this.topPadding != this.view.contentDOM.style.paddingTop) {
            this.view.contentDOM.style.paddingTop = this.topPadding;
            this.view.contentDOM.style.paddingBottom = (update.view.dom.clientHeight - offset) + "px";
        }
    };
    return class_2;
}()));
var typewriterScrollPlugin = view.ViewPlugin.fromClass(/** @class */ (function () {
    function class_3(view) {
        this.view = view;
        this.myUpdate = false;
    }
    class_3.prototype.update = function (update) {
        if (this.myUpdate)
            this.myUpdate = false;
        else {
            var userEvents = update.transactions.map(function (tr) { return tr.annotation(state.Transaction.userEvent); });
            var isAllowed = userEvents.reduce(function (result, event) { return result && allowedUserEvents.test(event) && !disallowedUserEvents.test(event); }, userEvents.length > 0);
            if (isAllowed) {
                this.myUpdate = true;
                this.centerOnHead(update);
            }
        }
    };
    class_3.prototype.centerOnHead = function (update) {
        return __awaiter(this, void 0, void 0, function () {
            var _this = this;
            return __generator(this, function (_a) {
                // can't update inside an update, so request the next animation frame
                window.requestAnimationFrame(function () {
                    // current selection range
                    if (update.state.selection.ranges.length == 1) {
                        // only act on the one range
                        var head = update.state.selection.main.head;
                        var prevHead = update.startState.selection.main.head;
                        // TODO: work out line number and use that instead? Is that even possible?
                        // don't bother with this next part if the range (line??) hasn't changed
                        if (prevHead != head) {
                            // this is the effect that does the centering
                            var offset = (update.view.dom.clientHeight * update.view.state.facet(typewriterOffset)) - (update.view.defaultLineHeight / 2);
                            var effect = view.EditorView.scrollIntoView(head, { y: "start", yMargin: offset });
                            // const effect = EditorView.scrollIntoView(head, { y: "center" });
                            var transaction = _this.view.state.update({ effects: effect });
                            _this.view.dispatch(transaction);
                        }
                    }
                });
                return [2 /*return*/];
            });
        });
    };
    return class_3;
}()));
function typewriterScroll(options) {
    if (options === void 0) { options = {}; }
    return [
        options.typewriterOffset == null ? [] : typewriterOffset.of(options.typewriterOffset),
        typewriterScrollPaddingPlugin,
        typewriterScrollPlugin
    ];
}
function resetTypewriterSrcoll() {
    return [
        resetTypewriterScrollPaddingPlugin
    ];
}

var DEFAULT_SETTINGS = {
    enabled: true,
    typewriterOffset: 0.5,
    zenEnabled: false,
    zenOpacity: 0.25
};
var CMTypewriterScrollPlugin = /** @class */ (function (_super) {
    __extends(CMTypewriterScrollPlugin, _super);
    function CMTypewriterScrollPlugin() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.extArray = [];
        _this.toggleTypewriterScroll = function (newValue) {
            if (newValue === void 0) { newValue = null; }
            // if no value is passed in, toggle the existing value
            if (newValue === null)
                newValue = !_this.settings.enabled;
            // assign the new value and call the correct enable / disable function
            (_this.settings.enabled = newValue)
                ? _this.enableTypewriterScroll() : _this.disableTypewriterScroll();
            // save the new settings
            _this.saveData(_this.settings);
        };
        _this.changeTypewriterOffset = function (newValue) {
            _this.settings.typewriterOffset = newValue;
            if (_this.settings.enabled) {
                _this.disableTypewriterScroll();
                // delete the extension, so it gets recreated with the new value
                delete _this.ext;
                _this.enableTypewriterScroll();
            }
            _this.saveData(_this.settings);
        };
        _this.toggleZen = function (newValue) {
            if (newValue === void 0) { newValue = null; }
            // if no value is passed in, toggle the existing value
            if (newValue === null)
                newValue = !_this.settings.zenEnabled;
            // assign the new value and call the correct enable / disable function
            (_this.settings.zenEnabled = newValue)
                ? _this.enableZen() : _this.disableZen();
            // save the new settings
            _this.saveData(_this.settings);
        };
        _this.changeZenOpacity = function (newValue) {
            if (newValue === void 0) { newValue = 0.25; }
            _this.settings.zenOpacity = newValue;
            _this.css.innerText = "body{--zen-opacity: ".concat(newValue, ";}");
            // save the new settings
            _this.saveData(_this.settings);
        };
        _this.enableTypewriterScroll = function () {
            // add the class
            document.body.classList.add('plugin-cm-typewriter-scroll');
            // register the codemirror add on setting
            _this.registerCodeMirror(function (cm) {
                // @ts-ignore
                cm.setOption("typewriterScrolling", true);
            });
            if (!_this.ext) {
                _this.ext = typewriterScroll({ typewriterOffset: _this.settings.typewriterOffset });
                _this.extArray = [_this.ext];
                _this.registerEditorExtension(_this.extArray);
            }
            else {
                _this.extArray.splice(0, _this.extArray.length);
                _this.extArray.push(_this.ext);
                _this.app.workspace.updateOptions();
            }
        };
        _this.disableTypewriterScroll = function () {
            // remove the class
            document.body.classList.remove('plugin-cm-typewriter-scroll');
            // remove the codemirror add on setting
            _this.app.workspace.iterateCodeMirrors(function (cm) {
                // @ts-ignore
                cm.setOption("typewriterScrolling", false);
            });
            // clear out the registered extension
            _this.extArray.splice(0, _this.extArray.length);
            _this.extArray.push(resetTypewriterSrcoll());
            _this.app.workspace.updateOptions();
        };
        _this.enableZen = function () {
            // add the class
            document.body.classList.add('plugin-cm-typewriter-scroll-zen');
        };
        _this.disableZen = function () {
            // remove the class
            document.body.classList.remove('plugin-cm-typewriter-scroll-zen');
        };
        return _this;
    }
    CMTypewriterScrollPlugin.prototype.onload = function () {
        return __awaiter(this, void 0, void 0, function () {
            var _a, _b, _c, _d;
            return __generator(this, function (_e) {
                switch (_e.label) {
                    case 0:
                        _a = this;
                        _c = (_b = Object).assign;
                        _d = [DEFAULT_SETTINGS];
                        return [4 /*yield*/, this.loadData()];
                    case 1:
                        _a.settings = _c.apply(_b, _d.concat([_e.sent()]));
                        // enable the plugin (based on settings)
                        if (this.settings.enabled)
                            this.enableTypewriterScroll();
                        if (this.settings.zenEnabled)
                            this.enableZen();
                        this.css = document.createElement('style');
                        this.css.id = 'plugin-typewriter-scroll';
                        this.css.setAttr('type', 'text/css');
                        document.getElementsByTagName("head")[0].appendChild(this.css);
                        this.css.innerText = "body{--zen-opacity: ".concat(this.settings.zenOpacity, ";}");
                        // add the settings tab
                        this.addSettingTab(new CMTypewriterScrollSettingTab(this.app, this));
                        // add the commands / keyboard shortcuts
                        this.addCommands();
                        return [2 /*return*/];
                }
            });
        });
    };
    CMTypewriterScrollPlugin.prototype.onunload = function () {
        // disable the plugin
        this.disableTypewriterScroll();
        this.disableZen();
    };
    CMTypewriterScrollPlugin.prototype.addCommands = function () {
        var _this = this;
        // add the toggle on/off command
        this.addCommand({
            id: 'toggle-typewriter-sroll',
            name: 'Toggle On/Off',
            callback: function () { _this.toggleTypewriterScroll(); }
        });
        // toggle zen mode
        this.addCommand({
            id: 'toggle-typewriter-sroll-zen',
            name: 'Toggle Zen Mode On/Off',
            callback: function () { _this.toggleZen(); }
        });
    };
    return CMTypewriterScrollPlugin;
}(obsidian.Plugin));
var CMTypewriterScrollSettingTab = /** @class */ (function (_super) {
    __extends(CMTypewriterScrollSettingTab, _super);
    function CMTypewriterScrollSettingTab(app, plugin) {
        var _this = _super.call(this, app, plugin) || this;
        _this.plugin = plugin;
        return _this;
    }
    CMTypewriterScrollSettingTab.prototype.display = function () {
        var _this = this;
        var containerEl = this.containerEl;
        containerEl.empty();
        new obsidian.Setting(containerEl)
            .setName("Toggle Typewriter Scrolling")
            .setDesc("Turns typewriter scrolling on or off globally")
            .addToggle(function (toggle) {
            return toggle.setValue(_this.plugin.settings.enabled)
                .onChange(function (newValue) { _this.plugin.toggleTypewriterScroll(newValue); });
        });
        new obsidian.Setting(containerEl)
            .setName("Center offset")
            .setDesc("Positions the typewriter text at the specified percentage of the screen")
            .addSlider(function (slider) {
            return slider.setLimits(0, 100, 5)
                .setValue(_this.plugin.settings.typewriterOffset * 100)
                .onChange(function (newValue) { _this.plugin.changeTypewriterOffset(newValue / 100); });
        });
        new obsidian.Setting(containerEl)
            .setName("Zen Mode")
            .setDesc("Darkens non-active lines in the editor so you can focus on what you're typing")
            .addToggle(function (toggle) {
            return toggle.setValue(_this.plugin.settings.zenEnabled)
                .onChange(function (newValue) { _this.plugin.toggleZen(newValue); });
        });
        new obsidian.Setting(containerEl)
            .setName("Zen Opacity")
            .setDesc("The opacity of unfocused lines in zen mode")
            .addSlider(function (slider) {
            return slider.setLimits(0, 100, 5)
                .setValue(_this.plugin.settings.zenOpacity * 100)
                .onChange(function (newValue) { _this.plugin.changeZenOpacity(newValue / 100); });
        });
    };
    return CMTypewriterScrollSettingTab;
}(obsidian.PluginSettingTab));

module.exports = CMTypewriterScrollPlugin;


/* nosourcemap */