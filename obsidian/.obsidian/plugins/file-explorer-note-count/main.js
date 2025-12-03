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

// 'path' module extracted from Node.js v8.11.1 (only the posix part)

function assertPath(path) {
  if (typeof path !== 'string') {
    throw new TypeError('Path must be a string. Received ' + JSON.stringify(path));
  }
}

// Resolves . and .. elements in a path with directory names
function normalizeStringPosix(path, allowAboveRoot) {
  var res = '';
  var lastSegmentLength = 0;
  var lastSlash = -1;
  var dots = 0;
  var code;
  for (var i = 0; i <= path.length; ++i) {
    if (i < path.length)
      code = path.charCodeAt(i);
    else if (code === 47 /*/*/)
      break;
    else
      code = 47 /*/*/;
    if (code === 47 /*/*/) {
      if (lastSlash === i - 1 || dots === 1) ; else if (lastSlash !== i - 1 && dots === 2) {
        if (res.length < 2 || lastSegmentLength !== 2 || res.charCodeAt(res.length - 1) !== 46 /*.*/ || res.charCodeAt(res.length - 2) !== 46 /*.*/) {
          if (res.length > 2) {
            var lastSlashIndex = res.lastIndexOf('/');
            if (lastSlashIndex !== res.length - 1) {
              if (lastSlashIndex === -1) {
                res = '';
                lastSegmentLength = 0;
              } else {
                res = res.slice(0, lastSlashIndex);
                lastSegmentLength = res.length - 1 - res.lastIndexOf('/');
              }
              lastSlash = i;
              dots = 0;
              continue;
            }
          } else if (res.length === 2 || res.length === 1) {
            res = '';
            lastSegmentLength = 0;
            lastSlash = i;
            dots = 0;
            continue;
          }
        }
        if (allowAboveRoot) {
          if (res.length > 0)
            res += '/..';
          else
            res = '..';
          lastSegmentLength = 2;
        }
      } else {
        if (res.length > 0)
          res += '/' + path.slice(lastSlash + 1, i);
        else
          res = path.slice(lastSlash + 1, i);
        lastSegmentLength = i - lastSlash - 1;
      }
      lastSlash = i;
      dots = 0;
    } else if (code === 46 /*.*/ && dots !== -1) {
      ++dots;
    } else {
      dots = -1;
    }
  }
  return res;
}

function _format(sep, pathObject) {
  var dir = pathObject.dir || pathObject.root;
  var base = pathObject.base || (pathObject.name || '') + (pathObject.ext || '');
  if (!dir) {
    return base;
  }
  if (dir === pathObject.root) {
    return dir + base;
  }
  return dir + sep + base;
}

