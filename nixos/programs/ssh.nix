{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # Required to mount afs from home
    package = pkgs.openssh_gssapi;
  };
}
