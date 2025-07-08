{
  description = "My NixOS configurations";

  inputs.nixpkgs.url = "nixpkgs/nixos-24.05";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/laptop/configuration.nix ];
      };
      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/server/configuration.nix ];
      };
    };
  };
}

