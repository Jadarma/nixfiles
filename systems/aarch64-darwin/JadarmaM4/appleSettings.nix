{
  # Power
  power = {
    restartAfterFreeze = true;
    restartAfterPowerFailure = true;
    sleep = {
      allowSleepByPowerButton = true;
      computer = 60;
      display = 30;
      harddisk = "never";
    };
  };

  # MacOS Settings
  system.defaults = {
    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = -1.0;
    };

    ActivityMonitor = {
      IconType = 6;
      OpenMainWindow = true;
      ShowCategory = 102; # My Processes
      SortColumn = "% CPU";
      SortDirection = 0; # Descending
    };

    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleScrollerPagingBehavior = true;
      AppleShowScrollBars = "Always";
      AppleTemperatureUnit = "Celsius";
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSWindowShouldDragOnGesture = true;
      "com.apple.keyboard.fnState" = true;
      "com.apple.springing.delay" = 0.7;
      "com.apple.springing.enabled" = true;
      "com.apple.swipescrolldirection" = false;

      # TODO: What are these?
      AppleKeyboardUIMode = null;
      NSDisableAutomaticTermination = null;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;

      # Explicit Defaults
      AppleEnableMouseSwipeNavigateWithScrolls = true;
      AppleInterfaceStyleSwitchesAutomatically = false;
      ApplePressAndHoldEnabled = true;
      AppleSpacesSwitchOnActivate = true;
      AppleWindowTabbingMode = "fullscreen";
      NSAutomaticWindowAnimationsEnabled = true;
      NSScrollAnimationEnabled = true;
      NSTableViewDefaultSizeMode = 3;
      NSTextShowsControlCharacters = false;
      NSUseAnimatedFocusRing = true;
      NSWindowResizeTime = 0.2;
      _HIHideMenuBar = false;
      "com.apple.sound.beep.feedback" = 1;
      "com.apple.sound.beep.volume" = 0.6065307;
    };
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

    WindowManager = {
      AutoHide = true;
      EnableStandardClickToShowDesktop = false;
      EnableTiledWindowMargins = true;
      EnableTilingByEdgeDrag = true;
      EnableTilingOptionAccelerator = true;
      EnableTopTilingByEdgeDrag = true;
      GloballyEnabled = false;
      HideDesktop = false;
      StageManagerHideWidgets = false;
      StandardHideDesktopIcons = true;
      StandardHideWidgets = false;
    };

    alf = {
      allowdownloadsignedenabled = 0;
      allowsignedenabled = 1;
      globalstate = 0;
      loggingenabled = 1;
      stealthenabled = 0;
    };

    controlcenter = {
      AirDrop = false;
      BatteryShowPercentage = true;
      Bluetooth = true;
      Display = true;
      FocusModes = false;
      NowPlaying = true;
      Sound = true;
    };

    dock = {
      enable-spring-load-actions-on-all-items = true;
      appswitcher-all-displays = false;
      autohide = true;
      autohide-delay = 0.25;
      autohide-time-modifier = 1.0;
      expose-animation-duration = 1.0;
      expose-group-apps = false;
      magnification = false;
      largesize = 16;
      launchanim = true;
      mineffect = "genie";
      minimize-to-application = true;
      mouse-over-hilite-stack = true;
      mru-spaces = false;
      orientation = "bottom";
      persistent-apps = null;
      persistent-others = null;
      scroll-to-open = true;
      show-process-indicators = true;
      show-recents = false;
      showhidden = false;
      slow-motion-allowed = false;
      static-only = false;
      tilesize = 48;
      wvous-tl-corner = null;
      wvous-tr-corner = 12;
      wvous-bl-corner = null;
      wvous-br-corner = null;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = false;
      NewWindowTarget = "Home";
      QuitMenuItem = true; # yo
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = false;
      _FXSortFoldersFirst = true;
    };

    loginwindow = {
      DisableConsoleAccess = true;
      GuestEnabled = false;
      LoginwindowText = "At least it's not Windows!";
      PowerOffDisabledWhileLoggedIn = false;
      RestartDisabled = false;
      RestartDisabledWhileLoggedIn = false;
      SHOWFULLNAME = false;
      ShutDownDisabled = false;
      ShutDownDisabledWhileLoggedIn = false;
      SleepDisabled = false;
    };

    menuExtraClock = {
      FlashDateSeparators = false;
      IsAnalog = false;
      Show24Hour = true;
      ShowDate = 1;
      ShowDayOfMonth = true;
      ShowDayOfWeek = false;
      ShowSeconds = false;
    };

    screencapture = {
      disable-shadow = false;
      include-date = true;
      location = null;
      show-thumbnail = true;
      target = "clipboard";
      type = "png";
    };

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 3;
    };

    spaces.spans-displays = false;
  };

  system.startup.chime = true;
}
