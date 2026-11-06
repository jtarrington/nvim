vim.pack.add({ "https://github.com/folke/which-key.nvim" })

require("which-key").setup({
  preset = "helix",
  win = {
    padding = { 0, 0, 0, 0 },
    border = "rounded",
  },
})
require("which-key").add({
  { "<leader>", group = "Leader Mappings" },
})

local wk = require("which-key")
wk.add({
  {
    mode = { "n", "v" },
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  },
})
