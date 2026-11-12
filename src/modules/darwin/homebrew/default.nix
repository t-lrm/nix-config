{
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    user = username;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;

    brews = [
    ];

    casks = [
      "firefox"
      "ungoogled-chromium"
      "tor-browser"
      "visual-studio-code"
      "docker-desktop"
      "figma"
      "1password"
      "obsidian"
      "todoist-app"
      "libreoffice"
      "discord"
      "whatsapp"
      "spotify"
      "vlc"
      "keycastr"
      "veracrypt-fuse-t"
      "vorssaint"
      "utm"
    ];

    # Apple Store
    masApps = {
      "Goodnotes" = 1444383602;
      "WireGuard" = 1451685025;
    };

    onActivation = {
      cleanup = "none";
      autoUpdate = false;
      upgrade = false;
    };
  };
}
