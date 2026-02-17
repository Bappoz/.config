local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Configuração padrão do NvChad
nvlsp.defaults()

-- Ativar o rust-analyzer
lspconfig.rust_analyzer.setup({
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})
