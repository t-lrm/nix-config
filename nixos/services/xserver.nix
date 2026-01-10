{pkgs, ...}: {
  # Enable the X11 windowing system
  services.xserver = {
    enable = true;

    # Setup US/FR keyboard layout
    xkb = {
      layout = "us,fr";
      options = "grp:alt_shift_toggle";
    };

    desktopManager.xterm.enable = false;

    windowManager.i3 = {
      enable = true;
    };
  };
}