var posix = {
  // path.resolve([from ...], to)
  resolve: function resolve() {
    var resolvedPath = '';
    var resolvedAbsolute = false;
    var cwd;

    for (var i = arguments.length - 1; i >= -1 && !resolvedAbsolute; i--) {
      var path;
      if (i >= 0)
        path = arguments[i];
      else {
        if (cwd === undefined)
          cwd = process.cwd();
        path = cwd;
      }

      assertPath(path);

      // Skip empty entries
      if (path.length === 0) {
        continue;
      }

      resolvedPath = path + '/' + resolvedPath;
      resolvedAbsolute = path.charCodeAt(0) === 47 /*/*/;
    }

    // At this point the path should be resolved to a full absolute path, but
    // handle relative paths to be safe (might happen when process.cwd() fails)

    // Normalize the path
    resolvedPath = normalizeStringPosix(resolvedPath, !resolvedAbsolute);

    if (resolvedAbsolute) {
      if (resolvedPath.length > 0)
        return '/' + resolvedPath;
      else
        return '/';
    } else if (resolvedPath.length > 0) {
      return resolvedPath;
    } else {
      return '.';
    }
  },

  normalize: function normalize(path) {
    assertPath(path);

    if (path.length === 0) return '.';

    var isAbsolute = path.charCodeAt(0) === 47 /*/*/;
    var trailingSeparator = path.charCodeAt(path.length - 1) === 47 /*/*/;

    // Normalize the path
    path = normalizeStringPosix(path, !isAbsolute);

    if (path.length === 0 && !isAbsolute) path = '.';
    if (path.length > 0 && trailingSeparator) path += '/';

    if (isAbsolute) return '/' + path;
    return path;
  },

  isAbsolute: function isAbsolute(path) {
    assertPath(path);
    return path.length > 0 && path.charCodeAt(0) === 47 /*/*/;
  },

  join: function join() {
    if (arguments.length === 0)
      return '.';
    var joined;
    for (var i = 0; i < arguments.length; ++i) {
      var arg = arguments[i];
      assertPath(arg);
      if (arg.length > 0) {
        if (joined === undefined)
          joined = arg;
        else
          joined += '/' + arg;
      }
    }
    if (joined === undefined)
      return '.';
    return posix.normalize(joined);
  },

  relative: function relative(from, to) {
    assertPath(from);
    assertPath(to);

    if (from === to) return '';

    from = posix.resolve(from);
    to = posix.resolve(to);

    if (from === to) return '';

    // Trim any leading backslashes
    var fromStart = 1;
    for (; fromStart < from.length; ++fromStart) {
      if (from.charCodeAt(fromStart) !== 47 /*/*/)
        break;
    }
    var fromEnd = from.length;
    var fromLen = fromEnd - fromStart;

    // Trim any leading backslashes
    var toStart = 1;
    for (; toStart < to.length; ++toStart) {
      if (to.charCodeAt(toStart) !== 47 /*/*/)
        break;
    }
    var toEnd = to.length;
    var toLen = toEnd - toStart;

    // Compare paths to find the longest common path from root
    var length = fromLen < toLen ? fromLen : toLen;
    var lastCommonSep = -1;
    var i = 0;
    for (; i <= length; ++i) {
      if (i === length) {
        if (toLen > length) {
          if (to.charCodeAt(toStart + i) === 47 /*/*/) {
            // We get here if `from` is the exact base path for `to`.
            // For example: from='/foo/bar'; to='/foo/bar/baz'
            return to.slice(toStart + i + 1);
          } else if (i === 0) {
            // We get here if `from` is the root
            // For example: from='/'; to='/foo'
            return to.slice(toStart + i);
          }
        } else if (fromLen > length) {
          if (from.charCodeAt(fromStart + i) === 47 /*/*/) {
            // We get here if `to` is the exact base path for `from`.
            // For example: from='/foo/bar/baz'; to='/foo/bar'
            lastCommonSep = i;
          } else if (i === 0) {
            // We get here if `to` is the root.
            // For example: from='/foo'; to='/'
            lastCommonSep = 0;
          }
        }
        break;
      }
      var fromCode = from.charCodeAt(fromStart + i);
      var toCode = to.charCodeAt(toStart + i);
      if (fromCode !== toCode)
        break;
      else if (fromCode === 47 /*/*/)
        lastCommonSep = i;
    }

    var out = '';
    // Generate the relative path based on the path difference between `to`
    // and `from`
    for (i = fromStart + lastCommonSep + 1; i <= fromEnd; ++i) {
      if (i === fromEnd || from.charCodeAt(i) === 47 /*/*/) {
        if (out.length === 0)
          out += '..';
        else
          out += '/..';
      }
    }

    // Lastly, append the rest of the destination (`to`) path that comes after
    // the common path parts
    if (out.length > 0)
      return out + to.slice(toStart + lastCommonSep);
    else {
      toStart += lastCommonSep;
      if (to.charCodeAt(toStart) === 47 /*/*/)
        ++toStart;
      return to.slice(toStart);
    }
  },

  _makeLong: function _makeLong(path) {
    return path;
  },

  dirname: function dirname(path) {
    assertPath(path);
    if (path.length === 0) return '.';
    var code = path.charCodeAt(0);
    var hasRoot = code === 47 /*/*/;
    var end = -1;
    var matchedSlash = true;
    for (var i = path.length - 1; i >= 1; --i) {
      code = path.charCodeAt(i);
      if (code === 47 /*/*/) {
          if (!matchedSlash) {
            end = i;
            break;
          }
        } else {
        // We saw the first non-path separator
        matchedSlash = false;
      }
    }

    if (end === -1) return hasRoot ? '/' : '.';
    if (hasRoot && end === 1) return '//';
    return path.slice(0, end);
  },

  basename: function basename(path, ext) {
    if (ext !== undefined && typeof ext !== 'string') throw new TypeError('"ext" argument must be a string');
    assertPath(path);

    var start = 0;
    var end = -1;
    var matchedSlash = true;
    var i;

    if (ext !== undefined && ext.length > 0 && ext.length <= path.length) {
      if (ext.length === path.length && ext === path) return '';
      var extIdx = ext.length - 1;
      var firstNonSlashEnd = -1;
      for (i = path.length - 1; i >= 0; --i) {
        var code = path.charCodeAt(i);
        if (code === 47 /*/*/) {
            // If we reached a path separator that was not part of a set of path
            // separators at the end of the string, stop now
            if (!matchedSlash) {
              start = i + 1;
              break;
            }
          } else {
          if (firstNonSlashEnd === -1) {
            // We saw the first non-path separator, remember this index in case
            // we need it if the extension ends up not matching
            matchedSlash = false;
            firstNonSlashEnd = i + 1;
          }
          if (extIdx >= 0) {
            // Try to match the explicit extension
            if (code === ext.charCodeAt(extIdx)) {
              if (--extIdx === -1) {
                // We matched the extension, so mark this as the end of our path
                // component
                end = i;
              }
            } else {
              // Extension does not match, so our result is the entire path
              // component
              extIdx = -1;
              end = firstNonSlashEnd;
            }
          }
        }
      }

      if (start === end) end = firstNonSlashEnd;else if (end === -1) end = path.length;
      return path.slice(start, end);
    } else {
      for (i = path.length - 1; i >= 0; --i) {
        if (path.charCodeAt(i) === 47 /*/*/) {
            // If we reached a path separator that was not part of a set of path
            // separators at the end of the string, stop now
            if (!matchedSlash) {
              start = i + 1;
              break;
            }
          } else if (end === -1) {
          // We saw the first non-path separator, mark this as the end of our
          // path component
          matchedSlash = false;
          end = i + 1;
        }
      }

      if (end === -1) return '';
      return path.slice(start, end);
    }
  },

  extname: function extname(path) {
    assertPath(path);
    var startDot = -1;
    var startPart = 0;
    var end = -1;
    var matchedSlash = true;
    // Track the state of characters (if any) we see before our first dot and
    // after any path separator we find
    var preDotState = 0;
    for (var i = path.length - 1; i >= 0; --i) {
      var code = path.charCodeAt(i);
      if (code === 47 /*/*/) {
          // If we reached a path separator that was not part of a set of path
          // separators at the end of the string, stop now
          if (!matchedSlash) {
            startPart = i + 1;
            break;
          }
          continue;
        }
      if (end === -1) {
        // We saw the first non-path separator, mark this as the end of our
        // extension
        matchedSlash = false;
        end = i + 1;
      }
      if (code === 46 /*.*/) {
          // If this is our first dot, mark it as the start of our extension
          if (startDot === -1)
            startDot = i;
          else if (preDotState !== 1)
            preDotState = 1;
      } else if (startDot !== -1) {
        // We saw a non-dot and non-path separator before our dot, so we should
        // have a good chance at having a non-empty extension
        preDotState = -1;
      }
    }

    if (startDot === -1 || end === -1 ||
        // We saw a non-dot character immediately before the dot
        preDotState === 0 ||
        // The (right-most) trimmed path component is exactly '..'
        preDotState === 1 && startDot === end - 1 && startDot === startPart + 1) {
      return '';
    }
    return path.slice(startDot, end);
  },

  format: function format(pathObject) {
    if (pathObject === null || typeof pathObject !== 'object') {
      throw new TypeError('The "pathObject" argument must be of type Object. Received type ' + typeof pathObject);
    }
    return _format('/', pathObject);
  },

  parse: function parse(path) {
    assertPath(path);

    var ret = { root: '', dir: '', base: '', ext: '', name: '' };
    if (path.length === 0) return ret;
    var code = path.charCodeAt(0);
    var isAbsolute = code === 47 /*/*/;
    var start;
    if (isAbsolute) {
      ret.root = '/';
      start = 1;
    } else {
      start = 0;
    }
    var startDot = -1;
    var startPart = 0;
    var end = -1;
    var matchedSlash = true;
    var i = path.length - 1;

    // Track the state of characters (if any) we see before our first dot and
    // after any path separator we find
    var preDotState = 0;

    // Get non-dir info
    for (; i >= start; --i) {
      code = path.charCodeAt(i);
      if (code === 47 /*/*/) {
          // If we reached a path separator that was not part of a set of path
          // separators at the end of the string, stop now
          if (!matchedSlash) {
            startPart = i + 1;
            break;
          }
          continue;
        }
      if (end === -1) {
        // We saw the first non-path separator, mark this as the end of our
        // extension
        matchedSlash = false;
        end = i + 1;
      }
      if (code === 46 /*.*/) {
          // If this is our first dot, mark it as the start of our extension
          if (startDot === -1) startDot = i;else if (preDotState !== 1) preDotState = 1;
        } else if (startDot !== -1) {
        // We saw a non-dot and non-path separator before our dot, so we should
        // have a good chance at having a non-empty extension
        preDotState = -1;
      }
    }

    if (startDot === -1 || end === -1 ||
    // We saw a non-dot character immediately before the dot
    preDotState === 0 ||
    // The (right-most) trimmed path component is exactly '..'
    preDotState === 1 && startDot === end - 1 && startDot === startPart + 1) {
      if (end !== -1) {
        if (startPart === 0 && isAbsolute) ret.base = ret.name = path.slice(1, end);else ret.base = ret.name = path.slice(startPart, end);
      }
    } else {
      if (startPart === 0 && isAbsolute) {
        ret.name = path.slice(1, startDot);
        ret.base = path.slice(1, end);
      } else {
        ret.name = path.slice(startPart, startDot);
        ret.base = path.slice(startPart, end);
      }
      ret.ext = path.slice(startDot, end);
    }

    if (startPart > 0) ret.dir = path.slice(0, startPart - 1);else if (isAbsolute) ret.dir = '/';

    return ret;
  },

  sep: '/',
  delimiter: ':',
  win32: null,
  posix: null
};

