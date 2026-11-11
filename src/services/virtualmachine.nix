{
  config,
  pkgs,
  ...
}: {
  # Run `virt-manager` to manage virtual machines
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Needed for libvirt's default NAT network (DHCP/DNS)
  environment.systemPackages = with pkgs; [dnsmasq];
}
