{...}: {
  programs.kitty = {
    enable = true;

    themeFile = "OneHalfDark";

    font.name = "Jetbrains Mono";
    font.size = 11;

    shellIntegration.mode = "no-cursor";

    settings = {
      "adjust_baseline" = 1;
      "adjust_column_width" = 0;
      "background" = "#121317";
      "background_opacity" = "0.97";
      "box_drawing_scale" = "0.001, 1, 1.5, 2";
      "cursor_blink_interval" = 0;
      "dim_opacity" = "0.75";
      "enable_audio_bell" = false;
      "force_ltr" = false;
      "paste_actions" = "quote-urls-at-prompt,confirm";
      "placement_strategy" = "top-left";
      "scrollback_lines" = 10000;
      "scrollback_pager" = "most";
      "strip_trailing_spaces" = "always";
      "text_composition_strategy" = "legacy";
    };
  };
}
