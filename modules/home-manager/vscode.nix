{ config, pkgs, lib, pkgsUnstable, ... }: {
  programs.vscode = {
    enable = true;
    # mutableExtensionsDir = false;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
      "[python]"."editor.tabSize" = 2;
    };

    extensions = with pkgsUnstable.vscode-extensions; [
      vscodevim.vim
      ms-toolsai.jupyter
      # ms-python.python
      # ms-vscode.cpptools
    ];
  };
}
