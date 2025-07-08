{ lib, pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "nightfox";
      simplified_ui = true;
      show_startup_tips = false;
    };
  };

  programs.zsh.sessionVariables = {
    ZELLIJ_AUTO_ATTACH = "false";
    ZELLIJ_AUTO_EXIT = "false";
  };

  programs.zsh.initContent = ''
    		if [[ ! -v ZED_TERM ]]; then
    			eval "$(${lib.getExe pkgs.zellij} setup --generate-auto-start zsh)"
    		fi
    	'';
}
