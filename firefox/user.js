/* global user_pref */
// Docs: https://github.com/arkenfox/user.js/blob/master/user.js

/*****

* INDEX:

  01: STARTUP
  02: UI
  03: DEVELOPMENT
  04: SECURITY AND PERFORMANCE

*****/

// Don't show warning on about:config
user_pref('browser.aboutConfig.showWarning', false);

//////////////////
// 01: Startup  //
//////////////////

// Disable welcome notices
user_pref('browser.startup.homepage_override.mstone', 'ignore');

// Open previous windows and tabs
// 0=blank, 1=home, 2=last visited page, 3=resume previous session
user_pref('browser.startup.page', 3);

// Set new windows and new tabs pages
// about:home=Firefox Home (default), custom URL, about:blank
user_pref('browser.startup.homepage', 'about:blank');
// true=Firefox Home (default), false=blank page
user_pref('browser.newtabpage.enabled', false);

// Disable sponsored content on Firefox Home
user_pref('browser.newtabpage.activity-stream.showSponsored', false);
user_pref('browser.newtabpage.activity-stream.showSponsoredTopSites', false);
// Clear default topsites
user_pref('browser.newtabpage.activity-stream.default.sites', '');

////////////
// 02: UI //
////////////

// Minimized sidebar style
user_pref('sidebar.revamp', true);
// Hide sidebar
user_pref('sidebar.visibility', 'hide-sidebar');
// Disable annoying tooltips for tabs
user_pref('browser.tabs.hoverPreview.enabled', false);
// Enable user interaction for security by always asking where to download
user_pref('browser.download.useDownloadDir', false);
// Enable user interaction for security by always asking how to handle new mimetypes
user_pref('browser.download.always_ask_before_handling_new_types', true);
// Disable downloads panel opening on every download
user_pref('browser.download.alwaysOpenPanel', false);
// Don't add downloads to the system's "recent documents" list
user_pref('browser.download.manager.addToRecentDocs', false);
// Allow web apps to override default Firefox hotkeys
user_pref('permissions.default.shortcuts', 0);

// Configure available search shortcuts
user_pref('browser.urlbar.shortcuts.bookmarks', true);
user_pref('browser.urlbar.shortcuts.history', true);
user_pref('browser.urlbar.shortcuts.tabs', true);
user_pref('browser.urlbar.shortcuts.actions', false);

// Don't show search suggestions ahead of browsing history in address bar results
user_pref('browser.urlbar.showSearchSuggestionsFirst', false);
// Don't check whether Firefox is a default browser
user_pref('browser.shell.checkDefaultBrowser', false);
// Allow UI customizations with userChrome.css
user_pref('toolkit.legacyUserProfileCustomizations.stylesheets', true);
// Block autoplay in tabs until selected
user_pref('media.block-autoplay-until-in-foreground', true);
user_pref('media.block-play-until-document-interaction', true);
user_pref('media.block-play-until-visible', true);
// Ask for confirmation when closing a window
user_pref('browser.warnOnQuit', true);
// Ask for confirmation when closing a window with multiple tabs
user_pref('browser.tabs.warnOnClose', true);
// Set default fonts
user_pref('font.name.default.x-western', 'system-ui');
user_pref('font.name.serif.x-western', 'Charter');
user_pref('font.name.monospace.x-western', 'MonoLisa');
// Search highlight colors
user_pref('ui.textSelectAttentionBackground', '#e87da4'); // Squirrelsong Light brightPink
user_pref('ui.textSelectAttentionForeground', '#fdfdfe'); // Squirrelsong Light white
// Search highlight all colors
user_pref('ui.textHighlightBackground', '#fae1ea'); // Squirrelsong Light brightPinkLighter
user_pref('ui.textHighlightForeground', '#4c4b4e'); // Squirrelsong Light gray04

// Enforce links targeting new windows to open in a new tab instead
// 1=most recent window or tab, 2=new window, 3=new tab
user_pref('browser.link.open_newwindow', 3);

