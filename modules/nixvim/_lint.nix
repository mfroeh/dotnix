{
  # this needs some more work to make it work
  plugins.lint = {
    enable = false;
    linters = {
      # "golangcilint".args = [ "" ];
    };

    lintersByFt = {
      # "go" = [ "golangcilint" ];
      "rust" = [ "clippy" ];
    };
  };

  autoCmd = [
    {
      desc = "async lint on write";
      event = [ "BufWritePost" ];
      pattern = [ "*" ];
      callback.__raw = ''
        function() 
          -- require("lint").try_lint() 
        end'';
    }
  ];
}
