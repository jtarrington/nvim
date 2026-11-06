vim.pack.add({ "https://github.com/danymat/neogen" })

require("neogen").setup({})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>nf", ": lua require('neogen').generate()<CR>", opts)
