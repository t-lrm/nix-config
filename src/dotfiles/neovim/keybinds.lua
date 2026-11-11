-- +----------------------------------------------------------------+
-- | Documentation, signature, types, return type | K               |
-- | Jump to definition -> return                 | Ctrl-] → Ctrl-t |
-- | Rename across the project                    | grn             |
-- | Contextual completion, insert mode           | Ctrl-x Ctrl-o   |
-- | Select / accept completion                   | Ctrl-n / Ctrl-y |
-- | Parameter names and types, insert mode       | Ctrl-s          |
-- | Generate documentation                       | Space n d       |
-- | Navigate documentation placeholders          | Tab / Shift-Tab |
-- | Show diagnostic message at the cursor        | Ctrl-w, then d  |
-- | Next diagnostic                              | ]d              |
-- | Previous diagnostic                          | [d              |
-- +----------------------------------------------------------------+

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "Find files" })

vim.keymap.set("n", "<leader>nd", require("neogen").generate, { desc = "Generate documentation" })
