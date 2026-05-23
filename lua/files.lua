vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable autoreload of buffers
vim.o.autoread = true

local autoreload_group = vim.api.nvim_create_augroup("AutoReloadBuffer", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = autoreload_group,
    pattern = "*",
    callback = function()
        if vim.fn.mode() ~= "c" and vim.bo.buftype == "" then
            vim.cmd("checktime")
        end
    end,
})

require('nvim-tree').setup({
    sort = {
        sorter = "case_sensitive",
    },
    hijack_cursor = true,
    sync_root_with_cwd = true,
    view = { 
        preserve_window_proportions = true,
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

