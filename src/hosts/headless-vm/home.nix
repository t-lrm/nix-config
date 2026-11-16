{pkgs, ...}: {
  programs = {
    bash.enable = true;
  };

  imports = [
    ../../pkgs/default/cli.nix
  ];

  home.stateVersion = "26.05";
}
