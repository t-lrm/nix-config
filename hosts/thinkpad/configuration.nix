{
  config,
  lib,
  pkgs,
  username,
  host,
  vars,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    (vars.services + "/audio.nix")
    (vars.services + "/bluetooth.nix")
    (vars.services + "/networking.nix")
    (vars.services + "/xserver.nix")
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 1;
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
  };

  # Define user accounts ("wheel" is the sudo group)
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # Garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # 1Password GUI
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["nixos"]; # this makes system auth etc. work properly
  };

  # Setup keyring needed by 1Password
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Enable docker
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    wget
    tree
    vim
    git
    python3
    python3Packages.pip
    zip
    unzip
    gnumake
    pulseaudio

    # OpenVPN support
    networkmanager-openvpn
    openvpn

    # Format nix file
    alejandra
  ];

  system.stateVersion = "25.11"; # DO NOT CHANGE
}
