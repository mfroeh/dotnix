local nightfox = require("nightfox")
nightfox.setup({
	hlgroups = {
		TelescopeBorder = { fg = "${bg_popup}", bg = "${bg_popup}" },
		TelescopePromptBorder = { fg = "${bg_visual}", bg = "${bg_visual}" },
		TelescopePromptNormal = { fg = "${fg_sidebar}", bg = "${bg_visual}" },
		TelescopePromptPrefix = { fg = "${fg_sidebar}", bg = "${bg_visual}" },
		TelescopeNormal = { fg = "${fg_sidebar}", bg = "${bg_popup}" },
		TelescopePreviewTitle = { fg = "${bg_popup}", bg = "${green}" },
		TelescopePromptTitle = { fg = "${bg_popup}", bg = "${green}" },
		TelescopeResultsTitle = { fg = "${bg_popup}", bg = "${green}" },
		TelescopeMatching = { fg = "${error}", bg = "${NONE}" },
	}
})
nightfox.load()
vim.cmd("colorscheme nightfox")
