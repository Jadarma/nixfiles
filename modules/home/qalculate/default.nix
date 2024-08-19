{ pkgs, ... }: {
  home.packages = with pkgs; [
    libqalculate
    qalculate-gtk
  ];

  # Hyprland integration.
  wayland.windowManager.hyprland.settings = {
    bind = [
      ", XF86Calculator, exec, qalculate-gtk"
    ];
  };
}
