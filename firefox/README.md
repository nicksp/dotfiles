# Firefox Setup

## Recommended configuration and UI styles

Is automated via `user.js` and `chrome/userChrome.css`. Copy them to your [Firefox profile folder](https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data) or [symlink instead](../setup/symlinks.sh).

## Install theme

- [Squirrelsong Light](https://addons.mozilla.org/en-US/firefox/addon/squirrelsong-light/)

## Install extensions

- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) — _Run in Private Windows_
  - Setup your [blocking mode](https://github.com/gorhill/uBlock/wiki/Blocking-mode)
  - Enable `AdGuard URL Tracking Protection`
  - Enable `EasyList – Cookie Notices`
  - Import [Actually Legitimate URL Shortener Tool](https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt)
    - Check `Import…` under `Filter lists`
    - Paste in the linked URL above
    - Click `Apply changes`
- [Privacy Badger](https://addons.mozilla.org/en-US/firefox/addon/privacy-badger17/) — _Run in Private Windows_
  - Firefox now [includes tracker blocking](https://blog.mozilla.org/security/2021/02/23/total-cookie-protection/), but I leave Privacy Badger enabled.
- [Bitwarden Password Manager](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/)
- [UnTrap for YouTube](https://addons.mozilla.org/en-US/firefox/addon/untrap-for-youtube/)
  - [Settings](./settings/untrap.txt)
- [Instapaper](https://addons.mozilla.org/en-US/firefox/addon/instapaper-official/)
- [EditThisCookie2](https://addons.mozilla.org/en-US/firefox/addon/etc2/)
- [Refined GitHub](https://addons.mozilla.org/en-US/firefox/addon/refined-github-/)
- [Catppuccin for Web File Explorer Icons](https://addons.mozilla.org/en-US/firefox/addon/catppuccin-web-file-icons/)
- [LanguageTool](https://addons.mozilla.org/en-US/firefox/addon/languagetool/)
- [Blank Sky New Tab Page](https://addons.mozilla.org/en-US/firefox/addon/blank-sky-new-tab-page/) — _Run in Private Windows_
- [Video Speed Controller](https://addons.mozilla.org/en-US/firefox/addon/videospeed/)
- [Obsidian Web Clipper](https://addons.mozilla.org/en-US/firefox/addon/web-clipper-obsidian/)
