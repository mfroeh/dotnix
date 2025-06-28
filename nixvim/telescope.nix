{ ... }: {
	programs.nixvim = {
		plugins.telescope = {
			enable = true;
			extensions = {
				fzf-native.enable = true;
			};
			keymaps = {
				"<return>" = {
					action = "git_files";
				};
				"<c-,>" = {
					action = "buffers";
				};
				"gs" = {
					action = "lsp_document_symbols";
				};
				"gS" = {
					action = "lsp_workspace_symbols";
				};
			};
		};
	};
}
