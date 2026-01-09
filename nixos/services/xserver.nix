{pkgs, ...}: {
  # Install the local custom lock script into /etc so xautolock can call it
  environment.etc."i3lock" = {
    source = ./lock;
    mode = "0755";
  };

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

  # Auto lock computer after 5 minutes of inactivity
  services.xserver.xautolock = {
    enable = true;
    time = 5;
    locker = "/etc/i3lock";
    extraOptions = [
      "-detectsleep"

      # When the cursor is placed in the bottom-right corner, it disable locking
      "-corners"
      "000-"
      "-cornerdelay"
      "1"
      "-cornerredelay"
      "1"
      "-cornersize"
      "30"
    ];
  };
}
