{
  description = "My NixOS laptop configuration";

  inputs.nixpkgs.url = "nixpkgs/nixos-24.05";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ /home/baunky/Documents/Github/nix-config ];
      };
    };
  };
}

