-- require 'nvim-treesitter.install'.compilers = { 'zig' }

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {"help", "c", "lua", "rust", "html", "css", "javascript", "typescript", "astro", "go", "json" },

sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}
