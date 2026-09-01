{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      onedarkpro-nvim
      {
        plugin = fzf-lua;
        type = "lua";
        config = ''
          require("fzf-lua").setup({})

          vim.keymap.set("n", "<leader>ff", require("fzf-lua").files,
            { desc = "Find files" })
        '';
      }
    ];

    extraLuaConfig = ''
      vim.cmd('filetype plugin indent on')
      vim.cmd('syntax on')

      vim.g.mapleader = " "

      -- Theme
      require("onedarkpro").setup({
        options = {
          transparency = false,
          cursorline = true,
        }
      })
      vim.cmd("colorscheme onedark")

      -- Basic options
      vim.opt.number = true
      vim.opt.colorcolumn = "80"
      vim.opt.laststatus = 2
      vim.opt.wrap = true
      vim.opt.linebreak = true
      vim.opt.scrolloff = 10
      vim.opt.sidescrolloff = 10

      vim.opt.incsearch = true
      vim.opt.hlsearch = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      vim.opt.expandtab = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.softtabstop = 4
      vim.opt.smartindent = true
      vim.opt.autoindent = true
      vim.opt.termguicolors = true
      vim.opt.signcolumn = "yes"
    '';
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    bat

    pyright
    ruff
    black
    python3
    python3Packages.pytest
  ];
}
