{ ... }: {
  # Install Discord from official cask.
  homebrew.casks = [
    {
      name = "discord";
      greedy = true;
    }
  ];
}
