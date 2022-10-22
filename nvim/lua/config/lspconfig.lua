require("mason").setup()
require("mason-lspconfig").setup()
require("lsp_signature").setup()

local lsp = require("lspconfig")

vim.g.coq_settings = {
  auto_start = "shut-up",
}

local coq = require("coq")
require("coq_3p") {
  { src = "copilot", short_name = "COP", accept_key = "<c-f>" }
}

local ensure_coq = coq.lsp_ensure_capabilities {}

lsp.tsserver.setup(ensure_coq)
lsp.pyright.setup(ensure_coq)
lsp.jsonls.setup(ensure_coq)
lsp.terraformls.setup(ensure_coq)
