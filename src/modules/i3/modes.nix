{config, ...}: let
  mod = config.xsession.windowManager.i3.config.modifier;
in {
  xsession.windowManager.i3.config.modes = {
    resize = {
      j = "resize shrink width 10 px or 10 ppt";
      k = "resize grow height 10 px or 10 ppt";
      l = "resize shrink height 10 px or 10 ppt";
      semicolon = "resize grow width 10 px or 10 ppt";

      "${mod}+r" = "mode default";
    };

    launcher = {
      t = "exec todoist-electron";
      f = "exec firefox";
      d = "exec discord";
      "1" = "exec 1password";
      s = "exec spotify";
      o = "exec obsidian";

      Return = "mode default";
      Escape = "mode default";
      "${mod}+o" = "mode default";
    };
  };
}
