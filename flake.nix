{
  description = "My custom flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    host = "thinkpad";
    username = "nixos";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

   vars = import ./hosts/${host}/variables.nix;

  in {
    # NixOS system configuration `nixos-rebuild switch --flake ...`
    nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit username host vars;
        myPkgs = self.packages.${system};
      };

      modules = [
        ./hosts/${host}/configuration.nix

        # Home Manager as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.backupFileExtension = "home-manager-backup";

          # Pass args into HM modules too
          home-manager.extraSpecialArgs = {
            inherit username host vars;
            myPkgs = self.packages.${system};
          };

          home-manager.users.${username} = import ./hosts/${host}/home.nix;
        }
      ];
    };

    # Standalone Home Manager output to run with `home-manager switch --flake ...`
    homeConfigurations."${username}@${host}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit username host vars;
        myPkgs = self.packages.${system};
      };

      modules = [
        ./hosts/${host}/home.nix
      ];
    };
  };
}
