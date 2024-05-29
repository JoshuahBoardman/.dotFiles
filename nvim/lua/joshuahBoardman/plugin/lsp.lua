return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = function()
            require("mason").setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        dependencies  = {
            'williamboman/mason.nvim',
        },
        config = function()
           require("mason-lspconfig").setup({
                -- Find LSPs: https://github.com/williamboman/mason-lspconfig.nvim 
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "rust_analyzer",
                    "tsserver",
                    "marksman",
                    "astro",
                    "tailwindcss",
                    "jsonls",
                    "yamlls",
                },
           })
        end
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.gopls.setup({
                capabilities = capabilities
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities
            })
            lspconfig.marksman.setup({
                capabilities = capabilities
            })
            lspconfig.astro.setup({
                capabilities = capabilities
            })
            lspconfig.tailwindcss.setup({
                capabilities = capabilities
            })
            lspconfig.jsonls.setup({
                capabilities = capabilities
            })
            lspconfig.yamlls.setup({
                capabilities = capabilities
            })

            -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
              vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})
              vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, {})
              vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, {})
              vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end, {})
              vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, {})
              vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
              vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, {})
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
              vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, {})
        end
    },
}

        -- LSP Support
            --{'neovim/nvim-lspconfig'},             -- Required
            --{'williamboman/mason.nvim'},           -- Optional
            --{'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
            --{'hrsh7th/nvim-cmp'},         -- Required
            --{'hrsh7th/cmp-nvim-lsp'},     -- Required
            --{'hrsh7th/cmp-buffer'},       -- Optional
            --{'hrsh7th/cmp-path'},         -- Optional
            --{'saadparwaiz1/cmp_luasnip'}, -- Optional
            --{'hrsh7th/cmp-nvim-lua'},     -- Optional

        -- Snippets
            --{'L3MON4D3/LuaSnip'},             -- Required
            --{'rafamadriz/friendly-snippets'}, -- Optional
