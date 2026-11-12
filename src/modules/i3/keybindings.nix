{
  config,
  lib,
  pkgs,
  ...
}: let
  i3 = config.xsession.windowManager.i3.config;
  mod = i3.modifier;

  refreshStatus = "killall -SIGUSR1 i3status-rs";

  directions = {
    j = "left";
    k = "down";
    l = "up";
    semicolon = "right";
  };

  directionBindings = lib.listToAttrs (
    lib.concatLists (
      lib.mapAttrsToList (key: direction: [
        (lib.nameValuePair "${mod}+${key}" "focus ${direction}")
        (lib.nameValuePair "${mod}+Shift+${key}" "move ${direction}")
      ])
      directions
    )
  );
in {
  xsession.windowManager.i3.config.keybindings =
    directionBindings
    // {
      # General
      "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
      "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi";

      "${mod}+Shift+c" = "reload";
      "${mod}+Shift+r" = "restart";

      # Applications
      "${mod}+y" = "exec ${i3.terminal} -e ${pkgs.yazi}/bin/yazi";

      # Session
      "${mod}+Shift+x" = "exec --no-startup-id i3lock-custom";
      "${mod}+Shift+e" = ''exec i3-nagbar -t warning -m 'Do you really want to shutdown the computer?' -B 'Yes, shutdown' 'shutdown now' '';

      # Modes
      "${mod}+o" = "mode launcher";

      # Audio
      "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && ${refreshStatus}";
      "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && ${refreshStatus}";
      "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && ${refreshStatus}";
      "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && ${refreshStatus}";

      # Brightness
      "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +10% && ${refreshStatus}";
      "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%- && ${refreshStatus}";

      # Screenshot
      "Print" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui";
    };
}
