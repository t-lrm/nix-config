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
      "git/config".source = "${vars.dotfiles}/git/config";
    };
  };

  home.username = "nixos";
  home.homeDirectory = "/home/${username}";

  xdg.userDirs = {
    enable = true;
    download = "${config.home.homeDirectory}/downloads";
  };

  # Make Home Manager manage itself
  programs.home-manager.enable = true;

  imports = [
    "${vars.modules}/shell.nix"

    "${vars.programs}/git.nix"
    "${vars.programs}/ssh.nix"
    "${vars.programs}/starship.nix"
    "${vars.programs}/dunst.nix"
  ];

  services.screen-locker = {
    enable = true;
    inactiveInterval = 1;
    lockCmd = "/etc/i3lock-custom";
    xautolock.enable = true;
    xautolock.extraOptions = ["-corners" "000-" "-cornerdelay" "1" "-cornerredelay" "1" "-cornersize" "30"];
  };

  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono
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
    yazi

    # Other
    pavucontrol
    maim
    xclip # screenshots
    brightnessctl
    eza # improved ls

    (pkgs.writeShellApplication {
      name = "generate_architecture";
      runtimeInputs = [pkgs.python3];
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
