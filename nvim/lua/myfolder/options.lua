local options = {
    nu = true,
    relativenumber = true,
    scrolloff = 9999,

    cursorline = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    hlsearch = false,
    incsearch = false,
    termguicolors = true,

    smartindent = true,
    wrap = false,

    -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    -- delays and poor user experience.
    updatetime = 50,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
