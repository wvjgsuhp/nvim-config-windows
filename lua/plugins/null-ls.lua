-- plugin: null-ls.nvim
-- see: https://github.com/jose-elias-alvarez/null-ls.nvim
-- rafi settings

local builtins = require("null-ls").builtins
local on_attach = require("plugins.lspconfig").on_attach

local function has_exec(filename)
  return function(_)
    return vim.fn.executable(filename) == 1
  end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
require("null-ls").setup({
  -- Ensure key maps are setup
  on_attach = on_attach,

  sources = {
    -- Whitespace
    builtins.diagnostics.trail_space.with({
      disabled_filetypes = { "gitcommit" },
    }),

    -- Javascript
    builtins.diagnostics.eslint,

    -- Lua
    builtins.formatting.stylua,

    -- SQL
    builtins.formatting.sqlformat,
  },
})
