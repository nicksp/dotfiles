# Browser Setup

## Recommended configuration

### General

- Check **Open previous windows and tabs**
- Check **Always ask you where to save files**
- Check **Automatically install updates (recommended)**
- Uncheck **Recommend extensions as you browse**
- Uncheck **Recommend features as you browse**

### Home

- Turn off all the items under **Firefox Home Content**

### Search

- **Default Search Engine** — `DuckDuckGo`
- Uncheck **Show search suggestions**
- Uncheck **Show recent searches**
- Delete all **Search Engines** except for **DuckDuckGo**
- **Address Bar** → Uncheck **Search engines**

### Privacy & Security

- **Enhanced Tracking Protection** → Select **Strict** Enhanced Tracking Protection
- **Website Privacy Preferences** → Check **Tell websites not to sell or share my data**
- **Website Privacy Preferences** → Check **Send websites a “Do Not Track” request**
- **Passwords** → Uncheck **Ask to save passwords**
- **Passwords** → Uncheck **Require device sign in to fill and manage passwords**
- **Passwords** → Uncheck **Use a Primary Password**
- **Autofill** → Uncheck **Save and fill payment methods**
- Firefox Developer Edition will **Use custom settings for history**
  - Check **Remember browsing and download history** and uncheck others
- **Firefox Developer Edition Data Collection and Use** → Uncheck **Allow Firefox Developer Edition to send technical and interaction data to Mozilla**
- **Firefox Developer Edition Data Collection and Use** → Uncheck **Allow Firefox Developer Edition to make personalized extension recommendations**
- **Firefox Developer Edition Data Collection and Use** → Uncheck **Allow Firefox Developer Edition to install and run studies**
- **Firefox Developer Edition Data Collection and Use** → Uncheck **Allow Firefox Developer Edition to send backlogged crash reports on your behalf**
- **Website Advertising Preferences** → Uncheck **Allow websites to perform privacy-preserving ad measurement**
- **HTTPS-Only Mode** → Select **Enable HTTPS-Only Mode in all windows**
- **DNS over HTTPS** → Select **Max Protection** and choose a [suitable provider](https://www.privacyguides.org/en/dns/#recommended-providers)

## Install extensions

- uBlock Origin — <https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/>. Run in Private Windows
  - Setup your [blocking mode](https://github.com/gorhill/uBlock/wiki/Blocking-mode)
  - Enable `AdGuard Tracking Protection`
  - Enable `AdGuard URL Tracking Protection`
  - Enable `uBlock filters – Annoyances`
  - Import [Actually Legitimate URL Shortener Tool](https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt)
    - Check `Import…` under `Filter lists`
    - Paste in the linked URL above
    - Click `Apply changes`
- Privacy Badger <https://addons.mozilla.org/en-US/firefox/addon/privacy-badger17/>. Run in Private Windows
  - Firefox now [includes tracker blocking](https://blog.mozilla.org/security/2021/02/23/total-cookie-protection/), but I leave Privacy Badger enabled.
- React Developer Tools — <https://addons.mozilla.org/en-US/firefox/addon/react-devtools/>
- Grammar and Spell Checker - LanguageTool — <https://addons.mozilla.org/en-US/firefox/addon/languagetool/>
- Blank Sky New Tab Page — <https://addons.mozilla.org/en-US/firefox/addon/blank-sky-new-tab-page/>
- OctoLinker — <https://addons.mozilla.org/en-US/firefox/addon/octolinker/>
- Video Speed Controller − <https://addons.mozilla.org/en-US/firefox/addon/videospeed/>
- Wappalyzer — <https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/>
- Atomic CSS Devtools — <https://addons.mozilla.org/en-US/firefox/addon/atomic-css-devtools/>
