local present, lsp = pcall(require, "lsp-zero")
if not present then
  return
end


local present, null_ls = pcall(require, "null-ls")
if not present then
  return
end

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'sumneko_lua',
  'rust_analyzer',
  'html',
  'cssls',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gd", vim.lsp.buf.definition,  "Go to definition" )
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap("K", vim.lsp.buf.hover,  "Display function signature" )
  nmap("<leader>vd", vim.diagnostic.open_float,  "Open diagnostics" )
  nmap("[d", vim.diagnostic.goto_next, "Go to next diagnostic")
  nmap("]d", vim.diagnostic.goto_prev, "Go to previous diagnostic" )
  nmap("<leader>vca", vim.lsp.buf.code_action, "Code actions" )
  nmap("<leader>vrr", vim.lsp.buf.references, "References" )
  nmap("<leader>vrn", vim.lsp.buf.rename, "Rename" )
  nmap("<C-h>", vim.lsp.buf.signature_help,  "Function signature help" )
  nmap("<leader>vws", vim.lsp.buf.workspace_symbol, "[V]iew [W]orkspace [S]ymbols" )
  nmap("<leader>vds", vim.lsp.buf.document_symbol, "[V]iew [D]ocument [S]ymbols")
end)


local null_opts = lsp.build_options('null-ls', {
  on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Auto format before save",
        pattern = "<buffer>",
        callback = function()
          -- TSServer should not do any formatting. 
          vim.lsp.buf.format({
            async =  true,
            filter = function(c)
              return c.name ~= "tsserver"
            end
          })
        end
      })
    end
  end
})


null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.rustfmt,
  }
})


local rust_lsp = lsp.build_options('rust_analyzer', {})

lsp.nvim_workspace()

lsp.setup()

require('rust-tools').setup({
  server = rust_lsp,
  checkOnSave = {
    command = "clippy"
  },
})


-- Rust
--   {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
vim.diagnostic.config({
  virtual_text = true,
})
