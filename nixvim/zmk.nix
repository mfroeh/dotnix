{ ... }:
{
  programs.nixvim = {
    plugins.qmk = {
      enable = true;
      settings = {
        variant = "zmk";
        layout = [
          "x x x x x _ _ _ _ _ _ _ _ x x x x x"
          "x x x x x x _ _ _ _ _ _ x x x x x x"
          "x x x x x x _ _ _ _ _ _ x x x x x x"
          "x x x x x x _ _ _ _ _ _ x x x x x x"
          "x x x x x x x x x x x x x x x x x x"
          "x x x x x _ x x x x x x _ x x x x x"
        ];
        name = "unused_for_zmk";
      };
    };
  };
}
