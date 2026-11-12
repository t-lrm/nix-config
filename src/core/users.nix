{username, ...}: {
  users.users = {
    ${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      initialPassword = "nixos";
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