posix.posix = posix;

var pathBrowserify = posix;

const withSubfolderClass = 'oz-with-subfolder';
const showAllNumbersClass = 'oz-show-all-num';
const isFolder = (item) => item.file instanceof obsidian.TFolder;
const iterateItems = (items, callback) => {
    for (const key in items) {
        if (!Object.prototype.hasOwnProperty.call(items, key))
            continue;
        callback(items[key]);
    }
};
const getParentPath = (src) => {
    if (src === '/')
        return null;
    const path = pathBrowserify.dirname(src);
    if (path === '.')
        return '/';
    else
        return path;
};
const equals = (arr1, arr2) => {
    // if the other array is a falsy value, return
    if (!Array.isArray(arr1) || !Array.isArray(arr2))
        return false;
    // compare lengths - can save a lot of time
    if (arr1.length != arr2.length)
        return false;
    return arr1.every((v, i) => v === arr2[i]);
};
const isParent = (parent, child) => {
    if (child === parent)
        return false;
    if (parent === '/')
        parent = '';
    if (child === '/')
        child = '';
    const parentTokens = parent.split('/').filter((i) => i.length);
    return parentTokens.every((t, i) => child.split('/')[i] === t);
};
// Helper to play with the File Explorer (if exists)
const doWithFileExplorer = (plugin, callback) => {
    let leaves;
    let count = 0;
    const tryGetView = () => {
        leaves = plugin.app.workspace.getLeavesOfType('file-explorer');
        if (leaves.length === 0) {
            if (count++ > 5)
                console.error('failed to get file-explorer');
            else {
                console.log('file-explorer not found, retrying...');
                setTimeout(tryGetView, 500);
            }
        }
        else {
            if (leaves.length > 1)
                console.warn('more then one file-explorer');
            callback(leaves[0].view);
        }
    };
    tryGetView();
};

