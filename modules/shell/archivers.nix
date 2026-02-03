{ self, ... }:
{
  flake.modules.homeManager.archivers =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gnutar
        unrar
        gzip
        unzip
        p7zip
        ncompress
        zstd
        # compress/decompress between different formats (in particular zlib): `pigz -dcz $YOUR_FILE` decompresses a zlib encoded file to STDOUT
        pigz

        (import "${self}/bin/ex.nix" { inherit pkgs; })
      ];
    };
}
