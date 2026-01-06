{
  pkgs,
  vars,
  ...
}: let
  bashrc = "${vars.dotfiles}/.bashrc";
in {
  # Bash setup (aliases/functions)
  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = builtins.readFile bashrc;
  };
}
