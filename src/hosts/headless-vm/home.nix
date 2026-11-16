{pkgs, ...}: {
  programs = {
    bash.enable = true;
  };

  imports = [
    ../../pkgs/default/cli.nix
  ];

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 1;
  };

  home.stateVersion = "26.05";
}
