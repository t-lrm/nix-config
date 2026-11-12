{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;

    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      onedarkpro-nvim
      nvim-lspconfig
      (nvim-treesitter.withPlugins (parsers: [parsers.c parsers.python]))
      neogen
      fzf-lua
    ];

    initLua = lib.concatStringsSep "\n" (map builtins.readFile [
      ./config/options.lua
      ./config/lsp.lua
      ./config/keybinds.lua
    ]);
  };

  home = {
    packages = with pkgs; [
      # LSPs
      pyright
      clang-tools
      gopls
      nixd
      rust-analyzer
      yaml-language-server
      asm-lsp

      fzf
      ripgrep
      alejandra
    ];
  };
}
