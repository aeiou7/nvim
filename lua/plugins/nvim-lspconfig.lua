return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Setup Mason for managing external tooling
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "pyright" },
      }

      local lspconfig = require("lspconfig")

      -- Common on_attach to map LSP-related keybindings
      local on_attach = function(client, bufnr)
        local bufmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        bufmap("gd", vim.lsp.buf.definition, "Go to Definition")
        bufmap("gr", vim.lsp.buf.references, "List References")
        bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
        bufmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        bufmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
      end

      -- Configure Pyright for Python
      lspconfig.pyright.setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      }
    end,
  },
}

