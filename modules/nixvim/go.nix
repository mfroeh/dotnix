{
  flake.nixvim.go =
    { pkgs, ... }:
    {
      plugins.lsp.servers.gopls = {
        enable = true;
        package = pkgs.gopls;
        packageFallback = true;
      };

      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "gotests";
          src = pkgs.fetchFromGitHub {
            owner = "yanskun";
            repo = "gotests.nvim";
            rev = "main";
            hash = "sha256-qI4N8Lj6ZocfN9EiN8d5b8RFsc/ZLOgzyC2W6d+S0nU=";
          };
        })
      ];

      extraConfigLuaPost = ''
        vim.g.gotests_bin = "${pkgs.gotests}/bin/gotests"
        require("gotests").setup {}
      '';

      userCommands = {
        GotoTests = {
          command.__raw = ''
            function()
              local function openBuffer(path)
                local bufNr = vim.fn.bufnr(path)
                if bufNr ~= -1 and vim.api.nvim_buf_is_loaded(bufNr) then
                  vim.api.nvim_set_current_buf(bufNr)
                else
                  vim.cmd("edit " .. vim.fn.fnameescape(path))
                end
              end

              local ext = vim.fn.expand("%:e")
              if ext ~= 'go' then
                return
              end

              local filePath = vim.fn.expand("%:p")

              if filePath:match("_test%.go$") then
                local target = filePath:gsub("_test%.go$", ".go")
                openBuffer(target)
              else
                local target = filePath:gsub("%.go$", "_test.go")
                openBuffer(target)
              end
            end
          '';
        };
      };

      keymaps = [
        {
          key = "<leader>tt";
          mode = "n";
          action = "<cmd>GotoTests<cr>";
        }
      ];
    };
}
