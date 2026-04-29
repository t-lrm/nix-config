{
  lib,
  pkgs,
  username,
  vars,
  ...
}: {
  home.username = username;
  home.homeDirectory = "/Users/${username}"; # obsolete ?

  home.stateVersion = "25.11";

  programs.zsh = {
    enable = true;
    initContent = lib.concatStringsSep "\n\n" (map builtins.readFile [
      "${vars.dotfiles}/shell/common.sh"
      "${vars.dotfiles}/shell/epita.sh"
      "${vars.dotfiles}/zsh/zshrc"
    ]);
  };

  imports = [
    "${vars.programs}/vim.nix"
    "${vars.programs}/neovim.nix"
    "${vars.programs}/git.nix"
    "${vars.programs}/ssh.nix"
    "${vars.programs}/starship.nix"
    "${vars.programs}/yazi.nix"
    "${vars.programs}/kitty.nix"
    "${vars.programs}/zoxide.nix"
  ];

  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono
    font-awesome

    # Apps
    firefox
    #tor-browser
    obsidian
    #vlc
    #libreoffice-still
    vscode
    ollama
    claude-code

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
    eza # improved ls

    # Rust
    rustc
    cargo

    # Python
    python3
    python3Packages.pip

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
  ];
}
