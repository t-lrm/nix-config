{
  hostname,
  username,
  system,
  ...
}: {
  imports = [
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs = {
    hostPlatform = system;
    config.allowUnfree = true;
  };

  users.users.${username}.home = "/Users/${username}";
  system.primaryUser = username;

  networking = {
    hostName = hostname;
    localHostName = hostname;
    computerName = hostname;
  };

  system.stateVersion = 6;
}
