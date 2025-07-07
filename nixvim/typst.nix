{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    lsp.servers.tinymist = {
      enable = true;
    };

    typst-preview = {
      enable = true;
      settings = {
        exportPdf = "onType";
        formatterMode = "typstyle";
        semanticTokens = "enable";
        systemFonts = true;
      };
    };
  };

  home.packages = [
    pkgs.typst
		pkgs.typstyle
  ];
}
