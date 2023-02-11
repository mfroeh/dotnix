{ config, pkgs, lib, ... }:
with lib;
let cfg = config.languages;
in {
  options.languages = {
    nix = mkOption {
      type = types.bool;
      default = false;
    };

    cpp = mkOption {
      type = types.bool;
      default = false;
    };

    python = mkOption {
      type = types.bool;
      default = false;
    };

    lua = mkOption {
      type = types.bool;
      default = false;
    };

    latex = mkOption {
      type = types.bool;
      default = false;
    };

    haskell = mkOption {
      type = types.bool;
      default = false;
    };

    rust = mkOption {
      type = types.bool;
      default = false;
    };

  };

  config = let
    nixPkgs = with pkgs; [ rnix-lsp nixfmt ];
    cppPkgs = with pkgs; [
      valgrind
      cmake
      gcc12
      gnumake
      gdb
      ddd
      meson
      ninja
      clang-tools_14
      cmake-language-server
    ];
    pythonPkgs = with pkgs; [
      (python3.withPackages
        (p: with p; [ numpy scipy ipykernel matplotlib pandas ]))
      nodePackages.pyright
    ];
    luaPkgs = with pkgs; [ sumneko-lua-language-server stylua ];
    latexPkgs = with pkgs; [ texlive.combined.scheme-full latexrun texlab ];
    haskellPkgs = with pkgs; [ ghc haskell-language-server ];
    rustPkgs = with pkgs; [ rust-bin.stable.latest.default rust-analyzer ]; /* rustc cargo rust-analyzer rustfmt ]; */
  in {
    home.packages = [ ] ++ optionals cfg.nix nixPkgs
      ++ optionals cfg.cpp cppPkgs ++ optionals cfg.python pythonPkgs
      ++ optionals cfg.lua luaPkgs ++ optionals cfg.latex latexPkgs
      ++ optionals cfg.haskell haskellPkgs ++ optionals cfg.rust rustPkgs;
  };
u
