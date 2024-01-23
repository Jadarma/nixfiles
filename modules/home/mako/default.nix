{ pkgs, config, ... }: {
  services.mako = {
    enable = true;

    # Limit the number of visible notifications.
    maxVisible = 10;

    # Sort notifications by most recent first.
    sort = "-time";

    # Do not expire notifications that did not set a timeout.
    defaultTimeout = 0;

    # Default notification appearance.
    anchor = "top-right";
    width = 400;
    height = 150;
    margin = "25";
    padding = "10";
    layer = "top";
    font = "monospace 10";
    borderSize = 2;
    borderRadius = 0;
    icons = true;
    markup = true;

    # TODO: Use color scheme variables for the colors.
    extraConfig = ''
      max-history=10
      on-button-left=invoke-default-action
      on-button-middle=dismiss-group
      on-button-right=dismiss
      on-touch=dismiss

      [mode=do-not-disturb]
      invisible=1

      [urgency=low]
      background-color=#263238
      text-color=#B0BEC5
      border-color=#314549
      default-timeout=10000

      [urgency=normal]
      background-color=#222d32
      text-color=#B0BEC5
      border-color=#16A085

      [urgency=critical]
      background-color=#263238
      text-color=#EAEAEA
      border-color=#FF5370
      ignore-timeout=1
      default-timeout=0
    '';
  };
}
