{
  config,
  pkgs,
  username,
  vars,
  ...
}: {
  xdg = {
    enable = true;
    configFile = {
      "i3/config".source = "${vars.dotfiles}/i3/config";
      "i3status-rust/config.toml".source = "${vars.dotfiles}/i3status-rust/config.toml";
      "alacritty/alacritty.toml".source = "${vars.dotfiles}/alacritty/alacritty.toml";
    };
  };

  home.username = "nixos";
  home.homeDirectory = "/home/${username}";

  # Make Home Manager manage itself
  programs.home-manager.enable = true;

  imports = [
    "${vars.modules}/shell.nix"

    "${vars.programs}/git.nix"
    "${vars.programs}/ssh.nix"
    "${vars.programs}/starship.nix"
  ];

  home.packages = with pkgs; [
    # Fonts
    jetbrains-mono
    font-awesome

    # Apps
    alacritty
    firefox
    google-chrome
    obsidian
    discord
    vlc
    libreoffice-still
    vscode
    spotify
    todoist-electron

    # Other
    pavucontrol
    maim
    xclip # screenshots
    dunst
    libnotify # notification manager
    brightnessctl

    # i3 related tools
    rofi # app launcher
    i3lock-color # better i3lock
    i3status-rust # better i3status

    (pkgs.writeShellApplication {
        name = "generate_architecture";
        runtimeInputs = [ pkgs.python3 ];
        text = ''
        exec ${pkgs.python3}/bin/python3 ${(vars.custom + "/generate_architecture.py")} "$@"
        '';
    })
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.stateVersion = vars.stateVersion;
}
