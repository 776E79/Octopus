vim.cmd.colorscheme('github_light_default')
vim.o.equalalways = false
vim.opt.winbar = " %t %m%= "

local UI_Highlight_Group = vim.api.nvim_create_augroup("WinHighlightManagement", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "TermOpen" }, {
    group = UI_Highlight_Group,
    callback = function()
        if vim.bo.filetype == "NvimTree" then
            return
        end

        if vim.bo.buftype == "terminal" then
            vim.wo.winhighlight = "Normal:NormalSB,WinBar:NormalSB,SignColumn:SignColumnSB"
        else
            vim.wo.winhighlight = "WinBar:NormalSB,SignColumn:SignColumnSB"
        end
    end,
})

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
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    pickers = {
        find_files = {
            hidden = true, 
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
        },
    },
})

vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#B69A9A", bg = "none" })
require("virt-column").setup({
    char = "│",
    virtcolumn = "100",
})

-- Padding between gutter and main text
vim.opt.statuscolumn = "%s%l %C"
vim.opt.signcolumn = "yes:1"
vim.opt.foldcolumn = "1"

require("ibl").setup {
    indent = {
        char = "│",
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = true,
        priority = 1024,
    },
    exclude = {
        buftypes = { "terminal", "nofile" },
    },
}

vim.diagnostic.config({
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = "if_many",
        header = "",
        prefix = "",
    },
})

vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

local session_group = vim.api.nvim_create_augroup("SessionRestoreSequence", { clear = true })

vim.api.nvim_create_autocmd("SessionLoadPost", {
    group = session_group,
    callback = function()
        local win_heights = {}
        local win_widths = {}
        local windows = vim.api.nvim_tabpage_list_wins(0)

        for _, win in ipairs(windows) do
            win_heights[win] = vim.api.nvim_win_get_height(win)
            win_widths[win] = vim.api.nvim_win_get_width(win)
        end

        local has_tree, api = pcall(require, "nvim-tree.api")
        if has_tree then
            api.tree.open({ focus = false, find_file = true })
        end

        for win, saved_height in pairs(win_heights) do
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_height(win, saved_height)
            end
        end
        for win, saved_width in pairs(win_widths) do
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_width(win, saved_width)
            end
        end
    end,
})
