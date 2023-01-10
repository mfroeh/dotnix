local cmp = require 'cmp'
local luasnip = require 'luasnip'

require("luasnip").config.set_config({
  enable_autosnippets = false,

  -- Use Tab to trigger visual selections
  store_selection_keys = "<Tab>",
})

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load({paths = { "~/dotnix/config/nvim/snippets" }})

-- If you want insert `(` after select function or method item
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({}))

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      end
    end),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false, -- If this is true, will select the first item even if none is selected.
    },
    -- TODO: What is expandable what is jumpable?
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entries = cmp.get_entries()
        -- if #entries > 0 and (#entries == 1 or entries[1].exact or cmp.get_selected_entry()) then
        if #entries > 0 and (entries[1].exact or cmp.get_selected_entry()) then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true})
        end
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = "buffer" },
    { name = "path" },
  },
}
