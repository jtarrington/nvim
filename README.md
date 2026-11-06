# Neovim Config
This is a minimal Neovim config that I use.
To try this out, clone this repo to somewhere like `~/.config/nvim-new` and set-up a trial Neovim alias with
```
NVIM_APPNAME=nvim-new nvim
```
You will be prompted by Neovim's package installer to install the necessary packages at start-up.

Also, to use the `nvim-treesitter` plug-in, you will need to install the [`tree-sitter-cli`](https://github.com/tree-sitter/tree-sitter-cli).
Similarly, any LSPs that you want will need to be separately installed (you can do this manually or with a tool like `mason`).