// Disable using system colors
user_pref('browser.display.use_system_colors', false);
// ??? Enable using system accent colors
user_pref('widget.non-native-theme.use-theme-accent', true);
// ??? Disable overscroll animation
user_pref('apz.overscroll.enabled', false);

/////////////////////
// 03: Development //
/////////////////////

// Enable remote debugging (useful for debugging userChrome.css)
user_pref('devtools.chrome.enabled', true);
user_pref('devtools.debugger.remote-enabled', true);
user_pref('devtools.debugger.prompt-connection', false);

//////////////////////////////////
// 04: Security and performance //
//////////////////////////////////

// Disable the macOS's geolocation service
user_pref('geo.provider.use_corelocation', false);

// Disable recommendation pane in about:addons (uses Google Analytics)
user_pref('extensions.getAddons.showPane', false);
// Disable recommendations in about:addons' Extensions and Themes panes
user_pref('extensions.htmlaboutaddons.recommendations.enabled', false);
// Disable shopping experience
// https://bugzilla.mozilla.org/show_bug.cgi?id=1840156#c0
user_pref('browser.shopping.experience2023.enabled', false);

// Disable some Telemetry, Health Reports, and Studies
user_pref('datareporting.policy.dataSubmissionEnabled', false);
user_pref('datareporting.healthreport.service.enabled', false);
user_pref('datareporting.healthreport.uploadEnabled', false);
user_pref('toolkit.telemetry.unified', false);
user_pref('toolkit.telemetry.enabled', false);
user_pref('toolkit.telemetry.server', 'data:,');
user_pref('toolkit.telemetry.archive.enabled', false);
user_pref('toolkit.telemetry.newProfilePing.enabled', false);
user_pref('toolkit.telemetry.shutdownPingSender.enabled', false);
user_pref('toolkit.telemetry.updatePing.enabled', false);
user_pref('toolkit.telemetry.bhrPing.enabled', false); // Background Hang Reporter
user_pref('toolkit.telemetry.firstShutdownPing.enabled', false);
user_pref('toolkit.telemetry.coverage.opt-out', true);
user_pref('toolkit.coverage.opt-out', true);
user_pref('toolkit.coverage.endpoint.base', '');
// Disable Firefox Home (Activity Stream) telemetry
user_pref('browser.newtabpage.activity-stream.feeds.telemetry', false);
user_pref('browser.newtabpage.activity-stream.telemetry', false);
// Disable Normandy/Shield
// Shield is a telemetry system that can push and test "recipes"
user_pref('app.normandy.enabled', false);
user_pref('app.normandy.api_url', '');
// Disable studies
user_pref('app.shield.optoutstudies.enabled', false);

// Disable "Sync and save data"
user_pref('identity.fxaccounts.enabled', false);
// Disable Pocket extension
user_pref('extensions.pocket.enabled', false);
// Disable AI chatbot
user_pref('browser.ml.chat.enabled', false);

// Disable Crash Reports
user_pref('breakpad.reportURL', '');
user_pref('browser.tabs.crashReporting.sendReport', false);
// Enforce no submission of backlogged Crash Reports
user_pref('browser.crashReports.unsubmittedCheck.autoSubmit2', false);

// Disable Network Connectivity checks
// https://bugzilla.mozilla.org/1460537
user_pref('network.connectivity-service.enabled', false);

// Disable Safe Browsing checks for downloads (remote)
user_pref('browser.safebrowsing.downloads.remote.enabled', false);

