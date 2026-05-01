vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "cpp"},
    callback = function()
        if vim.fn.executable("clang-format") == 1 then
            vim.bo.equalprg = "clang-format"
        else
            vim.bo.cindent = true
        end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python"},
    callback = function()
        if vim.fn.executable("ruff") == 1 then
            vim.bo.equalprg = "ruff format - --silent"
        else
            vim.bo.smartindent = true
        end
    end
})

