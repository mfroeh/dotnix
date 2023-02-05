require("mfroeh.remap")
require("mfroeh.set")
require("mfroeh.misc")
require("mfroeh.colorscheme")
require("mfroeh.neovide")

FLAKE_PATH = "$HOME/dotnix"

HOME_MANAGER_SWITCH = function()
	vim.fn.termopen("home-manager switch --flake " .. FLAKE_PATH .. "#$USER" .. "@" .. "$hostname")
	-- TODO: This does not show output yet
	-- vim.fn.jobstart("home-manager switch --flake " .. FLAKE_PATH .. "#$USER" .. "@" .. "$hostname", { pty = true, })
end

NIXOS_REBUILD_SWITCH = function()
	vim.fn.termopen("sudo nixos-rebuild switch --flake " .. FLAKE_PATH .. "#$hostname")
end

vim.api.nvim_create_user_command("HomeManagerSwitch", HOME_MANAGER_SWITCH, {})
vim.api.nvim_create_user_command("NixosRebuildSwitch", NIXOS_REBUILD_SWITCH, {})

vim.keymap.set("n", "<leader>nn", NIXOS_REBUILD_SWITCH)
vim.keymap.set("n", "<leader>hh", HOME_MANAGER_SWITCH)
