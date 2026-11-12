{pkgs, ...}: {
  imports = [
    ../shell
    ../clang-format
    ../eza.nix
    ../neovim
    ../emacs.nix
    ../git.nix
    ../ssh.nix
    ../starship.nix
    ../yazi.nix
    ../kitty.nix
    ../zoxide.nix
    ../direnv.nix
  ];

  home.packages = with pkgs; [
    # Common
    tmux
    ipcalc
    wget
    tree
    exiftool
    pre-commit
    clippy
    zip
    unzip
    p7zip
    ripgrep
    fd
    xclip
    eza
    direnv
    gnupg

    # Rust
    rustc
    cargo

    # Python
    python3
    python3Packages.pip
    python3Packages.ipython
    poetry

    # C
    gnumake
    gcc
    clang-tools.out
    colorgrind

    # Go
    go

    # Shell
    shellcheck

    # Markup languages
    jq
    yq

    # Nix
    alejandra

    # Documentation
    man-pages-posix
    man-pages
    tldr
  ];
}
