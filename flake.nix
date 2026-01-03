{
  description = "My custom flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        Thinkpad = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos-configuration.nix
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
