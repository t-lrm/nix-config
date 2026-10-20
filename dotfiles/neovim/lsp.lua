vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-completion", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, {
                autotrigger = true,
            })
        end
    end,
})

vim.lsp.config("nixd", {
    settings = {
        nixd = {
            formatting = { command = { "alejandra" } },
        },
    },
})

vim.lsp.enable({ "pyright", "clangd", "gopls", "nixd", "rust_analyzer" })

require("neogen").setup({
    snippet_engine = "nvim",
    languages = {
        python = { template = { annotation_convention = "google_docstrings" } },
        c = { template = { annotation_convention = "doxygen" } },
    },
})
