const { Plugin } = require('obsidian');

module.exports = class AutoH1Plugin extends Plugin {
	async onload() {
		this.registerEvent(
			this.app.vault.on('rename', async (file, oldPath) => {
				if (file.extension === 'md') {
					const content = await this.app.vault.read(file);
					
					if (content.trim() === '' || content.trim() === '# Untitled') {
						const filename = file.basename;
						const capitalized = filename.charAt(0).toUpperCase() + filename.slice(1);
						await this.app.vault.modify(file, `# ${capitalized}\n\n`);
					}
				}
			})
		);
	}
	
	onunload() {}
};