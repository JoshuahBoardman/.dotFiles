return {

    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "my_vault",
                        -- obsidian vault path
                        path = "~/my_obsidian_vault/",
                    },
                },
                templates = {
                    -- obsidian template file path
                    folder = "~/my_obsidian_vault/meta_data/templates/",
                    date_format = "%Y-%m-%d-%a",
                    time_format = "%H:%M",
                },
            })
            vim.opt.conceallevel = 1
        end,
    }
}
