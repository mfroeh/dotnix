{ self, pkgs, system, inputs }: 
let
    isDarwin = system: (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
    homePrefix = system: if isDarwin system then "/Users" else "/home";
in {
    imports = [ "${self}/modules/fish.nix" "${self}/modules/nvim.nix" ];

    home.username = "mo";
    # home.homeDirectory = "${homePrefix system}/mo";
    home.homeDirectory = "/Users/mo";
    home.stateVersion = "22.11";

    programs.home-manager.enable = true;

programs.fzf = {
enable = true;
enableFishIntegration = true;
};
}
