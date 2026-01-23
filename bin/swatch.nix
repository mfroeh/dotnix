{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "swatch";

  runtimeInputs = [ ];

  text = ''
    nowSeconds=$(date +%s)sec
    while true; do
      delta=$(TZ=UTC date --date now-"$nowSeconds" +%H:%M:%S.%N)
      printf "%s\r" "$delta"
      sleep 0.1
    done
  '';
}
