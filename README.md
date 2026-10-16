# nix-config

## Setup new machine

When setting up a new configuration for a NixOS machine, you can use this script to quickly load a configuration:
```sh
cp -r hosts/thinkpad new-config
nixos sudo nixos-generate-config --show-hardware-config > hosts/new-config
```

Then you can add this code in `flake.nix`:
```nix
nixosConfigurations.new-machine = mkNixosHost {
  host = "new-machine";
  username = "nixos";
  system = "x86_64-linux";
};
```

And finally:
```
git add hosts/new-machine flake.nix
sudo nixos-rebuild switch --flake .#new-machine
```
