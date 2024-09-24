{
  config,
  lib,
  pkgs,
  ...
}:
with builtins;
with lib; let
  cfg = config.programs.vscode;
in {
  config = mkIf cfg.enable {
    programs.vscode = {
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        dbaeumer.vscode-eslint
        astro-build.astro-vscode
        rust-lang.rust-analyzer
        golang.go
        sumneko.lua
      ];
    };
  };
}
