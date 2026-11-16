{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../services/networking.nix

    ../../core/nix.nix
    ../../core/common.nix
    ../../core/users.nix
  ];

  home-manager.users.${username} = import ./home.nix;

  # TODO: extract
  networking.firewall.allowedTCPPorts = [22];
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOl48v7ypMRXbHV3VSRyzajDboiCcWhAkqFiaxpItQB gaelle"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAWyLNansF0H4ah83HV8yLEGzkOA87lokK5TvpriwLAG nixos@thinkpad"
  ];

  system.stateVersion = "26.05";
}
