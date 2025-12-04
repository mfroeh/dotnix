{ ... }:
{
  programs.nixvim = {
    plugins.telescope = {
      enable = false;
      extensions = {
        fzf-native.enable = true;
      };
      settings = {
        defaults = {
          mappings = {
            i = {
              "<C-j>" = "move_selection_next";
              "<C-k>" = "move_selection_previous";
              "<C-u>" = false;
            };
            n = {
              "<C-c>" = "close";
            };
          };
          layout_strategy = "horizontal";
          layout_config = {
            horizontal = {
              prompt_position = "top";
              preview_width = 0.5;
              width = {
                padding = 0;
              };
              height = {
                padding = 0;
              };
            };
          };
          prompt_prefix = "❯ ";
          selection_caret = "❯";
          entry_prefix = " ";
          path_display = [
            "filename_first"
          ];
          borderchars = [
            "─"
            "│"
            "─"
            "│"
            "┌"
            "┐"
            "┘"
            "└"
          ];
        };
      };
      keymaps = {
        "<leader>b" = {
          action = "buffers";
        };
        "gs" = {
          action = "lsp_document_symbols";
        };
        "gS" = {
          action = "lsp_workspace_symbols";
        };
        "<leader>m" = {
          action = "marks";
        };
        "<leader>fr" = {
          action = "oldfiles";
        };
        "<leader>ji" = {
          action = "zoxide list";
        };
        "<leader>ni" = {
          action = "zoxide list";
        };
      };

      extensions.zoxide = {
        enable = true;
      };

      luaConfig.post = ''
                        local prompt_with_hidden_toggle
                        prompt_with_hidden_toggle = function(opts, no_ignore, picker, picker_title)
                          opts = opts or {}
                          no_ignore = vim.F.if_nil(no_ignore, false)
                          opts.attach_mappings = function(_, map)
                            map({ "n", "i" }, "<C-.>", function(prompt_bufnr)
                              local prompt = require("telescope.actions.state").get_current_line()
                              require("telescope.actions").close(prompt_bufnr)
                              no_ignore = not no_ignore
                              prompt_with_hidden_toggle({ default_text = prompt }, no_ignore, picker, picker_title)
                            end)
                            return true
                          end

                          if no_ignore then
                            opts.no_ignore = true
                            opts.hidden = true
                            opts.prompt_title = picker_title .. " (all)"
        										opts.additional_args = function(opts) return { '--hidden', '--no-ignore' } end
                            picker(opts)
                          else
                            opts.prompt_title = picker_title
                            picker(opts)
                          end
                        end

                				vim.keymap.set("n", "<c-p>", function() prompt_with_hidden_toggle(nil, nil, require("telescope.builtin").find_files, "find files") end)
                				vim.keymap.set("n", "<leader>gg", function() prompt_with_hidden_toggle(nil, nil, require("telescope.builtin").live_grep, "grep") end)
                                			'';
    };
  };
}
