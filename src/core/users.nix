{
  pkgs,
  username,
  ...
}: {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
    linger = true; # enable running script on startup
    initialHashedPassword = "$y$j9T$GCgx4etC0jxe70dgFiNEO1$pclGOw8/W3clravgoHFASZHg6ElgK9QD9NMMi4FMTH/";
  };
}
