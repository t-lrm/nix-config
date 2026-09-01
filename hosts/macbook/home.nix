{
  lib,
  pkgs,
  username,
  vars,
  programs,
  ...
}: {
  home.username = username;
  home.homeDirectory = "/Users/${username}"; # obsolete ?
  home.sessionPath = [ "$HOME/.local/bin" ];

  home.stateVersion = vars.stateVersion;

  # SSH agent used to sign commits
  programs.git.settings.gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";

  xdg = {
    enable = true;
    configFile = {
      "aerospace/aerospace.toml".source = "${vars.dotfiles}/aerospace/aerospace.toml";
    };
  };

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
    google-chrome
    obsidian
    vscode
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
    nixd

    # Documentation
    man-pages
    man-pages-posix
    tldr
  ];
}
