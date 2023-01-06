require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
}

local builtin = require("telescope.builtin")

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Projectc management integration
require('telescope').load_extension("projects")

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })


local nnmap = function(from, to)
  vim.keymap.set("n", from, to)
end

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })


-- 'l' for list or live
local telemap = function(key, to)
  vim.keymap.set("n", "<leader>l" .. key, to)
end

-- Commands
telemap("c", builtin.commands)
nnmap("<leader>:", builtin.commands)

-- Files
telemap("f", builtin.find_files)
nnmap("<leader>.", builtin.find_files)

-- Git files
nnmap("<C-p>", builtin.git_files)

-- Grep
telemap("g", builtin.live_grep)
nnmap("<C-g>", builtin.live_grep)
telemap("*", builtin.grep_string)
nnmap("<C-8>", builtin.live_grep)

-- Diagnostics
telemap("d", builtin.diagnostics)

-- Help
telemap("h", builtin.help_tags)

-- Resume last telescope picker
telemap("l", builtin.resume)

-- Project picker
telemap("p", require("telescope").extensions.projects.projects)
