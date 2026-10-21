
{
  pkgs,
  lib,
  username,
  host,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # System
  networking.hostName = host;
  nixpkgs.hostPlatform = "x86_64-linux";

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  # UTM with UEFI firmware
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Network: DHCP through UTM
  networking.useDHCP = lib.mkDefault true;
  networking.firewall.enable = true;

  # SSH server
  services.openssh = {
    enable = true;
    openFirewall = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # User account
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel"];

    openssh.authorizedKeys.keyFiles = [
      ./authorized_keys
    ];
  };

  # Convenience for an isolated development VM
  security.sudo.wheelNeedsPassword = false;

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # x86-64 assembly and debugging tools
  environment.systemPackages = with pkgs; [
    vim
    git
    gcc
    binutils
    gdb
    nasm
    strace
    gnumake
    file
  ];

  # DO NOT EDIT MANUALLY
  system.stateVersion = "25.11";
}

