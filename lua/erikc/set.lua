vim.cmd.colorscheme("gruvbox-material")
vim.opt.clipboard = 'unnamedplus'
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.incsearch = true -- incremental search
vim.opt.termguicolors = true
vim.diagnostic.config({ virtual_text = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.ts", "*.lua" },
  command = "lua vim.lsp.buf.format()"
})

local function organize_imports(bufnr, timeout_ms)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  timeout_ms = timeout_ms or 1000
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(bufnr) },
  }
  vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, timeout_ms)
end
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.ts" },
  callback = function(ev)
    organize_imports(ev.buf, 1000)
  end
})

-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   commands = {
--     OrganizeImports = {
--       organize_imports,
--       description = "Organize Imports"
--     }
--   }
-- }
