const obsidian = require('obsidian');

const VIEW_TYPE = 'awlc-gallery-view';

class GalleryView extends obsidian.ItemView {
  constructor(leaf) {
    super(leaf);
  }

  getViewType() {
    return VIEW_TYPE;
  }

  getDisplayText() {
    return 'Gallery view';
  }

  getIcon() {
    return 'image-file';
  }

  async onOpen() {
    const container = this.containerEl.children[1];

    container.empty();
    container.classList.add('gallery');

    const vaultFiles = this.app.vault.getFiles();
    const imageFiles = vaultFiles
      .filter((vaultFile) =>
        vaultFile.extension === 'png' ||
        vaultFile.extension === 'jpeg' ||
        vaultFile.extension === 'jpg' ||
        vaultFile.extension === 'webp'
      )
      .sort((a, b) =>
        // Sort so newer files appear at the top
        a.stat.mtime > b.stat.mtime ? -1 : 1
      );

    for (const image of imageFiles) {
      const imageEl = container.createEl(
        'img', {
          attr: { src: this.app.vault.adapter.getResourcePath(image.path) }
        }
      );

      imageEl.onClickEvent(() => {
        this.app.workspace.getUnpinnedLeaf().openFile(image);
      });
    }
  }
};

class GalleryPlugin extends obsidian.Plugin {
  async onload() {
    this.registerView(VIEW_TYPE, (leaf) => new GalleryView(leaf));

    // Toggle open/close, could we switch also?
    this.addRibbonIcon('image-file', 'Open gallery', () => {
      if (this.hasGalleryTab()) {
        this.closeGallery();
      } else {
        this.openGallery();
      }
    });

    this.addCommand({
      id: 'open-gallery',
      name: 'Open gallery',
      callback: () => {
        if (this.hasGalleryTab()) {
          this.switchToGalleryTab();
        } else {
          this.openGallery();
        }
      }
    });
  }

  async onunload() {
    closeGallery();
  }

  hasGalleryTab() {
    return this.app.workspace.getLeavesOfType(VIEW_TYPE).length > 0;
  }

  getGalleryTab() {
    return this.hasGalleryTab() ? this.app.workspace.getLeavesOfType(VIEW_TYPE)[0] : null;
  }

  switchToGalleryTab() {
    this.app.workspace.revealLeaf(this.getGalleryTab());
  }

  async closeGallery() {
    this.app.workspace.detachLeavesOfType(VIEW_TYPE);
  }

  async openGallery() {
    // Passing 'getLeaf(newLeaf: true)' means this will create a new view,
    // rather than an existing one -- which may blat already-open tabs.
    await this.app.workspace.getLeaf(true).setViewState({
      type: VIEW_TYPE,
      active: true
    });

    this.switchToGalleryTab();
  }
};

module.exports.__esModule = true;
module.exports.default = GalleryPlugin;
