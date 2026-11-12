{...}: {
  programs.i3status-rust = {
    enable = true;
    bars = {};
  };

  # TODO: add build inputs

  xdg.configFile."i3status-rust/config.toml".source = ./config.toml;
}
