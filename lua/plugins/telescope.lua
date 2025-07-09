return {
    "nvim-telescope/telescope.nvim",
      dependencies = { 'nvim-lua/plenary.nvim' },
      lazy = false,
      opts = {},
      keys = {{"<leader>ff","<cmd>Telescope find_files<cr>", desc = "find files"},},
    }
