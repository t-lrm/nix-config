rec {
  # Machine-specific knobs live here.
  # Keep “global” defaults in modules, override here when needed.

  root = ../..;
  modules = ../../nixos/modules;
  programs = ../../nixos/programs;
  services = ../../nixos/services;
  custom = ../../nixos/custom;
  dotfiles = ../../dotfiles;

  hostname = "thinkpad";
  stateVersion = "25.11"; # DOT NOT CHANGE
}
