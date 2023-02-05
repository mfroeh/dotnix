local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip").config.set_config({
	enable_autosnippets = false,
})

-- Load snippets
require("luasnip.loaders.from_snipmate").lazy_load({})

-- If you want insert `(` after selecting function or method item
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({}))

local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<Return>"] = cmp.mapping.confirm({ select = false }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
})
