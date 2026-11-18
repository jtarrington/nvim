-- my "minimal" config, using primarily mini.nvim
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- options
local o = vim.opt
o.termguicolors = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.hlsearch = true
o.incsearch = true
o.hidden = true
o.number = true
o.relativenumber = true
o.wrap = false
o.linebreak = true
o.clipboard = "unnamedplus"
o.signcolumn = "yes"
o.updatetime = 300
o.mouse = "a"
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.splitright = true
o.splitbelow = true
o.scrolloff = 8
o.timeoutlen = 300
o.winborder = "rounded"

-- keymaps
local map = vim.keymap.set
for _, k in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
  map("n", k, "<Nop>")
end
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
map("n", "gj", "j", { silent = true })
map("n", "gk", "k", { silent = true })
map("n", "-", "<CMD>Oil<Cr>")
map({ "n", "v" }, "<leader>q", ":q<CR>")

-- diagnostics
map("n", "<leader>dd", vim.diagnostic.setqflist, { desc = "Open diagnostics list" })
map("n", "<leader>de", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Open error diagnostics list" })
map("n", "<leader>ds", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
end)
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    -- Automatically updates the quickfix list with LSP diagnostics in the background
    vim.diagnostic.setqflist({ open = false })
  end,
})
-- vim.api.nvim_create_autocmd("CursorHold", {
--   group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
--   callback = function()
--     vim.diagnostic.open_float(nil, {
--       focus = false,
--       scope = "line",
--     })
--   end,
-- })

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- latex recognition
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.tex", "*.sty", "*.cls" },
  callback = function()
    vim.bo.syntax = "tex"
  end,
})

-- appearance
vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
vim.cmd.colorscheme("catppuccin-frappe")

-- load plugins
local plugins = {
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-lspconfig",
  "conform",
  "mini",
  "luasnip",
  "luasnip-latex-snippets",
  "oil",
  "which-key",
  "markview",
  "neogen",
  "vimtex",
}

for _, name in ipairs(plugins) do
  require("config.plugins." .. name)
end
