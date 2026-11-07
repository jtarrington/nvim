vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

-- icons, required by many
require("mini.icons").setup({})

-- git
require("mini.diff").setup({})
require("mini.git").setup({})

-- statusline
require("mini.statusline").setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename = vim.fn.expand("%:.") -- Relative to CWD
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })

      if filename == "" then
        filename = "[No Name]"
      end

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
})

-- text editing
require("mini.comment").setup({}) -- use "gcc" to comment a line
require("mini.keymap").setup({})
require("mini.pairs").setup({})
require("mini.surround").setup({})

-- snippets
local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
  snippets = {
    gen_loader.from_file("~/.config/nvim/snippets/global.json"),
    gen_loader.builtin_with_defaults(),
  },
})

-- general
require("mini.cmdline").setup({})
require("mini.pick").setup({})

-- appearance
require("mini.statuscolumn").setup({})
require("mini.indentscope").setup({})
require("mini.starter").setup({})
require("mini.tabline").setup({})

-- autocompletion
require("mini.completion").setup({
  window = {
    info = { border = "rounded" },
  },
})

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- custom keymaps
local map_multistep = require("mini.keymap").map_multistep
map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })

local map_combo = require("mini.keymap").map_combo

-- Support most common modes. This can also contain 't', but would
-- only mean to press `<Esc>` inside terminal.
local mode = { "i", "c", "x", "s" }
map_combo(mode, "jk", "<BS><BS><Esc>")

-- To not have to worry about the order of keys, also map "kj"
map_combo(mode, "kj", "<BS><BS><Esc>")

-- Escape into Normal mode from Terminal mode
map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
map_combo("t", "kj", "<BS><BS><C-\\><C-n>")
