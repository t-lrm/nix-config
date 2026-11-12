{pkgs, ...}: {
  programs.zsh.enable = true;

  imports = [
    ../../pkgs/default/cli.nix
    ../../pkgs/aerospace
    ../../scripts
  ];

  home = {
    sessionPath = [
      "$HOME/.local/bin" # Expose custom scripts
      "/Applications/Docker.app/Contents/Resources/bin:$PATH"
      "/Applications/Aerospace.app/bin"
      "/opt/homebrew/bin"
    ];

    sessionVariables = {
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
