{pkgs, ...}: {
  programs = {
    bash.enable = true;
    git.settings.commit.gpgsign = false;
  };

  imports = [
    ../../modules/i3

    ../../services/screen-locker.nix

    ../../pkgs/default/cli.nix
    ../../pkgs/default/graphical.nix

    ../../scripts
  ];

  home.packages = with pkgs; [
    # FIXME
  ];

  home.stateVersion = "FIXME";
}
