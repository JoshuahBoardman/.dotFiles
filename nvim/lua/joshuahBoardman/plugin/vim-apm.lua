return { 
    'ThePrimeagen/vim-apm', -- Not Working
    config = function() 
        local apm = require("vim-apm")
        apm:setup({})
        vim.keymap.set("n", "<leader>apm", function() apm:toggle_monitor() end)
    end,
}


