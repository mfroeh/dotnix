{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    userSettings = { 
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
    };
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jnoortheen.nix-ide
    ];
  };
}
