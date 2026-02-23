{
  flake.nixvim.typst = {
    plugins = {
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

    # TODO: doesnt work
    # hmConfig.home.packages = [
    #   pkgs.typst
    #   pkgs.typstyle
    # ];
  };
}
