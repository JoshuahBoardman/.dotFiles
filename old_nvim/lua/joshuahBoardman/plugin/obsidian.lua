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
                };

                templates = {
                    -- obsidian template file path
                    folder = "~/my_obsidian_vault/meta_data/templates/",
                    date_format = "%Y-%m-%d-%a",
                    time_format = "%H:%M",
                };

                follow_url_func = function(url)
                    -- Open the URL in the default web browser.
                    vim.fn.jobstart({"open", url})  -- Mac OS
                    -- vim.fn.jobstart({"xdg-open", url})  -- linux
                end

            })
            vim.opt.conceallevel = 1
            -- TODO: add hotkeys for concistently used actions
        end,
    }
}
