{ config, pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    # enableExtensionUpdateCheck = false;
    # enableUpdateCheck = false;
    userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
    };

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      # ms-toolsai.jupyter
      # ms-python.python
      # ms-vscode.cpptools
    ];
  };
}
