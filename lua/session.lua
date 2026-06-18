require("persisted").setup({
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    use_git_branch = true,
    autowrite = true, 
    autoload = false, 
})

require("telescope").load_extension("persisted")

local group = vim.api.nvim_create_augroup("PersistedHook", {})
vim.api.nvim_create_autocmd("User", {
    pattern = "PersistedLoadPost",
    group = group,
    callback = function()
        require("persisted").start()
        print("Session loaded: Auto-save active on exit.")
    end,
})
