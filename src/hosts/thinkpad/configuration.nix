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

  users.users = {
    ${username} = {
      extraGroups = [
        "docker"
        "libvirtd"
      ];
    };
    other = {
      isNormalUser = true;
      extraGroups = [];
      initialPassword = "nixos";
    };
  };

  # TODO: extract
  # Use the systemd-boot EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 1;
  };

  # TODO: extract into a dedicated nix file
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
  };

  # TODO: extract into a 1Password nix file
  # 1Password GUI
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [username];
  };

  # TODO: extract into a 1Password nix file
  # Setup keyring needed by 1Password
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # TODO: extract into a Docker nix file
  # Enable docker
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };

  # TODO: extract
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  system.stateVersion = "26.05";
}
