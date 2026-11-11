{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        blink_interval = 750;
        style = {
          blinking = "On";
          shape = "Block";
        };
        unfocused_hollow = true;
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Regular";
        };
        size = 8;
      };
      keyboard = {
        bindings = [
          {
            action = "Paste";
            key = "V";
            mods = "Control|Shift";
          }
          {
            action = "Copy";
            key = "C";
            mods = "Control|Shift";
          }
          {
            action = "IncreaseFontSize";
            key = "Plus";
            mods = "Control";
          }
          {
            action = "DecreaseFontSize";
            key = "Minus";
            mods = "Control";
          }
          {
            action = "ResetFontSize";
            key = "Key0";
            mods = "Control";
          }
        ];
      };
      mouse = {hide_when_typing = true;};
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      window = {
        dynamic_title = true;
        opacity = 0.95;
      };
    };
  };
}
