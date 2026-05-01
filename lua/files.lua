vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    sort = {
        sorter = "case_sensitive",
    },
    hijack_cursor = true,
    sync_root_with_cwd = true,
    view = { 
        width = 40, 
        side = 'left',
        signcolumn = "yes", -- Keeps the signcolumn visible
    },
    update_focused_file = { enable = true },
    git = {
        enable = true,
        ignore = false,
        show_on_open_dirs = true,
    },
    filters = {
        custom = { "^.git$" },
    },
    renderer = {
        group_empty = true,
        highlight_opened_files = "all",
        root_folder_label = ":t",
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "signcolumn", -- Moves git status to the signcolumn
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
})

