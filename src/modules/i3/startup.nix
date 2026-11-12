{pkgs, ...}: {
  xsession.windowManager.i3.config.startup = map (command: {inherit command;}) [
    # System
    "${pkgs.dex}/bin/dex --autostart --environment i3"
    "${pkgs.networkmanagerapplet}/bin/nm-applet"
    "${pkgs.dunst}/bin/dunst"

    # Audio and brightness
    "sleep 1 && pactl set-sink-volume @DEFAULT_SINK@ 40%"
    "sleep 1 && pactl set-sink-mute @DEFAULT_SINK@ 1"
    "sleep 1 && brightnessctl set 80%"

    # Applications
    "firefox -new-instance"

    # Workspace
    "${pkgs.i3}/bin/i3-msg 'workspace number 1'"
  ];
}
