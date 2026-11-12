{system, ...}: {
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs = {
    hostPlatform = system;
    config.allowUnfree = true;
  };
}