// Disable link prefetching
// https://developer.mozilla.org/docs/Web/HTTP/Link_prefetching_FAQ
user_pref('network.prefetch-next', false);
// Disable DNS prefetching
// https://developer.mozilla.org/docs/Web/HTTP/Headers/X-DNS-Prefetch-Control
user_pref('network.dns.disablePrefetch', true);
user_pref('network.dns.disablePrefetchFromHTTPS', true);
// Disable predictor / prefetching
user_pref('network.predictor.enabled', false);
user_pref('network.predictor.enable-prefetch', false);
// Disable link-mouseover opening connection to linked server
// https://news.slashdot.org/story/15/08/14/2321202/how-to-quash-firefoxs-silent-requests
user_pref('network.http.speculative-parallel-limit', 0);
// Disable mousedown speculative connections on bookmarks and history
user_pref('browser.places.speculativeConnect.enabled', false);
// Enforce no "Hyperlink Auditing" (click tracking)
// https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/
user_pref('browser.send_pings', false);

// Enable DNS over HTTPS (DoH)
// 0=default, 2=increased (TRR (Trusted Recursive Resolver) first), 3=max (TRR only), 5=off (no rollout)
// NOTE: This is primarily meant to be used when you are disconnected from a VPN service, or on devices where it's not possible or desirable to connect to the VPN.
// When you are already connected to VPN service the security benefits of using encrypted DNS is negligible and it will always be slower than using the DNS resolver on the VPN server that you are connected to.
// [1] https://hacks.mozilla.org/2018/05/a-cartoon-intro-to-dns-over-https/
// [2] https://wiki.mozilla.org/Security/DOH-resolver-policy
// [3] https://support.mozilla.org/kb/firefox-dns-over-https
// [4] https://www.eff.org/deeplinks/2020/12/dns-doh-and-odoh-oh-my-year-review-2020 ***/
user_pref('network.trr.mode', 5);
// Set DoH provider
// Choose a suitable provider at https://www.privacyguides.org/en/dns/#recommended-providers
// If you USE custom then "network.trr.uri" should be set the same
user_pref('network.trr.uri', 'https://dns.mullvad.net/dns-query');
user_pref('network.trr.custom_uri', 'https://dns.mullvad.net/dns-query');

// Disable location bar making speculative connections
// https://bugzilla.mozilla.org/1348275
user_pref('browser.urlbar.speculativeConnect.enabled', false);
// Disable location bar contextual suggestions
// https://blog.mozilla.org/data/2021/09/15/data-and-firefox-suggest/
user_pref('browser.urlbar.quicksuggest.enabled', false);
user_pref('browser.urlbar.suggest.quicksuggest.nonsponsored', false);
user_pref('browser.urlbar.suggest.quicksuggest.sponsored', false);
user_pref('browser.urlbar.suggest.topsites', false);
// Disable live search suggestions
user_pref('browser.search.suggest.enabled', false);
user_pref('browser.urlbar.suggest.searches', false);
user_pref('browser.urlbar.suggest.recentsearches', false);

// Disable urlbar trending search suggestions
user_pref('browser.urlbar.trending.featureGate', false);
// Disable urlbar suggestions
user_pref('browser.urlbar.addons.featureGate', false);
user_pref('browser.urlbar.fakespot.featureGate', false);
user_pref('browser.urlbar.mdn.featureGate', false);
user_pref('browser.urlbar.pocket.featureGate', false);
user_pref('browser.urlbar.weather.featureGate', false);
user_pref('browser.urlbar.yelp.featureGate', false);

// Remember search and form history
user_pref('browser.formfill.enable', true);

// Disable tab-to-search
// Alternatively, you can exclude on a per-engine basis by unchecking them
// in Options>Search
user_pref('browser.urlbar.suggest.engines', false);

// Disable auto-filling username & password form fields
// NOTE: Username & password is still available when you enter the field
user_pref('signon.autofillForms', false);

// Enforce no automatic authentication on Microsoft sites
user_pref('network.http.microsoft-entra-sso.enabled', false);

// Set media cache in Private Browsing to in-memory and increase its maximum size
user_pref('browser.privatebrowsing.forceMediaMemoryCache', true);
user_pref('media.memory_cache_max_size', 65536);

