{pkgs, ...}: {
  networking.hostName = "nixos-headless";
  networking.useDHCP = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.admin = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOl48v7ypMRXbHV3VSRyzajDboiCcWhAkqFiaxpItQB gaelle"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAWyLNansF0H4ah83HV8yLEGzkOA87lokK5TvpriwLAG nixos@thinkpad"
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    vim
    emacs
    git
    htop
    curl
    fzf
    ripgrep
  ];
}
