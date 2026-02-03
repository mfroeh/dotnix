{
  lib,
  ...
}:
{
  options.flake.const = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.const = { };
}
