{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
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

  networking.networkmanager.ensureProfiles = {
    profiles = {
      "Custom VPN" = {
        connection = {
          id = "customvpn";
          type = "vpn";
          autoconnect = true;
        };
        vpn = {
          service-type = "org.freedesktop.NetworkManager.openvpn";
          persistent = true;
          config = "/etc/nixos/vpn/customvpn.ovpn";
        };
        ipv4.never-default = true;
        ipv6.never-default = true;
      };
    };
  };

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

  # Install fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      jetbrains-mono
      font-awesome
    ];
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
      extraPackages = with pkgs; [
        rofi # app launcher
        i3lock-color # custom i3lock screen
        i3status-rust # setup status bar
      ];
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Setup bashrc
  programs.bash = {
    enable = true;
    completion.enable = true;

    interactiveShellInit = ''
      # --- Aliases ---
      
      # Basic shortcuts
      alias ll='ls -alF --color=auto'
      alias la='ls -A --color=auto'
      alias l='ls -CF --color=auto'
      alias ..='cd ..'
      alias ...='cd ../..'
      alias t3='tree . -I "obj|bin|.idea|.git" -a'

      # Git shortcuts
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit -m'
      alias gp='git push'
      alias gpt='git push --follow-tags'
      alias gt='git tag -ma'
      alias gd='git diff'
      
      # Python virtualenv helper
      alias venv='source .venv/bin/activate'
      
      # --- Functions ---
      
      # Quick mkcd - make directory and cd into it
      mkcd () {
          mkdir -p "$1" && cd "$1"
      }
      
      # Copy text to clipboard
      cb () {
          xclip -selection clipboard < "$1"
      }
      
      # Run clang-format on a whole repo
      formatc() {
        find . -iname '*.h' -o -iname '*.c' | xargs clang-format -i
      }
    '';
  };

  # Custom bash prompt
  programs.starship = {
    enable = true;

    settings = {
      format = "$username$hostname$directory$git_branch$character";

      username = {
        show_always = true;
        format = "$user@";
      };

      hostname = {
        ssh_only = false;
        format = "$hostname";
      };

      directory = {
        format = " [$path]($style)";
      };

      git_branch = {
        format = " [$symbol$branch]($style)";
      };

      character = {
        format = " $symbol ";
        success_symbol = "➜";
        error_symbol = "✗";
      };
    };
  };

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
    firefox
    google-chrome
    python3
    python3Packages.pip
    obsidian
    discord
    zip
    unzip
    gnumake
    vlc
    libreoffice-still
    vscode
    spotify
    alacritty
    pavucontrol # audio manager
    maim # screenshots
    xclip
    dunst # notification manager
    libnotify
    pulseaudio
    brightnessctl
    todoist-electron
    #rustdesk-flutter
    # OpenVPN support
    networkmanager-openvpn
    openvpn
  ];

  system.stateVersion = "25.11"; # DO NOT CHANGE
}

