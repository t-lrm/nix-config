{
  description = "My NixOS, nix-darwin, and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-index-database,
      ...
    }:
    let
      mkArgs =
        {
          host,
          username,
          system,
        }:
        let
          vars = import ./hosts/variables.nix;
        in
        {
          inherit
            inputs
            host
            username
            system
            vars
            ;
          myPkgs = self.packages.${system} or { };
        };

      mkHomeManagerModule =
        {
          host,
          username,
          system,
        }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "home-manager-backup";

          home-manager.extraSpecialArgs = mkArgs { inherit host username system; };

          home-manager.users.${username} = import ./hosts/${host}/home.nix;
        };

      mkNixosHost =
        {
          host,
          username,
          system,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = mkArgs { inherit host username system; };

          modules = [
            ./hosts/${host}/configuration.nix
            nix-index-database.nixosModules.default

            home-manager.nixosModules.home-manager
            (mkHomeManagerModule { inherit host username system; })
          ];
        };

      mkDarwinHost =
        {
          host,
          username,
          system,
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = mkArgs { inherit host username system; };

          modules = [
            ./hosts/${host}/configuration.nix
            nix-index-database.darwinModules.nix-index

            home-manager.darwinModules.home-manager
            (mkHomeManagerModule { inherit host username system; })
          ];
        };
    in
    {
      nixosConfigurations.thinkpad = mkNixosHost {
        host = "thinkpad";
        username = "nixos";
        system = "x86_64-linux";
      };

      darwinConfigurations.macbook = mkDarwinHost {
        host = "macbook";
        username = "baunky";
        system = "aarch64-darwin";
      };
    };
}
