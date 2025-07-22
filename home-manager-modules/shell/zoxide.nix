{ ... }:
{
  # [j]ump to directories (cd on a ton of roids)
  programs.zoxide = {
    enable = true;
    options = [ "--no-cmd" ];
  };

  programs.zsh.shellAliases = {
    "j" = "__zoxide_z";
    "ji" = "__zoxide_zi";
    "n" = "__zoxide_z";
    "ni" = "__zoxide_zi";
  };
}
