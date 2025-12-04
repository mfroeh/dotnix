{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.gwenview
    adwaita-qt
    adwaita-qt6
  ];

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };
}
