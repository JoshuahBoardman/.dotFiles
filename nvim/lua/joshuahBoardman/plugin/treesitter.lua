return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
        require 'nvim-treesitter.configs'.setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                --  "help",
                "lua",
                "rust",
                "html",
                "css",
                "javascript",
                "typescript",
                "astro",
                "go",
                "json",
                "markdown",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                -- `false` will disable the whole extensionenable
                enable = true,
            },
            indent = {
                enable = true
            },
        })
    end,
}
