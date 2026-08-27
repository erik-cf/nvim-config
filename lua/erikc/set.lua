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
  pattern = { "*.go", "*.lua" },
  command = "lua vim.lsp.buf.format()"
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { '*.js', '*.ts', '*.tsx', '*.json', '*.css', '*.html' },
  callback = function()
    -- Save current cursor position and view state
    local view = vim.fn.winsaveview()
    if vim.fn.filereadable("./node_modules/.bin/prettier") ~= 0 then
      vim.cmd("silent! :%!./node_modules/.bin/prettier --config .prettierrc --stdin-filepath " .. vim.fn.expand("%"))
    else
      return
    end
    -- Run the Prettier command quietly to avoid flickering

    -- Restore the cursor and view state
    vim.fn.winrestview(view)
  end,
})

local function organize_imports(bufnr, timeout_ms)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  timeout_ms = timeout_ms or 500
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(bufnr) },
  }
  vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, timeout_ms)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts" },
  callback = function(ev)
    organize_imports(ev.buf, 300)
  end
})
