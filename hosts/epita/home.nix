{
  lib,
  config,
  pkgs,
  username,
  vars,
  programs,
  ...
}: {
  xdg = {
    enable = true;
    configFile = {
      "i3status-rust/config.toml".source = "${vars.dotfiles}/i3status-rust/config.toml";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = lib.concatStringsSep "\n\n" (map builtins.readFile [
      "${vars.dotfiles}/shell/common.sh"
      "${vars.dotfiles}/shell/epita.sh"
      "${vars.dotfiles}/bash/bashrc"
    ]);
  };

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.file.".i3lock-custom" = {
      source = "${vars.custom}/i3lock-custom.sh";
      executable = true;
  };

  # Make Home Manager manage itself
  programs.home-manager.enable = true;

  imports = [
    "${vars.modules}/i3.nix"

    "${vars.programs}/vim.nix"
    "${vars.programs}/neovim.nix"
    "${vars.programs}/git.nix"
    "${vars.programs}/ssh.nix"
    "${vars.programs}/starship.nix"
    "${vars.programs}/yazi.nix"
    "${vars.programs}/kitty.nix"
    "${vars.programs}/zoxide.nix"
    "${vars.programs}/flameshot.nix"
  ];

  services.screen-locker = {
    enable = true;
    inactiveInterval = 1;
    lockCmd = "/home/${username}/.i3lock-custom";
    xautolock.enable = true;
    xautolock.extraOptions = ["-corners" "000-" "-cornerdelay" "1" "-cornerredelay" "1" "-cornersize" "30"];
  };

  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    font-awesome

    # i3 related tools
    rofi # app launcher
    i3lock-color # better i3lock
    i3status-rust # better i3status

    # Apps
    firefox
    obsidian
    vlc
    libreoffice-still
    qbittorrent

    # System tools
    htop
    ncdu
    pulseaudio
    pavucontrol
    brightnessctl

    # Tools
    tmux
    ipcalc
    wget
    tree
    exiftool
    git
    pre-commit
    clippy
    zip
    unzip
    p7zip
    ripgrep
    fd
    xclip
    eza # improved ls
    veracrypt
    yarn
    nodejs
    pipx
    direnv
    gnupg

    # Rust
    rustc
    cargo

    # Python
    python3
    python3Packages.pip
    poetry

    # C
    gnumake
    gcc
    gdb
    clang-tools.out

    # Go
    go

    # Markup languages
    jq
    yq

    # Nix
    alejandra

    # Documentation
    man-pages
    man-pages-posix
    tldr

    (pkgs.writeShellApplication {
      name = "generate_architecture";
      runtimeInputs = [pkgs.python3];
      text = ''
        exec ${pkgs.python3}/bin/python3 ${(vars.custom + "/generate_architecture.py")} "$@"
      '';
    })
  ];

  home.stateVersion = vars.stateVersion;
}
