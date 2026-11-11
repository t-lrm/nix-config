{pkgs, ...}: {
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono
    font-awesome

    # Graphical Applications
    firefox
    chromium
    tor-browser
    spotify
    discord
    vlc
    obsidian
    ollama
    libreoffice-still
    qbittorrent

    # CLI Tools
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
