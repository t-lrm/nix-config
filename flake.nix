{
  description = "My custom flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-index-database,
    ...
  }: let
    mkPkgs = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    mkArgs = {
      host,
      username,
      system,
    }: let
      vars = import ./hosts/variables.nix;
    in {
      inherit host username vars;
      myPkgs = self.packages.${system} or {};
    };

    mkNixosHost = {
      host,
      username,
      system,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = mkArgs {inherit host username system;};

        modules = [
          ./hosts/${host}/configuration.nix
          nix-index-database.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "home-manager-backup";

            home-manager.extraSpecialArgs =
              mkArgs {inherit host username system;};

            home-manager.users.${username} =
              import ./hosts/${host}/home.nix;
          }
        ];
      };

    mkDarwinHost = {
      host,
      username,
      system,
    }:
      nix-darwin.lib.darwinSystem {
        specialArgs = mkArgs {inherit host username system;};

        modules = [
          ./hosts/${host}/configuration.nix
          nix-index-database.darwinModules.nix-index

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "home-manager-backup";

            home-manager.extraSpecialArgs =
              mkArgs {inherit host username system;};

            home-manager.users.${username} =
              import ./hosts/${host}/home.nix;
          }
        ];
      };

    mkHome = {
      host,
      username,
      system,
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs system;

        extraSpecialArgs = mkArgs {inherit host username system;};

        modules = [
          ./hosts/${host}/home.nix
          nix-index-database.homeModules.default
        ];
      };
  in {
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

    homeConfigurations."nixos@thinkpad" = mkHome {
      host = "thinkpad";
      username = "nixos";
      system = "x86_64-linux";
    };

    homeConfigurations."baunky@macbook" = mkHome {
      host = "macbook";
      username = "baunky";
      system = "aarch64-darwin";
    };
  };
}
