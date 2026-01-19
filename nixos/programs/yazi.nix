{...}: {
  programs.yazi = {
    enable = true;

    settings = {
      manager = {
        #sort_by "natural";
        #sort_sensitive = false;
        #sort_dir_fisrt = true;
        #sort_translit = true;
        show_hidden = true;
        show_symlink = true;
      };
    };
  };
}
