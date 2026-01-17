{
  pkgs,
  vars,
  lib,
  ...
}: let
  files = [
    "${vars.dotfiles}/bash/.bashrc"
    "${vars.dotfiles}/bash/epita.bashrc"
  ];
in {
  # Bash setup (aliases/functions)
  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = lib.concatStringsSep "\n\n" (map builtins.readFile files);
  };
}
