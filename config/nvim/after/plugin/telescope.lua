local tele = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

tele.setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<esc>"] = actions.close,
				["<C-esc>"] = actions.close,
			},
		},
	},
})

-- Enable telescope fzf native
tele.load_extension("fzf")
-- Projectc management integration
tele.load_extension("projects")
-- Zoxide for telescope
tele.load_extension("zoxide")

local nnmap = function(from, to)
	vim.keymap.set("n", from, to)
end

-- 'f' for find
local telemap = function(key, to)
	vim.keymap.set("n", "<leader>f" .. key, to)
end

-- Buffers
nnmap("<leader><space>", builtin.buffers)
nnmap("<C-space>", builtin.buffers)

-- Files
nnmap("<leader>.", builtin.find_files)
nnmap("<C-.>", builtin.find_files)

-- Git files
nnmap("<C-p>", function()
	if not pcall(builtin.git_files) then
		tele.extensions.projects.projects({})
	end
end)

-- Symbols
nnmap("<C-s>", builtin.lsp_document_symbols)

-- Grep
telemap("g", builtin.live_grep)
nnmap("<C-g>", builtin.live_grep)

-- Project picker
telemap("p", tele.extensions.projects.projects)

-- Old files
telemap("o", builtin.oldfiles)
nnmap("<leader>?", builtin.oldfiles)

-- Errors
telemap("e", builtin.diagnostics)

-- Help
telemap("h", builtin.help_tags)

-- Man pages
telemap("m", builtin.man_pages)
nnmap("<leader>mm", builtin.man_pages)

-- Change dir
telemap("d", tele.extensions.zoxide.list)

-- Commands
telemap(":", builtin.commands)
nnmap("<leader>:", builtin.commands)

-- Resume last telescope picker
telemap("r", builtin.resume)

-- Fuzzy in file
nnmap("<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end)
