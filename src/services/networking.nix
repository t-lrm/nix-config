{hostname, ...}: {
  # Configure network connections interactively with nmcli or nmtui
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    networkmanager.plugins = [];

    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };
}
