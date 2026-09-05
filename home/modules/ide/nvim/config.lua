vim.cmd.colorscheme("koda-dark")
-- vim.cmd.colorscheme("")
vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({ virtual_text = true })
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.local/state/nvim/undo")
vim.diagnostic.config({ signs = false })
vim.print("loaded extra config.lua file ;)")

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local bt = vim.bo[args.buf].buftype
    if bt == "prompt" then
      vim.b[args.buf].minicompletion_disable = true
    end
  end,
})

require("neocord").setup({
  logo = "auto",
  main_image = "language",
  editing_text = "Editing %s",
  workspace_text = "Working on %s",
})