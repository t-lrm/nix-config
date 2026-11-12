{pkgs, ...}: {
  home.packages = with pkgs; [
    gdb
  ];

  home.file.".gdbinit".source = ./gdbinit;
}
