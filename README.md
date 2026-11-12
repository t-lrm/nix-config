# nix-config

## Setup new machine

```
make new
```

This command will:
1. add a rule to `flake.nix`
2. create a `configuration.nix` and `home.nix` in `src/hosts/[hostname]`, 
3. insert a `Makefile` rule.
