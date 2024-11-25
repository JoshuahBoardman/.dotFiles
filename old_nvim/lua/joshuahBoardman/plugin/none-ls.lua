return {
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                -- LUA
                null_ls.builtins.formatting.stylua,
                -- JS/TS
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.diagnostics.eslint_d,
                -- Go
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.diagnostics.golangci_lint,
            })

            vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
        end,
    },
}