// Enable HTTPS-Only mode in all windows
user_pref('dom.security.https_only_mode', true);
user_pref('dom.security.https_only_mode_ever_enabled', true);
// Disable HTTP background requests
// When attempting to upgrade, if the server doesn't respond within 3 seconds,
// Firefox sends a top-level HTTP request without path in order to check if
// the server supports HTTPS or not.
// This is done to avoid waiting for a timeout which takes 90 seconds
// https://bugzilla.mozilla.org/buglist.cgi?bug_id=1642387,1660945
user_pref('dom.security.https_only_mode_send_http_background_request', false);

// Disable bypassing 3rd party extension install prompts
// https://bugzilla.mozilla.org/buglist.cgi?bug_id=1659530,1681331
user_pref('extensions.postDownloadThirdPartyPrompt', false);

// Enable ETP Strict Mode
// ETP Strict Mode enables Total Cookie Protection (TCP)
// Adding site exceptions disables all ETP protections for that site and increases the risk of
// cross-site state tracking e.g. exceptions for SiteA and SiteB means PartyC on both sites is shared
//  https://blog.mozilla.org/security/2021/02/23/total-cookie-protection/
// Add site exceptions: Urlbar>ETP Shield
// Manage site exceptions: Options>Privacy & Security>Enhanced Tracking Protection>Manage Exceptions
user_pref('browser.contentblocking.category', 'strict');

// Set "Time range to clear" for "Clear Data" and "Clear History"
// Firefox remembers your last choice. This will reset the value when you start Firefox
// 0=everything, 1=last hour, 2=last two hours, 3=last four hours, 4=today
user_pref('privacy.sanitize.timeSpan', 0);

// Disable saving passwords
// NOTE: This does not clear any passwords already saved
user_pref('signon.rememberSignons', false);

// Form Autofill
// https://wiki.mozilla.org/Firefox/Features/Form_Autofill
// Disable saving and filling addresses
user_pref('extensions.formautofill.addresses.enabled', false);
// Disable saving and filling payment methods
user_pref('extensions.formautofill.creditCards.enabled', false);

// Enforce Firefox extension blocklist, which includes updates for "revoked certificates"
// https://blog.mozilla.org/security/2015/03/03/revoking-intermediate-certificates-introducing-onecrl/
user_pref('extensions.blocklist.enabled', true);
// Enforce no referer spoofing
user_pref('network.http.referer.spoofSource', false);
// Enforce a security delay on some confirmation dialogs such as install, open/save
// https://www.squarefree.com/2004/07/01/race-conditions-in-security-dialogs/
user_pref('security.dialog_enable_delay', 1000);
// Enforce no First Party Isolation
// WARNING: Replaced with network partitioning (FF85+) and TCP
user_pref('privacy.firstparty.isolate', false);
// Enforce SmartBlock shims (about:compat)
// https://blog.mozilla.org/security/2021/03/23/introducing-smartblock/
user_pref('extensions.webcompat.enable_shims', true);
// Enforce no TLS 1.0/1.1 downgrades
user_pref('security.tls.version.enable-deprecated', false);
// Enforce disabling of Web Compatibility Reporter to prevent wasting Mozilla's time with a custom setup
// Web Compatibility Reporter adds a "Report Site Issue" button to send data to Mozilla
user_pref('extensions.webcompat-reporter.enabled', false);
// Enforce Quarantined Domains
// https://support.mozilla.org/kb/quarantined-domains
user_pref('extensions.quarantinedDomains.enabled', true);

// Disable search terms in the address bar on results page
// Show full search URL instead
user_pref('browser.urlbar.showSearchTerms.enabled', false);
// Don't recommend extensions as you browse
user_pref('browser.newtabpage.activity-stream.asrouter.userprefs.cfr', false);
user_pref(
  'browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons',
  false
);
// Don't recommend features as you browse
user_pref(
  'browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features',
  false
);
