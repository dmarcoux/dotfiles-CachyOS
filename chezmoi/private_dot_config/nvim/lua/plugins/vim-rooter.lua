-- Change Vim working directory to project root

return {
  {
    "https://github.com/airblade/vim-rooter",
    init = function()
      -- A root directory will have a `.git` directory
      vim.g.rooter_patterns = { ".git" };
    end,
  },
}
