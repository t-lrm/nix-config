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
    (vars.services + "/virtualmachine.nix")
    (vars.services + "/fingerprint.nix")
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
  nix.settings.experimental-features = ["nix-command" "flakes"];

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
      "libvirtd"
    ];
    linger = true; # enable running script on startup
  };

  # Garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Enable a custom i3lock script in /etc folder
  environment.etc."i3lock-custom" = {
    source = vars.custom + "/i3lock-custom.sh";
    mode = "0755";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # 1Password GUI
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [username];
  };

  # Setup keyring needed by 1Password
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Enable docker
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    htop
    ipcalc
    ncdu
    wget
    tree
    git
    python3
    python3Packages.pip
    zip
    unzip
    p7zip
    gnumake
    pulseaudio

    # Used to unlock bitlocker-protected drives
    dislocker
    ntfs3g

    # OpenVPN support
    networkmanager-openvpn
    openvpn

    # Format nix file
    alejandra

    # i3 related tools
    rofi # app launcher
    i3lock-color # better i3lock
    i3status-rust # better i3status
  ];

  system.stateVersion = "25.11"; # DO NOT CHANGE
}
