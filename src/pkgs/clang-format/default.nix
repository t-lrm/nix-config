{pkgs, ...}: {
  home.packages = with pkgs; [
    clang-tools
  ];

  home.file.".clang-format".source = ./clang-format-epita;
}
