{pkgs, ...}: {
  programs.zsh.enable = true;

  imports = [
    ../../pkgs/default/workstation.nix

    ../../pkgs/aerospace
    ../../pkgs/neovim.nix
    ../../pkgs/emacs.nix
    ../../pkgs/git.nix
    ../../pkgs/ssh.nix
    ../../pkgs/starship.nix
    ../../pkgs/yazi.nix
    ../../pkgs/kitty.nix
    ../../pkgs/zoxide.nix
    ../../pkgs/direnv.nix
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
      inetutils # Specific for GNS3 (provide telnet)
    ];

    stateVersion = "26.05";
  };
}
