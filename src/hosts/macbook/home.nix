{
  lib,
  pkgs,
  username,
  hostname,
  ...
}: {
  programs.zsh. enable = true;

  imports = [
    ../../pkgs/aerospace

    ../../pkgs/vim.nix
    ../../pkgs/neovim.nix
    ../../pkgs/emacs.nix
    ../../pkgs/git.nix
    ../../pkgs/ssh.nix
    ../../pkgs/starship.nix
    ../../pkgs/yazi.nix
    ../../pkgs/kitty.nix
    ../../pkgs/zoxide.nix
  ];

  home = {
    sessionPath = [
      "$HOME/.local/bin" # Expose custom scripts
      "/Applications/Docker.app/Contents/Resources/bin:$PATH" # Expose docker
    ];

    sessionVariable = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LLDB_DEBUGSERVER_PATH = "/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources/debugserver";
    };

    packages = with pkgs; [
      # Fonts
      nerd-fonts.jetbrains-mono
      font-awesome

      # Apps
      firefox
      google-chrome
      obsidian
      ollama
      claude-code
      qbittorrent

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
      python3Packages.ipython
      poetry

      # C
      gnumake
      gcc
      gdb
      lldb
      clang-tools.out

      # Go
      go

      # Markup languages
      jq
      yq

      # Nix
      alejandra
      nixd

      # Shell
      shellcheck

      # Documentation
      man-pages
      man-pages-posix
      tldr

      # Specific for GNS3 (provide telnet)
      inetutils
    ];

    stateVersion = "26.05";
  };
}
