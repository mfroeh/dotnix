{ ... }:
let
  glove80 = [
    "x x x x x _ _ _ _ _ _ _ _ x x x x x"
    "x x x x x x _ _ _ _ _ _ x x x x x x"
    "x x x x x x _ _ _ _ _ _ x x x x x x"
    "x x x x x x _ _ _ _ _ _ x x x x x x"
    "x x x x x x x x x x x x x x x x x x"
    "x x x x x _ x x x x x x _ x x x x x"
  ];
  corne = [
    "x x x x x x x x x x x x x x"
    "x x x x x x x x x x x x x x"
    "x x x x x x _ _ x x x x x x"
    "_ _ _ x x x _ _ x x x _ _ _"
  ];
in
{
  programs.nixvim = {
    plugins.qmk = {
      enable = true;
      settings = {
        variant = "zmk";
        layout = glove80;
        name = "unused_for_zmk";
      };
    };
  };
}
