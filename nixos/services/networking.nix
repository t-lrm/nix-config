{
  pkgs,
  host,
  ...
}: {
  # Configure network connections interactively with nmcli or nmtui
  networking = {
    hostName = host;
    networkmanager.enable = true;
    networkmanager.plugins = with pkgs; [
      networkmanager-openvpn
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };


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
}
