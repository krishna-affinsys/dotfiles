-- completion.lua
return {
  -- nvim-cmp core
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",               -- snippet engine
      "saadparwaiz1/cmp_luasnip",       -- luasnip completion source
      "hrsh7th/cmp-nvim-lsp",           -- lsp source
      "hrsh7th/cmp-buffer",             -- buffer source
      "hrsh7th/cmp-path",               -- path source
      "onsails/lspkind-nvim",           -- nice pictograms (optional)
      -- optional nice-to-have snippet collection:
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      local has_cmp, cmp = pcall(require, "cmp")
      if not has_cmp then return {} end

      local luasnip_ok, luasnip = pcall(require, "luasnip")
      if not luasnip_ok then luasnip = nil end

      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_mappings = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip and luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip and luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      return {
        snippet = {
          expand = function(args)
            if luasnip then
              luasnip.lsp_expand(args.body)
            end
          end,
        },
        mapping = cmp_mappings,
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = require("lspkind").cmp_format({ with_text = true, maxwidth = 50 }),
        },
        experimental = {
          ghost_text = false,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- Cmdline completion (optional)
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "path" }, { name = "cmdline" } },
      })

      -- load friendly-snippets
      pcall(function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end)
    end,
  },

  -- Luasnip itself, basic config
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
      }
      -- optional: add some keymaps for snippet choice
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
      end, { silent = true, desc = "LuaSnip expand/jump" })
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.jumpable(-1) then luasnip.jump(-1) end
      end, { silent = true, desc = "LuaSnip jump back" })
    end,
  },

  -- optional: lspkind for icons
  {
    "onsails/lspkind-nvim",
    lazy = true,
  },

  -- optional: friendly snippets collection
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
}
