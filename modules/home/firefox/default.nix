{ config, pkgs, ... }: {
  programs.firefox = {
    enable = true;

    # These policies are applied across all profiles.
    # For options, see https://mozilla.github.io/policy-templates/.
    policies = {
      # Updates are done via Nix.
      AppAutoUpdate = false;
      DisableAppUpdate = true;
      ManualUpdateOnly = true;

      # Disable unwanted or unneeded Firefox features.
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisablePrivateBrowsing = true; # Incognito mode is a separate profile instead.
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;

      # Tabs
      OverrideFirstRunPage = "about:newtab";
      OverridePostUpdatePage = "about:newtab";

      # Security
      HttpsOnlyMode = "force_enabled";
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
      PrimaryPassword = false;
      DisableMasterPasswordCreation = true;

      # Other
      PromptForDownloadLocation = true;

      Permissions = {
        Camera = {
          BlockNewRequests = true;
          Locked = false;
        };
        Microphone = {
          BlockNewRequests = true;
          Locked = false;
        };
        Location = {
          BlockNewRequests = true;
          Locked = false;
        };
        Notifications = {
          BlockNewRequests = true;
          Locked = true;
        };
        Autoplay = {
          Default = "block-audio-video";
          Locked = false;
        };
        VirtualReality = {
          BlockNewRequests = true;
          Locked = false;
        };
      };

      # Similar to the `settings` attribute, controls values in `about:config`.
      # Settings here affect all profiles, so put specific settings in their respective profiles if desired.
      Preferences = with builtins;
        let
          # value : the value of the preference.
          # type  : the value type, one of: number, boolean, or string.
          # locked: If true, prevents users from modifying the preference.
          pref = value: type: locked: {
            Value = value;
            Type = type;
            Status = if locked then "locked" else "user";
          };
        in
        {
          "browser.aboutConfig.showWarning" = pref false "boolean" true;

          # Dark theme please.
          "browser.theme.content-theme" = pref 0 "number" false;
          "layout.css.prefers-color-scheme.content-override" = pref 0 "number" false;

          "browser.tabs.closeWindowWithLastTab" = pref false "boolean" false;
          "browser.newtabpage.activity-stream.showSponsored" = pref false "boolean" true;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = pref false "boolean" true;
          "browser.newtabpage.activity-stream.system.showSponsored" = pref false "boolean" true;
          "browser.newtabpage.activity-stream.feeds.topsites" = pref false "boolean" false;
          "browser.urlbar.suggest.trending" = pref false "boolean" true;

          "extensions.pocket.enabled" = pref false "boolean" true;

          "general.autoScroll" = pref true "boolean" false;

          "privacy.globalprivacycontrol.enabled" = pref true "boolean" true;

          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = pref false "boolean" true;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = pref false "boolean" true;

          # DNS over HTTPS.
          "network.trr.mode" = pref 2 "number" false;
          "network.trr.uri" = pref "https://mozilla.cloudflare-dns.com/dns-query" "string" false;
        };

      # Automatically installs extensions for all profiles.
      # shortId: URL part of the installation URL. Find it by going to the add-on store and looking in the URL: `firefox/addon/<name>`
      # uuid:    Unique extension name. Find it by installing an exension manually then visiting `about:support`.
      # forced:  If true, cannot be disabled by users and will always be enabled.
      ExtensionSettings = with builtins;
        let
          extension = shortId: uuid: forced: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = if forced then "force_installed" else "normal_installed";
            };
          };
        in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net" true)
          (extension "multi-account-containers" "@testpilot-containers" true)
          (extension "consent-o-matic" "gdpr@cavi.au.dk" true)
          (extension "darkreader" "addon@darkreader.org" false)
          (extension "sponsorblock" "sponsorBlocker@ajay.app" false)
          (extension "return-youtube-dislikes" "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" false)
          (extension "better-youtube-shorts" "{ac34afe8-3a2e-4201-b745-346c0cf6ec7d}" false)
          (extension "old-reddit-redirect" "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}" false)
          (extension "reddit-enhancement-suite" "jid1-xUfzOsOFlzSOXg@jetpack" false)
        ];
    };

    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;

      containersForce = true;
      containers = {
        personal = {
          id = 0;
          name = "Personal";
          icon = "fingerprint";
          color = "turquoise";
        };
        shopping = {
          id = 1;
          name = "Shopping";
          icon = "cart";
          color = "green";
        };
        social = {
          id = 2;
          name = "Social";
          icon = "circle";
          color = "blue";
        };
        programming = {
          id = 3;
          name = "Programming";
          icon = "briefcase";
          color = "orange";
        };
        gaming = {
          id = 4;
          name = "Gaming";
          icon = "pet";
          color = "red";
        };
        entertainment = {
          id = 5;
          name = "Entertainment";
          icon = "chill";
          color = "purple";
        };
      };

      settings = {
        # Use the system theme explicitly.
        "extensions.activeThemeID" = "default-theme@mozilla.org";

        # Restore previous session.
        "browser.startup.page" = 3;

        # Enable DRM for media, required for F1TV for example.
        "browser.media.eme.enabled" = true;

        # Privacy
        "browser.contentblocking.category" = "standard";
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "doh-rollout.disable-heuristics" = true;
      };
    };

    profiles.incognito = {
      id = 1;
      name = "Incognito";
      isDefault = false;

      search = {
        force = true;
      };

      settings = {

        # Use separate dark-gray theme to visually identify incognito profile.
        # NOTE: Requires you to manually enable the extension for now, no idea how to automate it.
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        # Privacy
        "browser.privatebrowsing.autostart" = true;
        "browser.formfill.enable" = false;
        "places.history.enabled" = false;
        "privacy.history.custom" = true;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.openWindows" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown.siteSettings" = true;
        "privacy.clearOnShutdown_v2.cache" = true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
        "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
        "privacy.clearOnShutdown_v2.siteSettings" = true;
        "privacy.query_stripping.enabled" = true;

        # Search.
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;

        # Secure DNS.
        "doh-rollout.disable-heuristics" = true;
        "network.dns.disablePrefetch" = true;
        "network.connectivity-service.DNS_HTTPS.domain" = "cloudflare-dns.com";
        "network.trr.mode" = 3;

        # Unnecessary.
        "layout.spellcheckDefault" = 0;
      };
    };
  };

  # Hyprland integration.
  wayland.windowManager.hyprland.settings = {
    bindd = [
      "SUPER        , F2, Launch Firefox.                   , exec, firefox"
      "SUPER + SHIFT, F2, Launch Firefox in private profile., exec, firefox -P Incognito"
    ];
  };
}
