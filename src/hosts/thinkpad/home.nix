{pkgs, ...}: {
  programs.bash.enable = true;

  imports = [
    ../../modules/i3

    ../../pkgs/default/cli.nix
    ../../pkgs/default/graphical.nix
    ../../pkgs/dunst.nix
    ../../pkgs/flameshot.nix
    ../../pkgs/gdb

    ../../scripts
  ];

  home.packages = with pkgs; [
    # System tools
    htop
    ncdu
    pulseaudio
    pavucontrol
    brightnessctl

    # Used to unlock bitlocker-protected drives
    dislocker
    ntfs3g

    # OpenVPN support
    networkmanager-openvpn
    openvpn
  ];

  home.stateVersion = "26.05";
}
