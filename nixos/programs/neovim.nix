{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim
      onedarkpro-nvim

      nvim-lspconfig

      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip

      conform-nvim
      vim-test
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

      -- Telescope
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help tags" })

      -- Completion
      local cmp = require("cmp")
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_lsp.default_capabilities()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
        end,
      })

      -- Neovim 0.11+ LSP config API
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })
      vim.lsp.enable("pyright")

      -- Formatting
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format", "black" },
        },
      })

      vim.keymap.set("n", "<leader>fm", function()
        require("conform").format({ lsp_fallback = true })
      end, { desc = "Format file" })
    '';
  };

  home.packages = with pkgs; [
    ripgrep
    fd

    pyright
    ruff
    black
    python3
    python3Packages.pytest
  ];
}
