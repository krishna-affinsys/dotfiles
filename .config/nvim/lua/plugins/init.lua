return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    'pocco81/true-zen.nvim',
    opts = {
      integrations = {
        tmux = true,
      },
    },
    config = function(_plugin, opts)
      require('true-zen').setup(opts)
    end,
    keys = {
      {
        '<leader>zn',
        '<cmd>TZNarrow<cr>',
        mode = 'n',
        desc = 'Narrow focused',
        noremap = true,
      },
      {
        '<leader>zn',
        "<cmd>'<,'>TZNarrow<cr>",
        mode = 'v',
        desc = 'Ranged narrow focused',
        noremap = true,
      },
      {
        '<leader>zf',
        '<cmd>TZFocus<cr>',
        mode = 'n',
        desc = 'Focued mode',
        noremap = true,
      },
      {
        '<leader>zm',
        '<cmd>TZMinimalist<cr>',
        mode = 'n',
        desc = 'Minimalist mode',
        noremap = true,
      },
      {
        '<leader>za',
        '<cmd>TZAtaraxis<cr>',
        mode = 'n',
        desc = 'Ataraxis mode',
        noremap = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  			"lua-language-server", "stylua",
  			"html-lsp", "css-lsp" , "prettier"
  		},
  	},
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
}