function around(obj, factories) {
    const removers = Object.keys(factories).map(key => around1(obj, key, factories[key]));
    return removers.length === 1 ? removers[0] : function () { removers.forEach(r => r()); };
}
function around1(obj, method, createWrapper) {
    const original = obj[method], hadOwn = obj.hasOwnProperty(method);
    let current = createWrapper(original);
    // Let our wrapper inherit static props from the wrapping method,
    // and the wrapping method, props from the original method
    if (original)
        Object.setPrototypeOf(current, original);
    Object.setPrototypeOf(wrapper, current);
    obj[method] = wrapper;
    // Return a callback to allow safe removal
    return remove;
    function wrapper(...args) {
        // If we have been deactivated and are no longer wrapped, remove ourselves
        if (current === original && obj[method] === wrapper)
            remove();
        return current.apply(this, args);
    }
    function remove() {
        // If no other patches, just do a direct removal
        if (obj[method] === wrapper) {
            if (hadOwn)
                obj[method] = original;
            else
                delete obj[method];
        }
        if (current === original)
            return;
        // Else pass future calls through, and remove wrapper from the prototype chain
        current = original;
        Object.setPrototypeOf(wrapper, original || Function);
    }
}

const countFolderChildren = (folder, filter) => {
    let count = 0;
    for (const af of folder.children) {
        if (filter(af))
            count++;
        if (af instanceof obsidian.TFolder)
            count += countFolderChildren(af, filter);
    }
    return count;
};
/** filter out all path that is the parent of existing path */
const filterParent = (pathList) => {
    const list = Array.from(pathList);
    list.sort();
    for (let i = 0; i < list.length; i++) {
        if (i < list.length - 1 && (list[i] === list[i + 1] || isParent(list[i], list[i + 1]))) {
            list.shift();
            i--;
        }
    }
    return new Set(list);
};
/** get all parents and add to set if not exist */
const getAllParents = (path, set) => {
    let parent = getParentPath(path);
    while (parent && !set.has(parent)) {
        set.add(parent);
        parent = getParentPath(parent);
    }
};
/**
 * Update folder count of target's parent
 */
