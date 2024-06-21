{ config, pkgs, lib, platform, ... }: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    extensions = (with pkgs.vscode-extensions; [
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
      arrterian.nix-env-selector

      # rust
      rust-lang.rust-analyzer

      # LaTeX
      james-yu.latex-workshop
    ]) ++
    pkgs.vscode-utils.extensionsFromVscodeMarketplace
      [
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
      ];

    userSettings = {
      "window.titleBarStyle" = "custom";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;

      "editor.lineNumbers" = "relative";
      "editor.bracketPairColorization.enabled" = true;

      "editor.fontFamily" = "Hack Nerd Font Mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.fontFamily" = "Hack Nerd Font Mono";

      "files.autoSave" = "onFocusChange";

      "terminal.integrated.commandsToSkipShell" = [
        "-workbench.action.quickOpen" # capture C-P
        "-workbench.action.terminal.focusFind" # capture C-F
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

      "[cpp]" = {
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.tabSize" = 2;
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
      "[nix]" = {
        "editor.formatOnSave" = true;
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

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [ nil nixpkgs-fmt clang-tools cmake-language-server cmake-format jre_minimal texliveFull ] ++ [ (nerdfonts.override { fonts = [ "Hack" ]; }) ];
}

# TODO= impure for now bcuz lazy
# programs.vscode = {
#   enable = true;
#   package = pkgs.vscode.fhsWithPackages (ps= with ps; [ ]);
# };
