local autocmd = vim.api.nvim_create_autocmd

-- Make sure we do not draw line numbers in terminal.
autocmd("TermOpen", {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

-- We want Makefile to be picked up every time one exists,
-- regardless of the file type.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "sh",
    callback = function()
        -- Only use bash -n if a Makefile DOES NOT exist
        if vim.fn.filereadable("Makefile") == 0 then
            vim.opt_local.makeprg = "bash -n"
        else
            vim.opt_local.makeprg = "make"
        end
    end,
})