const updateCount = (targetList, plugin) => {
    const set = filterParent(targetList);
    for (const path of targetList) {
        getAllParents(path, set);
    }
    // set count of path
    const { fileExplorer, fileFilter } = plugin;
    if (!fileExplorer) {
        console.error('fileExplorer missing');
        return;
    }
    for (const path of set) {
        // check if path available
        if (!fileExplorer.fileItems[path])
            continue;
        setCount(fileExplorer.fileItems[path], fileFilter);
    }
    // Update root separately
    if (plugin.rootFolderEl && plugin.settings.addRootFolder) {
        setupRootCount(plugin);
    }
    // empty waitingList
    targetList.length = 0;
};
const setupRootCount = (plugin) => {
    if (plugin.rootFolderEl) {
        let rootFolderElChildren = plugin.rootFolderEl.children;
        if (rootFolderElChildren && rootFolderElChildren.length > 0) {
            let totalCount = countFolderChildren(plugin.app.vault.getAbstractFileByPath('/'), plugin.fileFilter);
            rootFolderElChildren[0].setAttr('data-count', totalCount.toString());
        }
    }
};
const setupCount = (plugin, revert = false) => {
    if (!plugin.fileExplorer)
        throw new Error('fileExplorer not found');
    // For each setup, first setup the root folder
    plugin.setupRootFolder();
    setupRootCount(plugin);
    // Iterate other items and include new counts
    iterateItems(plugin.fileExplorer.fileItems, (item) => {
        if (!isFolder(item))
            return;
        if (revert)
            removeCount(item);
        else
            setCount(item, plugin.fileFilter);
    });
};
const setCount = (item, filter) => {
    // if (item.file.isRoot()) return;
    const count = countFolderChildren(item.file, filter);
    item.selfEl.dataset['count'] = count.toString();
    item.selfEl.toggleClass(withSubfolderClass, Array.isArray(item.file.children) && item.file.children.some((af) => af instanceof obsidian.TFolder));
};
const removeCount = (item) => {
    if (item.selfEl.dataset['count'])
        delete item.selfEl.dataset['count'];
    item.selfEl.removeClass(withSubfolderClass);
};

class VaultHandler {
    get app() {
        return this.plugin.app;
    }
    get vault() {
        return this.plugin.app.vault;
    }
    constructor(plugin) {
        this.waitingList = [];
        this.update = obsidian.debounce(() => updateCount(this.waitingList, this.plugin), 500, true);
        this.handler = (...args) => {
            var _a;
            for (const arg of args) {
                const path = arg instanceof obsidian.TAbstractFile ? arg.path : arg;
                this.waitingList.push((_a = getParentPath(path)) !== null && _a !== void 0 ? _a : '/');
            }
            this.update();
        };
        this.registerVaultEvent = () => {
            this.plugin.registerEvent(this.vault.on('create', this.handler));
            this.plugin.registerEvent(this.vault.on('rename', this.handler));
            this.plugin.registerEvent(this.vault.on('delete', this.handler));
        };
        this.plugin = plugin;
    }
}

