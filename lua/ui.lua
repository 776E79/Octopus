require('telescope').setup({
    defaults = {
        -- This affects live_grep and other search tools
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",     -- Include hidden files
            "--glob", "!.git/*" -- Exclude .git directory
        },
    },
    pickers = {
        find_files = {
            hidden = true, 
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
        },
    },
})

require("ibl").setup {
    indent = {
        char = "│",
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
    },
}

vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#444444", bg = "none" })
require("virt-column").setup({
    char = "│",
    virtcolumn = "80",
})

