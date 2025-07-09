
-- in your `lua/plugins/completion.lua` (or wherever you keep your lazy specs)
return {
  {
    -- Completion engine
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',           -- load when you enter Insert mode
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',        -- LSP source for nvim-cmp
      'hrsh7th/cmp-buffer',          -- buffer completions
      'hrsh7th/cmp-path',            -- filesystem paths
      'hrsh7th/cmp-cmdline',         -- : cmdline completions
      'L3MON4D3/LuaSnip',            -- snippet engine
      'saadparwaiz1/cmp_luasnip',    -- LuaSnip source for nvim-cmp
      'onsails/lspkind-nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      local cmp     = require 'cmp'
      local luasnip = require 'luasnip'

      -- Load friendly-snippets (optional)
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),

        formatting = {
          format = require('lspkind').cmp_format({ with_text = true, maxwidth = 50 }),
        },
      })

      -- Use buffer & path source in `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source in `:`
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- If you’re using lspconfig, make sure to pass cmp_capabilities too:
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig').clangd.setup{
        capabilities = capabilities,
      }
      require('lspconfig').lua_ls.setup{
        capabilities = capabilities,
      }
    end,
  },
}
