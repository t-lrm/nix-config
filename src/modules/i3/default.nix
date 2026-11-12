{pkgs, ...}: {
  imports = [
    ../../pkgs/kitty.nix
    ../../pkgs/yazi.nix
    ../../pkgs/flameshot.nix
    ../../pkgs/i3status-rust

    ./keybindings.nix
    ./modes.nix
    ./startup.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    rofi
    dunst
  ];

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "Mod4";
      terminal = "i3-sensible-terminal";
      menu = "${pkgs.rofi}/bin/rofi -show run";

      fonts = {
        names = ["JetbrainsMono Nerd Font Mono"];
        size = 8.0;
      };

      floating.modifier = "Mod4";

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
    };

    extraConfig = ''
      tiling_drag modifier titlebar
    '';
  };
}
