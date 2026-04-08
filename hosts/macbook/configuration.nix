{
  pkgs,
  username,
  lib,
  vars,
  ...
}: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;

  users.users.${username}.home = "/Users/${username}";
  system.primaryUser = "${username}";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    interactiveShellInit = lib.concatStringsSep "\n\n" (map builtins.readFile ["${vars.dotfiles}/bash/.bashrc" "${vars.dotfiles}/bash/epita.bashrc"]);
  };

  system.defaults = {
    dock.autohide = true;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
  };
}
