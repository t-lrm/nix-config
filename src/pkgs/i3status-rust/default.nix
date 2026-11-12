{...}: {
  programs.i3status-rust = {
    enable = true;
    bars = {};
  };

  xdg.configFile."i3status-rust/config.toml".source = ./config.toml;
}
