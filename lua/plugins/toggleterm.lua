

-- File: lua/plugins/toggleterm.lua
-- Lazy.nvim plugin specification for toggleterm.nvim with <C-`> hotkey

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',  -- use latest stable version
    config = function()
      -- Setup toggleterm with preferred options
      require('toggleterm').setup {
        size = 20,
        open_mapping = [[<D-`>]],
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        auto_scroll = true,
        winbar = {
          enabled = false,
        },
      }

      -- Keymaps for toggling terminal in normal and terminal modes
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      -- Normal mode: toggle float terminal
      map('n', '<D-`>', '<cmd>ToggleTerm<CR>', opts)
      -- Terminal mode: return to normal mode and toggle
      map('t', '<D-`>', '<C-\\><C-n><cmd>ToggleTerm<CR>', opts)
    end,
  }
}
