{pkgs, ...}: {
  programs = {
    bash.enable = true;
  };

  imports = [
    ../../modules/i3

    ../../pkgs/shell
    ../../pkgs/clang-format
    ../../pkgs/eza.nix
    ../../pkgs/neovim
    ../../pkgs/emacs.nix
    ../../pkgs/git.nix
    ../../pkgs/ssh.nix
    ../../pkgs/starship.nix
    ../../pkgs/yazi.nix
    ../../pkgs/kitty.nix
    ../../pkgs/zoxide.nix
    ../../pkgs/direnv.nix
    ../../pkgs/gdb

    ../../services/screen-locker.nix

    ../../scripts
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    direnv
    gnupg
    xclip

    # Rust
    rustc
    cargo

    # Python
    poetry

    # C
    colorgrind

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

  home.stateVersion = "26.05";
}
