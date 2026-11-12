{
  description = "My NixOS, nix-darwin, and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkSystem = import ./build/mkSystem.nix {
      inherit nixpkgs inputs;
    };
  in {
    nixosConfigurations.thinkpad = mkSystem {
      hostname = "thinkpad";
      username = "nixos";
      system = "x86_64-linux";
      type = "nixos";
    };

    darwinConfigurations.macbook = mkSystem {
      hostname = "macbook";
      username = "baunky";
      system = "aarch64-darwin";
      type = "darwin";
    };

    homeConfigurations.epita = mkSystem {
      hostname = "epita";
      username = "timothee.le-roux-maertens";
      system = "x86_64-linux";
      type = "home";
    };
  };
}
