{ pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    # somehow completely breaks extensions if true
    mutableExtensionsDir = true;

    extensions =
      (with pkgs.vscode-extensions; [
        vscodevim.vim
        github.copilot
        mkhl.direnv

        # C++
        llvm-vs-code-extensions.vscode-clangd
        vadimcn.vscode-lldb
        twxs.cmake
        daohong-emilio.yash

        # Python
        ms-python.vscode-pylance
        ms-python.python
        ms-toolsai.jupyter
        ms-python.isort
        ms-python.black-formatter

        # nix
        jnoortheen.nix-ide

        # rust
        rust-lang.rust-analyzer
        tamasfe.even-better-toml

        # LaTeX
        james-yu.latex-workshop

        # other
        zxh404.vscode-proto3

        # Elixir
        elixir-lsp.vscode-elixir-ls

        # Go
        golang.go
      ])
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-antlr4";
          publisher = "mike-lischke";
          version = "2.4.6";
          sha256 = "sha256-h7ldX+XBzw5JzEB4ds7/XkhFlocfMza9lbQOdPqIYbE=";
        }
        {
          name = "cmake-format";
          publisher = "cheshirekow";
          version = "0.6.11";
          sha256 = "sha256-NdU8J0rkrH5dFcLs8p4n/j2VpSP/X7eSz2j4CMDiYJM=";
        }
        {
          name = "shader";
          publisher = "slevesque";
          version = "1.1.5";
          sha256 = "sha256-Pf37FeQMNlv74f7LMz9+CKscF6UjTZ7ZpcaZFKtX2ZM=";
        }
        {
          name = "wgsl";
          publisher = "PolyMeilex";
          version = "0.1.17";
          sha256 = "sha256-vGqvVrr3wNG6HOJxOnJEohdrzlBYspysTLQvWuP0QIw=";
        }
        {
          name = "zmk-tools";
          publisher = "spadin";
          version = "1.4.0";
          sha256 = "sha256-f67uOdfZTGdIGNVQuLuF6SeFZqKqBv455GILj36bZy8=";
        }
      ];

    userSettings = {
      "window.titleBarStyle" = "custom";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;

      "editor.lineNumbers" = "relative";
      "editor.bracketPairColorization.enabled" = true;
      "editor.wordWrap" = "on";

      "editor.minimap.enabled" = false;
      "workbench.editor.showTabs" = "single";

      "editor.fontFamily" = "Hack Nerd Font Mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.fontFamily" = "Hack Nerd Font Mono";

      "files.autoSave" = "onFocusChange";

      "terminal.integrated.commandsToSkipShell" = [
        "-workbench.action.quickOpen" # capture C-P
        "-workbench.action.terminal.focusFind" # capture C-F
        # Cursor
        "-aichat.newchataction"
      ];

      "extensions.ignoreRecommendations" = true;

      "vim.changeWordIncludesWhitespace" = false;
      "vim.overrideCopy" = true;
      "vim.highlightedyank.enable" = true;
      "vim.highlightedyank.duration" = 100;
      "vim.showMarksInGutter" = true;
      "vim.leader" = " ";
      "vim.useSystemClipboard" = true;
      "vim.incsearch" = true;
      "vim.hlsearch" = true;
      "vim.smartcase" = true;
      "vim.useCtrlKeys" = true;
      "vim.handleKeys" = {
        "<C-p>" = false;
      };
      "vim.sneak" = true;
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = [
            "<esc>"
          ];
          "commands" = [
            ":nohl"
          ];
        }
        {
          "before" = [
            "K"
          ];
          "commands" = [
            "editor.action.showHover"
          ];
        }
        {
          "before" = [
            "<leader>"
            "r"
            "n"
          ];
          "commands" = [
            "editor.action.rename"
          ];
        }
        {
          "before" = [
            "]"
            "d"
          ];
          "commands" = [ "editor.action.marker.nextInFiles" ];
          "silent" = true;
        }
        {
          "before" = [
            "["
            "d"
          ];
          "commands" = [ "editor.action.marker.prevInFiles" ];
          "silent" = true;
        }
      ];
      "vim.visualModeKeyBindingsNonRecursive" = [
        {
          "before" = [
            ">"
          ];
          "commands" = [
            "editor.action.indentLines"
          ];
        }
        {
          "before" = [
            "<"
          ];
          "commands" = [
            "editor.action.outdentLines"
          ];
        }
      ];

      "git.autofetch" = true;
      "git.confirmSync" = false;

      "[cpp]" = {
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.tabSize" = 2;
      };

      "[nix]" = {
        "editor.formatOnSave" = true;
      };
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "nixpkgs-fmt";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
        };
      };

      "[rust]" = {
        "editor.formatOnSave" = true;
      };
      "rust-analyzer.cargo.buildScripts.enable" = true;
      "rust-analyzer.check.command" = "clippy";

      "latex-workshop.latex.autoBuild.run" = "onSave";

      "go.inlayHints.assignVariableTypes" = false;
      "go.inlayHints.functionTypeParameters" = false;
      "go.inlayHints.parameterNames" = false;
      "go.inlayHints.compositeLiteralFields" = false;
      "go.inlayHints.compositeLiteralTypes" = false;
      "go.inlayHints.constantValues" = false;
      "go.inlayHints.rangeVariableTypes" = false;

      "go.useLanguageServer" = true;
      "gopls" = {
        "ui.semanticTokens" = true;
      };

    };

    keybindings = [
      {
        key = "ctrl+n";
        command = "workbench.action.quickOpenSelectNext";
        when = "inQuickOpen";
      }
      {
        key = "ctrl+p";
        command = "workbench.action.quickOpenSelectPrevious";
        when = "inQuickOpen";
      }
    ];
  };

  home.packages =
    with pkgs;
    [
      nil
      nixpkgs-fmt
      clang-tools
      cmake-language-server
      cmake-format
      jre_minimal
      texliveFull
    ]
    ++ [ nerd-fonts.hack ]
    ++ lib.optionals pkgs.stdenv.isLinux [ code-cursor ];
}
