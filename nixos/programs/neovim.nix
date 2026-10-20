{
  pkgs,
  lib,
  vars,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      onedarkpro-nvim
      nvim-lspconfig
      (nvim-treesitter.withPlugins (parsers: [parsers.c parsers.python]))
      neogen
      fzf-lua
    ];

    extraLuaConfig = lib.concatStringsSep "\n" (map builtins.readFile [
      "${vars.dotfiles}/neovim/options.lua"
      "${vars.dotfiles}/neovim/lsp.lua"
      "${vars.dotfiles}/neovim/keybinds.lua"
    ]);
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    bat
    pyright
    clang-tools
    bear # run `bear -- make -B` to include compilation flag into LSP
    gopls
    nixd
    rust-analyzer
    yaml-language-server
    ruff
    black
    python3
    python3Packages.pytest
  ];
}
