do
  local __autocmds = {
    {
      callback = function()
        -- Force Markdown type
        vim.opt.filetype = "markdown"
        -- Wrap lines at 80 characters
        vim.opt_local.textwidth = 80
      end,
      desc = "Set options in Markdown files",
      event = { "BufNewFile", "BufReadPost" },
      pattern = "*.md",
    },
    {
      callback = function()
        -- Disable .editorconfig for the current buffer when editing a git commit.
        -- Sometimes a poorly-configured .editorconfig would overwrite line length.
        vim.b.editorconfig = false

        -- Wrap lines at 72 characters
        vim.opt_local.textwidth = 72
      end,
      desc = "Set options in gitcommit files",
      event = "FileType",
      pattern = "gitcommit",
    },
    {
      callback = function()
        vim.cmd("wincmd J") -- See `:help :wincmd` and `:help ^WJ`
      end,
      desc = "When the quickfix window opens, move it the very bottom",
      event = "FileType",
      pattern = "qf",
    },
    {
      callback = function()
        -- See `:help vim.highlight.on_yank()`
        vim.highlight.on_yank({ timeout = 1000 }) -- highlight for 1 second
      end,
      desc = "Highlight when yanking (copying) text",
      event = "TextYankPost",
    },
    {
      callback = function()
        vim.cmd("call tagbar#autoopen(0)") -- See `:help :tagbar-autoopen`
      end,
      desc = "Open tagbar automatically for supported filetypes whenever opening a file",
      event = "FileType",
      nested = true,
      pattern = "*",
    },
  }

  for _, autocmd in ipairs(__autocmds) do
    vim.api.nvim_create_autocmd(autocmd.event, {
      group = autocmd.group,
      pattern = autocmd.pattern,
      buffer = autocmd.buffer,
      desc = autocmd.desc,
      callback = autocmd.callback,
      command = autocmd.command,
      once = autocmd.once,
      nested = autocmd.nested,
    })
  end
end
