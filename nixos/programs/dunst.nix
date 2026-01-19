{
  config,
  pkgs,
  lib,
  ...
}:
# As I don't know dunst enough, I've generated a script with ChatGPT.
let
  discordJump = pkgs.writeShellScript "discord-jump" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    summary="''${1-}"

    # Extract channel from: "User (#general, Text Channels)"
    chan="$(printf '%s' "$summary" | sed -n 's/.*(#\([^,)]*\).*/\1/p' | head -n1)"

    # Focus Discord window if possible (best-effort, no hard failure)
    if command -v hyprctl >/dev/null 2>&1 && [ -n "''${HYPRLAND_INSTANCE_SIGNATURE-}" ]; then
      hyprctl dispatch focuswindow "class:^(discord|Discord)$" >/dev/null 2>&1 || true
    elif command -v swaymsg >/dev/null 2>&1 && [ -n "''${SWAYSOCK-}" ]; then
      swaymsg '[app_id="discord"] focus' >/dev/null 2>&1 || swaymsg '[class="discord"] focus' >/dev/null 2>&1 || true
    elif command -v wmctrl >/dev/null 2>&1 && [ -n "''${DISPLAY-}" ]; then
      wmctrl -xa discord >/dev/null 2>&1 || wmctrl -xa Discord >/dev/null 2>&1 || true
    fi

    # If we couldn't parse a channel, just bring Discord to front and stop.
    [ -n "$chan" ] || exit 0

    # Give focus a moment to settle
    sleep 0.10

    # Jump via Discord Quick Switcher (Ctrl+K, then "#channel", Enter)
    if [ "''${XDG_SESSION_TYPE-}" = "wayland" ] && command -v wtype >/dev/null 2>&1; then
      wtype -M ctrl -k k -m ctrl
      sleep 0.05
      wtype "#$chan"
      wtype -k Return
    elif command -v xdotool >/dev/null 2>&1; then
      xdotool key --clearmodifiers ctrl+k
      sleep 0.05
      xdotool type --delay 1 "#$chan"
      xdotool key Return
    fi
  '';

  discordUnreplace = pkgs.writeShellScript "dunst-discord-unreplace" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    [ "''${DUNST_DESKTOP_ENTRY-}" = "discord" ] || exit 0

    summary="''${DUNST_SUMMARY-}"
    body="''${DUNST_BODY-}"
    urgency="''${DUNST_URGENCY-}"
    timeout="''${DUNST_TIMEOUT-}"
    icon_path="''${DUNST_ICON_PATH-}"

    # dunst -> notify-send urgency (LOW/NORMAL/CRITICAL -> low/normal/critical)
    u="normal"
    if [ -n "$urgency" ]; then
      case "''${urgency,,}" in
        low|normal|critical) u="''${urgency,,}" ;;
      esac
    fi

    # Timeout: keep digits only; otherwise let server decide
    t_args=()
    case "$timeout" in
      (""|*[!0-9]*) ;;
      (*) t_args=( -t "$timeout" ) ;;
    esac

    # Icon: prefer real file path, else fallback to themed icon "discord"
    i_arg=( -i "discord" )
    if [ -n "$icon_path" ] && [ -f "$icon_path" ]; then
      i_arg=( -i "$icon_path" )
    fi

    # Run in background so we don't block dunst rule processing
    (
      # Add an action. notify-send prints the chosen action NAME to stdout. :contentReference[oaicite:4]{index=4}
      chosen="$(${pkgs.libnotify}/bin/notify-send \
        -a "discord" \
        -u "$u" \
        "''${t_args[@]}" \
        "''${i_arg[@]}" \
        -A default=Open \
        "$summary" "$body" || true)"

      if [ "$chosen" = "default" ] || [ "$chosen" = "1" ]; then
        ${discordJump} "$summary" >/dev/null 2>&1 || true
      fi
    ) >/dev/null 2>&1 & disown
  '';
in {
  home.packages = with pkgs; [
    libnotify
    xdg-utils
    xdotool
    wmctrl
    wtype
  ];

  services.dunst = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
      size = "32x32";
    };

    settings = {
      global = {
        enable_posix_regex = true;
        notification_limit = 0;
        always_run_script = true;

        width = 360;
        origin = "top-right";
        height = "(0, 300)";
        offset = "(20, 40)";
        monitor = 0;
        follow = "mouse";

        font = "Iosevka 10";
        line_height = 2;
        corner_radius = 15;
        corners = "all";
        frame_width = 2;
        gap_size = 8;
        padding = 10;
        horizontal_padding = 12;
        separator_height = 2;

        frame_color = "#44475a";
        separator_color = "#44475a";

        format = "<b>%s</b>\\n%b";
        markup = "full";
        word_wrap = true;
        ellipsize = "end";
        alignment = "left";
        vertical_alignment = "top";
        show_age_threshold = -1;
        ignore_newline = true;
        show_indicator = false;

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = "#282a36";
        foreground = "#f8f8f2";
        default_icon = "dialog-information";
        timeout = 4;
      };

      urgency_normal = {
        background = "#282a36";
        foreground = "#f8f8f2";
        default_icon = "dialog-information";
        timeout = 8;
      };

      urgency_critical = {
        background = "#ff5555";
        foreground = "#ffffff";
        frame_color = "#ff5555";
        default_icon = "dialog-warning";
        timeout = 0;
      };

      "20-discord" = {
        desktop_entry = "discord";
        timeout = 12;
        urgency = "normal";
      };

      "21-discord-mentions" = {
        desktop_entry = "discord";
        body = "@Timothée|@Trésorerie|@here|@everyone";
        urgency = "critical";
        timeout = 0;
      };

      "99-discord-unreplace" = {
        desktop_entry = "discord";
        script = "${discordUnreplace}";

        # hide the original notification
        skip_display = true;
        history_ignore = true;
      };
    };
  };

  services.batsignal = {
    enable = true;
    extraArgs = [
      "-w" "20"  # warning at 20%  (default is 15)
      "-c" "10"  # critical at 10% (default is 5)

      # Optional, but makes matching in dunst easier:
      "-W" "Battery low"
      "-C" "Battery critical"

      # Optional: disable "danger" level if you don't want actions at ~2%
      "-d" "0"
    ];
  };

}
