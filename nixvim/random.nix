{ ... }:
{
  programs.nixvim = {
    plugins.grug-far = {
      enable = true;
      settings = {
        debounceMs = 200;
        engine = "ripgrep";
        settings = {
          engines = {
            ripgrep = {
              path = "rg";
            };
          };
        };
      };
    };

    plugins.harpoon = {
      enable = true;
    };
  };
}
