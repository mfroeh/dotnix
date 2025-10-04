{ ... }:
{
  programs.nixvim = {
    plugins.qmk = {
      enable = true;
      settings = {
        variant = "zmk";
        layout = [
          "x x x x x x x x x x x x x x"
          "x x x x x x x x x x x x x x"
          "x x x x x x _ _ x x x x x x"
          "_ _ _ x x x _ _ x x x _ _ _"
        ];
        name = "unused_for_zmk";
      };
    };
  };
}
