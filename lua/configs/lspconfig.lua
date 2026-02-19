local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Configuração padrão do NvChad
nvlsp.defaults()

-- Helper: setup com defaults do NvChad
local function setup(server, opts)
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }, opts or {}))
end

-- C e C++ -------------------------------------------------------
setup("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- C# ------------------------------------------------------------
setup("omnisharp", {
  -- OmniSharp será encontrado automaticamente pelo Mason
  -- Descomente a linha abaixo se precisar apontar o executável manualmente:
  -- cmd = { "omnisharp", "--languageserver" },
  settings = {
    FormattingOptions = { EnableEditorConfigSupport = true },
    RoslynExtensionsOptions = { EnableAnalyzersSupport = true },
  },
})

-- Lua -----------------------------------------------------------
-- lazydev.nvim injeta os tipos do Neovim; lua_ls só precisa saber o runtime.
setup("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- Python --------------------------------------------------------
setup("pyright", {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
})
