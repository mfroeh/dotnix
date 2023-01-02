{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xremap = {
    serviceMode = "system";
    # withSway = true;
    # withGnome = true;
    withX11 = true;
    watch = true;
    config = {
      keymap = [
        {
          name = "C-[ -> Esc";
          remap = {
            "C-Leftbrace" = "Esc";
          };
        }
      ];
    };
  };
}
