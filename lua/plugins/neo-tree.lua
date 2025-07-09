return
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
    filesystem = {
	    filtered_items = {

    		visible = true,
    		hide_dotfiles = false,
    		hide_gitignored = true,
        },
    },
  },
  keys = {
    {
      -- open or focus Neo-Tree; if you're already in it, go back to the last window
      "<leader>fw",
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd("wincmd p")
        else
          -- this will open (if closed) and focus the Neo-Tree side
          vim.cmd("Neotree action=focus")
        end
      end,
      desc = "NeoTree: Focus ↔ Back",  -- you can tweak the description however you like
    },
    {
      -- always close Neo-Tree
      "<leader>fe",
      "<cmd>Neotree close<CR>",
      desc = "NeoTree: Close",
    },
    {
	"<leader>fr",
	"<cmd>Neotree reveal<CR>",
	desc = "NeoTree: reveal",
    },
  },
}


