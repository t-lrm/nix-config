{
  lib,
  config,
  pkgs,
  username,
  vars,
  programs,
  ...
}: {
  # Make Home Manager manage itself
  # programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = lib.concatStringsSep "\n\n" (map builtins.readFile [
      "${vars.dotfiles}/shell/common-aliases.sh"
      "${vars.dotfiles}/shell/common-functions.sh"
      "${vars.dotfiles}/shell/epita.sh"
      "${vars.dotfiles}/bash/bashrc"
    ]);
  };

  xdg = {
    enable = true;
    configFile = {
      "i3status-rust/config.toml".source = "${vars.dotfiles}/i3status-rust/config.toml";
      "clang-format".source = "${vars.dotfiles}/clang-format/clang-format-epita";
      "gdbinit".source = "${vars.dotfiles}/gdb/gdbinit";
    };
  };

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

  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    font-awesome

    # i3 related tools
    rofi # app launcher
    i3lock-color # better i3lock
    i3status-rust # better i3status

    # firefox

    # System tools
    # htop
    # ncdu
    # pulseaudio
    # pavucontrol

    # Tools
    # tmux
    # ipcalc
    # wget
    # tree
    # exiftool
    # git
    # pre-commit
    # clippy
    # zip
    # unzip
    # p7zip
    ripgrep
    fd
    xclip
    eza # improved ls
    # yarn
    # nodejs
    # pipx
    direnv
    # gnupg

    # C
    # gnumake
    # gcc
    # gdb
    # clang-tools.out
    colorgrind

    # Go
    go

    # Markup languages
    jq
    yq

    # Nix
    alejandra

    # Documentation
    tldr

    (pkgs.writeShellApplication {
      name = "generate_architecture";
      runtimeInputs = [pkgs.python3];
      text = ''
        exec ${pkgs.python3}/bin/python3 ${(vars.custom + "/generate_architecture.py")} "$@"
      '';
    })

    (pkgs.writeShellApplication {
      name = "i3lock-custom";
      text = ''
        exec ${(vars.custom + "/i3lock-custom-epita.sh")}
      '';
    })
  ];

  home.stateVersion = vars.stateVersion;
}
