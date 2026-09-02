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
    (vars.services + "/virtualmachine.nix")
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
    initialHashedPassword = "$y$j9T$GCgx4etC0jxe70dgFiNEO1$pclGOw8/W3clravgoHFASZHg6ElgK9QD9NMMi4FMTH/";
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

  # Setup keyring needed by 1Password
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Enable docker
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };

  programs.nix-index-database.comma.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = "25.11"; # DO NOT CHANGE
}
