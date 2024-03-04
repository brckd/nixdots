{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.fastfetch;
in {
  options.programs.fastfetch = {
    enable = mkEnableOption "Whether to enable Fastfetch, a neofetch-like tool.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [fastfetch];
  };
}
