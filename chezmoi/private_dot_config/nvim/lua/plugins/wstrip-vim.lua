-- Strip trailing whitespace only on changed lines

return {
  {
    "https://github.com/tweekmonster/wstrip.vim",
    init = function()
      -- Enable wstrip-vim on all filetypes to remove trailing whitespaces only on changed lines
      -- It's useful in rare occasions to disable this in a buffer, do it with the Neovim command `:let b:wstrip_auto = 0`
      vim.g.wstrip_auto = 1
    end,
  },
}
