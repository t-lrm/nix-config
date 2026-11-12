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

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 1;
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
  };

  # 1Password GUI
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [username];
  };

  # Setup keyring needed by 1Password
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Enable docker
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  system.stateVersion = "26.05";
}
