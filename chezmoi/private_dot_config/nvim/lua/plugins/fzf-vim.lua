-- Fuzzy finder for files, buffers and more...

return {
  { "https://github.com/junegunn/fzf" },
  {
    "https://github.com/junegunn/fzf.vim",
    init = function()
      -- Display the fzf window at the bottom of the screen with 40% of the available height
      vim.g.fzf_layout = { down = '40%' }
    end,
    keys = {
      -- Non-recursive mapping in Normal and Visual modes for Ctrl+p to start fzf for files
      { "<C-p>", ":Files<CR>", mode = { "n", "v" }, },
      -- Non-recursive mapping in Normal and Visual modes for Ctrl+n to start fzf for buffers
      { "<C-n>", ":Buffers<CR>", mode = { "n", "v" }, },
    },
  },
}
