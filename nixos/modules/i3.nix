{pkgs, ...}: let
  mod = "Mod4";
  terminal = "${pkgs.kitty}/bin/kitty";
  appmanager = "${pkgs.rofi}/bin/rofi -show run";
  refreshI3status = "killall -SIGUSR1 i3status-rs";
  screenshotCmd = ''
    sh -c '\
      mkdir -p "$HOME/Pictures/screenshots" && \
      maim -s | tee "$HOME/Pictures/screenshots/screenshot-$(date +%F_%H-%M-%S).png" | \
      xclip -selection clipboard -t image/png -i \
    '
  '';
in {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;

      fonts = {
        names = ["JetbrainsMono Nerd Font Mono"];
        size = 8.0;
      };

      startup = [
        { command = "${pkgs.dex}/bin/dex --autostart --environment i3"; }
        { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; }
        { command = "${pkgs.dunst}/bin/dunst"; }
        { command = "${pkgs.xss-lock}/bin/xss-lock -- /etc/i3lock-custom"; }

        { command = "sleep 1 && pactl set-sink-volume alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink 40%"; }
        { command = "sleep 1 && pactl set-sink-mute alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink 1"; }
        { command = "sleep 1 && brightnessctl set 80%"; }

        { command = ''firefox -new-instance -new-window "https://app.todoist.com/app/today#" -new-tab "https://chatgpt.com/?temporary-chat=true"''; }
        { command = "1password"; }
        { command = "discord"; }
        { command = "${pkgs.i3}/bin/i3-msg 'workspace number 1'"; }
      ];

      floating.modifier = mod;

      assigns = {
        "1" = [{class = "firefox";}];
        "9" = [{class = "1Password";}];
        "10" = [{class = "discord";}];
      };

      bars = [
        {
          statusCommand = "i3status-rs ~/.config/i3status-rust/config.toml";
          fonts = {
            names = ["Jetbrains Mono"];
            size = 10.0;
          };
        }
      ];

      keybindings = {
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec ${appmanager}";

        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        "${mod}+h" = "split h";
        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";

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

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";

        "${mod}+Shift+x" = "exec --no-startup-id /etc/i3lock-custom";
        "${mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'Do you really want to shutdown the computer?' -B 'Yes, shutdown' 'shutdown now'"'';
        "${mod}+r" = "mode resize";
        "${mod}+o" = "mode launcher";

        # Audio keys
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && ${refreshI3status}";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && ${refreshI3status}";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && ${refreshI3status}";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && ${refreshI3status}";

        # Brightness keys
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +10% && ${refreshI3status}";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%- && ${refreshI3status}";

        # Screenshot
        "Print" = "exec --no-startup-id ${screenshotCmd}";
      };

      # Mode blocks
      modes = {
        resize = {
          j = "resize shrink width 10 px or 10 ppt";
          k = "resize grow height 10 px or 10 ppt";
          l = "resize shrink height 10 px or 10 ppt";
          semicolon = "resize grow width 10 px or 10 ppt";

          Left = "resize shrink width 10 px or 10 ppt";
          Down = "resize grow height 10 px or 10 ppt";
          Up = "resize shrink height 10 px or 10 ppt";
          Right = "resize grow width 10 px or 10 ppt";

          Return = "mode default";
          Escape = "mode default";
          "${mod}+r" = "mode default";
        };

        launcher = {
          t = "exec todoist-electron";
          f = "exec firefox";
          d = "exec discord";
          "1" = "exec 1password";
          s = "exec spotify";
          o = "exec obsidian";

          Return = "mode default";
          Escape = "mode default";
          "${mod}+o" = "mode default";
        };
      };
    };
    extraConfig = ''
      tiling_drag modifier titlebar
    '';
  };
}
