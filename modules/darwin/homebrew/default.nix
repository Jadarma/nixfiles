{ ... }: {

  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";

    caskArgs = {
      appdir = "~/Applications";
      require_sha = true;
    };
  };

  environment.variables = {
    HOMEBREW_NO_ANALYTICS = "1";
  };
}
