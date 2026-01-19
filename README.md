# nix-config

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
