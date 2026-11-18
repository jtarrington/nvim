vim.pack.add({ "https://github.com/lervag/vimtex" })

vim.g.vimtex_view_method = "galley" -- or "skim", "sioyek", "general"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
  aux_dir = "pdfs",
  out_dir = "pdfs",
  callback = 1,
  continuous = 1,
  executable = "latexmk",
  options = {
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
  },
}
vim.g.vimtex_compiler_latexmk_engines = { _ = "-pdf" } -- pdfTex
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_quickfix_open_on_warning = 0