const DEFAULT_SETTINGS = {
    showAllNumbers: false,
    filterList: ['md'],
    blacklist: false,
    addRootFolder: false,
};
class FENoteCountSettingTab extends obsidian.PluginSettingTab {
    constructor(app, plugin) {
        super(app, plugin);
        this.plugin = plugin;
    }
    get showOnlyNoteValue() {
        const { settings } = this.plugin;
        return settings.blacklist === DEFAULT_SETTINGS.blacklist && equals(settings.filterList, DEFAULT_SETTINGS.filterList);
    }
    set showOnlyNoteValue(value) {
        const { blacklist, filterList } = DEFAULT_SETTINGS;
        this.plugin.settings.blacklist = blacklist;
        if (value) {
            // do deep copy
            this.plugin.settings.filterList = Array.from(filterList);
        }
        else {
            this.plugin.settings.filterList.length = 0;
        }
    }
    display() {
        let { containerEl } = this;
        containerEl.empty();
        containerEl.createEl('h2', {
            text: 'File Explorer Note Count Settings',
        });
        new obsidian.Setting(containerEl)
            .setName('Show All Numbers')
            .setDesc('Turn on this option if you want to see the number of notes even after you expand the collapsed folders')
            .addToggle((toggle) => toggle.setValue(this.plugin.settings.showAllNumbers).onChange((value) => {
            document.body.toggleClass('oz-show-all-num', value);
            this.plugin.settings.showAllNumbers = value;
            this.plugin.saveSettings();
        }));
        new obsidian.Setting(containerEl)
            .setName('Add Root Folder')
            .setDesc('By default, there is no root folder provided by Obsidian. It is moved to drop-down menu to switch between vaults. ' +
            'Enable this option if you want to see root folder and its count in the file explorer')
            .addToggle((toggle) => toggle.setValue(this.plugin.settings.addRootFolder).onChange((value) => {
            this.plugin.settings.addRootFolder = value;
            this.plugin.saveSettings();
            this.plugin.reloadCount();
        }));
        this.filterOpt();
    }
    filterOpt() {
        new obsidian.Setting(this.containerEl)
            .setName('Show Only Markdown Notes')
            .setDesc('Turn off this option to choose file that should be counted')
            .addToggle((toggle) => toggle.setValue(this.showOnlyNoteValue).onChange((value) => {
            this.showOnlyNoteValue = value;
            this.plugin.reloadCount();
            this.plugin.saveSettings();
            this.display();
        }));
        if (!this.showOnlyNoteValue) {
            new obsidian.Setting(this.containerEl)
                .setName('Filter List')
                .setDesc(createFragment((descEl) => {
                descEl.appendText('Extension list to include/exclude file during counting');
                descEl.appendChild(document.createElement('br'));
                descEl.appendText('Separated by comma');
            }))
                .addTextArea((text) => {
                const onChange = (value) => __awaiter(this, void 0, void 0, function* () {
                    const list = value.split(',').map((v) => v.trim());
                    this.plugin.settings.filterList = list;
                    this.plugin.reloadCount();
                    yield this.plugin.saveSettings();
                });
                text.setPlaceholder('Leave it empty to count all types of files');
                text.setValue(this.plugin.settings.filterList.join(', ')).onChange(obsidian.debounce(onChange, 500, true));
                text.inputEl.rows = 2;
                text.inputEl.cols = 25;
            });
            new obsidian.Setting(this.containerEl)
                .setName('Enable Blacklist')
                .setDesc('Turn on this option to use Filter List to exclude files')
                .addToggle((toggle) => toggle.setValue(this.plugin.settings.blacklist).onChange((value) => {
                this.plugin.settings.blacklist = value;
                this.plugin.reloadCount();
                this.plugin.saveSettings();
            }));
        }
    }
}

