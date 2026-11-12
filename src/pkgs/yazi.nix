{...}: {
  programs.yazi = {
    enable = true;

    settings = {
      mgr = {
        sort_dir_fisrt = true;
        show_hidden = true;
        show_symlink = true;
      };
    };
  };
}
