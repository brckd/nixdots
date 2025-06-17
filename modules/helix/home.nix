{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.helix;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [nixd rust-analyzer marksman astro-language-server typescript typescript-language-server yaml-language-server python313Packages.python-lsp-server];
  };
}
