-- TODO: Migrate this. It's directly copy-pasted from my Nix-generated files
local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-l>"] = cmp.mapping.confirm({ select = false }),
        ["<C-y>"] = cmp.config.disable,
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "buffer" },
    },
})

require("which-key").setup({ preset = "modern" })

vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "site"))
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
    parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
})

require("mini.base16").setup({
    palette = {
        base00 = "#ffffff",
        base01 = "#ededed",
        base02 = "#dbdbdb",
        base03 = "#848484",
        base04 = "#636363",
        base05 = "#555555",
        base06 = "#555555",
        base07 = "#555555",
        base08 = "#af4947",
        base09 = "#a0570d",
        base0A = "#876500",
        base0B = "#557301",
        base0C = "#087767",
        base0D = "#186daa",
        base0E = "#7b4ecb",
        base0F = "#a93e93",
    },
})

require("lualine").setup({
    inactive_winbar = { lualine_c = { { "filename", file_status = true, path = 1 } } },
    options = { globalstatus = true },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "filename", file_status = true, path = 1 }, "diff" },
        lualine_x = {
            "diagnostics",
            {
                function()
                    local msg = ""
                    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                color = { fg = "#ffffff" },
                icon = " ",
            },
            "encoding",
            "fileformat",
            "filetype",
        },
    },
    winbar = { lualine_c = { { "filename", file_status = true, path = 1 } } },
})
