{
  config,
  lib,
  pkgs,
  nixos-symbolic,
  ...
}:
with lib; let
  cfg = config.programs.ags;
in {
  config = mkIf cfg.enable {
    programs.ags = {
      configDir = pkgs.stdenv.mkDerivation {
        name = "ags-dots";
        src = ./.;

        nativeBuildInputs = with pkgs; [bun sass];
        buildPhase = ''
          # Copy assets
          cp ${nixos-symbolic} ./assets/nixos-symbolic.svg

          # Build bun files
          bun install
          bun comp
        '';

        installPhase = ''
          mkdir -p $out
          cp -r config.js style.css assets $out
        '';
      };
    };
    home.packages = with pkgs; [bun sass];
  };
}
