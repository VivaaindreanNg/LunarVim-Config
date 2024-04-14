
-- Try to turn off typeCheckingMode for Django
require("lvim.lsp.manager").setup("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    },
  },
})
