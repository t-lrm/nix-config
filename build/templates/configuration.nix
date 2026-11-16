{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../core/nix.nix
    ../../core/common.nix
    ../../core/users.nix

    ../../services
  ];

  home-manager.users.${username} = import ./home.nix;

  system.stateVersion = "FIXME";
}
