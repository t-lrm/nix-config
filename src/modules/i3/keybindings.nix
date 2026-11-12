{
  config,
  pkgs,
  ...
}: let
  i3 = config.xsession.windowManager.i3.config;
  mod = i3.modifier;

  refreshStatus = "killall -SIGUSR1 i3status-rs";
in {
  xsession.windowManager.i3.config.keybindings = {
    "${mod}+1" = "workspace number 1";
    "${mod}+2" = "workspace number 2";
    "${mod}+3" = "workspace number 3";
    "${mod}+4" = "workspace number 4";
    "${mod}+5" = "workspace number 5";
    "${mod}+6" = "workspace number 6";
    "${mod}+7" = "workspace number 7";
    "${mod}+8" = "workspace number 8";
    "${mod}+9" = "workspace number 9";
    "${mod}+0" = "workspace number 10";

    "${mod}+Shift+1" = "move container to workspace number 1";
    "${mod}+Shift+2" = "move container to workspace number 2";
    "${mod}+Shift+3" = "move container to workspace number 3";
    "${mod}+Shift+4" = "move container to workspace number 4";
    "${mod}+Shift+5" = "move container to workspace number 5";
    "${mod}+Shift+6" = "move container to workspace number 6";
    "${mod}+Shift+7" = "move container to workspace number 7";
    "${mod}+Shift+8" = "move container to workspace number 8";
    "${mod}+Shift+9" = "move container to workspace number 9";
    "${mod}+Shift+0" = "move container to workspace number 10";

    "${mod}+h" = "focus left";
    "${mod}+j" = "focus down";
    "${mod}+k" = "focus up";
    "${mod}+l" = "focus right";

    "${mod}+Shift+h" = "move left";
    "${mod}+Shift+j" = "move down";
    "${mod}+Shift+k" = "move up";
    "${mod}+Shift+l" = "move right";

    "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
    "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi --show run";
    "${mod}+y" = "exec ${i3.terminal} -e ${pkgs.yazi}/bin/yazi";

    "${mod}+Shift+x" = "exec --no-startup-id i3lock-custom";
    "${mod}+Shift+e" = ''exec i3-nagbar -t warning -m 'Do you really want to shutdown the computer?' -B 'Yes, shutdown' 'shutdown now' '';

    "${mod}+Shift+c" = "reload";
    "${mod}+Shift+r" = "restart";

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
