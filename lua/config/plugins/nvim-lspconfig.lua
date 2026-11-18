vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

-- LSPs
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

-- avoid ruff hovers
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
})

-- rust
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- Inlay hints display inferred types, etc.
    if client:supports_method("inlayHint/resolve") then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
    -- Completion can be invoked via ctrl+x ctrl+o. It displays a list of
    -- names inferred from the context (e.g. method names, variables, etc.)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, {})
    end
  end,
})

vim.lsp.enable({ "lua_ls", "ruff", "ty", "rust_analyzer" })
