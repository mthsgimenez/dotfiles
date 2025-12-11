vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
   desc = 'LSP actions',
   callback = function(event)
      local opts = { buffer = event.buf }

      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
   end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
   require('lspconfig')[server].setup({
      capabilities = lsp_capabilities,
   })
end

require('mason').setup({})
require('mason-lspconfig').setup({
   handlers = {
      default_setup,
      jsonls = function()
         require('lspconfig').jsonls.setup({
            capabilities = lsp_capabilities,
            settings = {
               json = {
                  schemas = {
                     {
                        fileMatch = {"tsconfig*.json"},
                        url = "https://json.schemastore.org/tsconfig.json"
                     },
                     {
                        fileMatch = {"package.json"},
                        url = "https://json.schemastore.org/package.json"
                     },
                  },
               },
            },
         })
      end,
      lua_ls = function()
         require('lspconfig').lua_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
               Lua = {
                  runtime = {
                     version = 'LuaJIT',
                  },
                  diagnostics = {
                     globals = {'vim'},
                  },
                  workspace = {
                     library = {
                        vim.env.RUNTIME,
                     }
                  },
               },
            },
         })
      end,
   },
})

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
   sources = {
      { name = 'nvim_lsp' },
   },
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({select = false}),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         else
            fallback()
         end
      end),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         else
            fallback()
         end
      end)
   })
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
