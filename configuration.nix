{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.nixos = import ./home-manager/home.nix;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 1;

  # Configure network connections interactively with nmcli or nmtui
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

# networking.networkmanager.ensureProfiles = {
#   profiles = {
#     "Custom VPN" = {
#       connection = {
#         id = "customvpn";
#         type = "vpn";
#         autoconnect = true;
#       };
#       vpn = {
#         service-type = "org.freedesktop.NetworkManager.openvpn";
#         persistent = true;
#         config = "/etc/nixos/vpn/customvpn.ovpn";
#       };
#       ipv4.never-default = true;
#       ipv6.never-default = true;
#     };
#   };
# };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Bluetooth manager (run with blueman-manager)
  services.blueman.enable = true;

  # Audio (PipeWire, with PulseAudio compatibility)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command"  "flakes"];

  # Set your time zone
  time.timeZone = "Europe/Paris";

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
  };

  # Enable the X11 windowing system
  services.xserver = {
    enable = true;

    # Setup US/FR keyboard layout
    xkb = {
      layout = "us,fr";
      options = "grp:alt_shift_toggle";
    };

    desktopManager.xterm.enable = false;
   
    windowManager.i3 = {
      enable = true;
    };
  };

  # Auto lock computer after 5 minutes of inactivity
  services.xserver.xautolock = {
    enable = true;
    time = 5;
    locker = "${pkgs.i3lock}/bin/i3lock"; # TODO: use custom lock screen
    extraOptions = [
      "-detectsleep"

      # When the cursor is placed in the bottom-right corner, it disable locking
      "-corners" "000-"
      "-cornerdelay" "1"
      "-cornerredelay" "1"
      "-cornersize" "30"
    ];
  };

  # Define user accounts ("wheel" is the sudo group)
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

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
    polkitPolicyOwners = [ "nixos" ]; # this makes system auth etc. work properly
  };

  # Setup keyring needed by 1Password
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
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
  ];

  system.stateVersion = "25.11"; # DO NOT CHANGE
}

