{
  nixpkgs,
  inputs,
}: {
  hostname,
  username,
  system,
  type,
}: let
  hm = inputs.home-manager;

  hostDir = ../src/hosts + "/${hostname}";
  systemConfig = hostDir + "/configuration.nix";
  homeConfig = hostDir + "/home.nix";

  specialArgs = {
    inherit inputs hostname username system;
  };

  homeManagerModule = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "home-manager-backup";

      extraSpecialArgs = specialArgs;
      users.${username} = homeConfig;
    };
  };
in
  if type == "nixos"
  then
    nixpkgs.lib.nixosSystem {
      inherit system specialArgs;

      modules = [
        systemConfig
        hm.nixosModules.home-manager
        homeManagerModule
      ];
    }
  else if type == "darwin"
  then
    inputs.nix-darwin.lib.darwinSystem {
      inherit system specialArgs;

      modules = [
        systemConfig
        hm.darwinModules.home-manager
        homeManagerModule
      ];
    }
  else if type == "home"
  then
    hm.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = specialArgs;

      modules = [
        homeConfig
      ];
    }
  else throw "Unsupported system type: ${type}"
