-- To automatically set pyenv based on available local pyenv version in current project's directory(if there's any)
vim.env.PYENV_VERSION = vim.fn.system('pyenv version'):match('(%S+)%s+%(.-%)')

vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 4       -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 4    -- 2 spaces for indent width
vim.opt.expandtab = true  -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- install plugins
lvim.plugins = {
  "ChristianChiarulli/swenv.nvim", -- plugin to switch python virtualenv
  "stevearc/dressing.nvim", -- plugin to make UI nicer
  "mfussenegger/nvim-dap-python",
-- "nvim-neotest/neotest",
-- "nvim-neotest/neotest-python",
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }


-- Python (To reduce extra noises/error messages from Pyright LSP)
require("lspconfig").pyright.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  }
}

-- restart language server after switching to new virtualenv
--require('swenv').setup({
--  -- enumerates the venv folder for all set-up venvs
--  venvs_path = vim.fn.expand("~/.pyenv/versions/"),
--  -- sets the env var and restarts the LSP.
--  post_set_venv = function ()
--    vim.cmd("LspRestart")
--  end,
--})

-- keybinding for switching python virtualenv
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
