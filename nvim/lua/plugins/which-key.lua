local config = function()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single",   -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n",     -- Normal mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = false, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["<leader>"] = {
      name = "Util",
      w = { "<cmd>update!<CR>", "Save" },
      q = { "<cmd>q!<CR>", "Quit" },
      Q = { "<cmd>wq!<CR>", "Save and Quit" },
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      x = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end
return {
  "folke/which-key.nvim",
  lazy = false,
  opts = {},
  config = config,
}
