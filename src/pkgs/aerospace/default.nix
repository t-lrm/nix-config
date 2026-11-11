{pkgs, ...}: {
  home.packages = with pkgs; [
    aerospace
  ];

  xdg.configFile."aerospace/aerospace.toml".source = ./config.toml;
}
