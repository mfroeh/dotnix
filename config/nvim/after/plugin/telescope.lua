local tele = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

-- Enable telescope fzf native
tele.load_extension("fzf")
-- Projectc management integration
tele.load_extension("projects")
-- Zoxide for telescope
tele.load_extension("zoxide")

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

local nnmap = function(from, to)
	vim.keymap.set("n", from, to)
end

-- 'l' for list or live
local telemap = function(key, to)
	vim.keymap.set("n", "<leader>l" .. key, to)
end

-- Fuzzy in file
nnmap("<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end)

-- Buffers
telemap("b", builtin.buffers)
nnmap("<leader><leader>", builtin.buffers)

-- Commands
telemap("c", builtin.commands)
nnmap("<leader>:", builtin.commands)

-- Files
telemap("l", builtin.find_files)
nnmap("<leader>.", builtin.find_files)

-- Old files
telemap("o", builtin.oldfiles)
nnmap("<leader>?", builtin.oldfiles)

-- Git files
nnmap("<C-p>", function()
	if not pcall(builtin.git_files) then
		tele.extensions.projects.projects({})
	end
end)

-- Grep
telemap("g", builtin.live_grep)
nnmap("<C-g>", builtin.live_grep)
telemap("*", builtin.grep_string)
nnmap("<C-8>", builtin.live_grep)

-- Errors
telemap("e", builtin.diagnostics)

-- Help
telemap("h", builtin.help_tags)

-- Resume last telescope picker
telemap("r", builtin.resume)

-- Man pages
telemap("m", builtin.man_pages)

-- Project picker
telemap("p", tele.extensions.projects.projects)

-- Change dir
telemap("d", tele.extensions.zoxide.list)
nnmap("<leader>cd", tele.extensions.zoxide.list)
