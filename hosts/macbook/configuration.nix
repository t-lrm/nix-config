{
  username,
  system,
  ...
}: {
  nixpkgs.hostPlatform = "${system}";
  system.stateVersion = 6;

  users.users.${username}.home = "/Users/${username}";
  system.primaryUser = "${username}";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
}
