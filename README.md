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

## Generate hash password

You can use this command to generate a hashed password that you can integreate
in your config (with `initialHashedPassword` for example):
```sh
mkpasswd
```

## Run home-manager

When `home-manager` is not installed on your machine, you can use the following
command to run it without installing it:

```sh
nix run home-manager/release-25.11
```

## Parse config files

In Nix, when you want to convert a TOML config file into a nix file, you can run those commands in `nix repl`:
```nix
cfg = builtins.fromTOML (builtins.readFile /path/to/file.toml)
:p cfg
```

Or if you want to convert directly the code:
```nix
cfg = builtins.fromTOML ''
  [mgr]
  show_hidden = true
'';
:p cfg
```