class FileExplorerNoteCount extends obsidian.Plugin {
    constructor() {
        super(...arguments);
        this.settings = DEFAULT_SETTINGS;
        this.vaultHandler = new VaultHandler(this);
        this.rootFolderEl = null;
        this.explorerNavHeaderSelector = '.workspace-leaf-content[data-type="file-explorer"] .nav-header';
        this.rootFolderClassName = 'oz-explorer-root-folder';
        this.initialize = (revert = false) => {
            let plugin = this;
            // First Check if the root folder exists
            let explorerHeaderEl = document.querySelector(`${this.explorerNavHeaderSelector} .${this.rootFolderClassName}`);
            if (explorerHeaderEl)
                this.rootFolderEl = explorerHeaderEl;
            const getViewHandler = (revert) => (view) => {
                this.fileExplorer = view;
                setupCount(this, revert);
                this.setupRootFolder(revert);
                if (!revert) {
                    this.registerEvent(this.app.workspace.on('css-change', this.setupRootFolder));
                    this.vaultHandler.registerVaultEvent();
                    if (this.settings.showAllNumbers)
                        document.body.addClass('oz-show-all-num');
                }
                else {
                    for (const el of document.getElementsByClassName(withSubfolderClass)) {
                        el.removeClass(withSubfolderClass);
                    }
                    document.body.removeClass(showAllNumbersClass);
                }
                if (!revert) {
                    // when file explorer is closed (workspace changed)
                    // try to update fehanlder with new file explorer instance
                    this.register(around(view, {
                        onClose: (next) => function () {
                            setTimeout(() => doWithFileExplorer(plugin, getViewHandler(false)), 1e3);
                            return next.apply(this);
                        },
                    }));
                }
            };
            doWithFileExplorer(plugin, getViewHandler(revert));
        };
        this.setupRootFolder = (revert = false) => {
            var _a, _b, _c;
            if (!this.fileExplorer) {
                console.error('file-explorer not found');
                return;
            }
            if (this.rootFolderEl && !this.settings.addRootFolder) {
                this.rootFolderEl.remove();
                this.rootFolderEl = null;
            }
            // Check if root is provided by Obsidian (it shouldn't be in the new releases)
            const root = (_c = (_b = (_a = this.fileExplorer) === null || _a === void 0 ? void 0 : _a.fileItems) === null || _b === void 0 ? void 0 : _b['/']) !== null && _c !== void 0 ? _c : null;
            if (!root) {
                // Get the Nav Header
                let explorerHeaderEl = document.querySelector(this.explorerNavHeaderSelector);
                if (!explorerHeaderEl)
                    return;
                if (!this.rootFolderEl && this.settings.addRootFolder) {
                    this.rootFolderEl = explorerHeaderEl.createEl('div', {
                        cls: ['tree-item', 'nav-folder', this.rootFolderClassName],
                    });
                    let rootTitle = this.rootFolderEl.createEl('div', {
                        cls: ['oz-explorer-root-nav-folder-title'],
                        attr: { 'data-path': '/' },
                    });
                    let titleContent = rootTitle.createEl('div', {
                        cls: ['tree-item-inner', 'nav-folder-title-content'],
                    });
                    titleContent.textContent = this.app.vault.getName();
                }
            }
        };
    }
    onload() {
        return __awaiter(this, void 0, void 0, function* () {
            console.log('loading FileExplorerNoteCount');
            this.addSettingTab(new FENoteCountSettingTab(this.app, this));
            yield this.loadSettings();
            this.app.workspace.onLayoutReady(this.initialize);
        });
    }
    onunload() {
        console.log('unloading FileExplorerNoteCount');
        this.initialize(true);
    }
    loadSettings() {
        return __awaiter(this, void 0, void 0, function* () {
            this.settings = Object.assign(Object.assign({}, this.settings), (yield this.loadData()));
        });
    }
    saveSettings() {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.saveData(this.settings);
        });
    }
    reloadCount() {
        setupCount(this);
    }
    get fileFilter() {
        let list = this.settings.filterList;
        return (af) => {
            if (af instanceof obsidian.TFile) {
                const { extension: target } = af;
                // if list is empty, filter nothing
                if (list.length === 0)
                    return true;
                else if (this.settings.blacklist)
                    return !list.includes(target);
                else
                    return list.includes(target);
            }
            else
                return false;
        };
    }
}

module.exports = FileExplorerNoteCount;

/* nosourcemap */