
-- Nova API do nvim-lspconfig v3.0

local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- Suprime o warning do workspace/diagnostic/refresh
vim.lsp.handlers["workspace/diagnostic/refresh"] = function() end

-- C e C++ -------------------------------------------------------
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=1",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
})
vim.lsp.enable("clangd")

-- C# ------------------------------------------------------------
vim.lsp.config("omnisharp", {
  capabilities = capabilities,
  settings = {
    FormattingOptions = { EnableEditorConfigSupport = true },
    RoslynExtensionsOptions = { EnableAnalyzersSupport = true },
  },
})
vim.lsp.enable("omnisharp")

-- Lua -----------------------------------------------------------
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.enable("lua_ls")

-- Python --------------------------------------------------------
vim.lsp.config("pyright", {
  capabilities = capabilities,
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
vim.lsp.enable("pyright")
