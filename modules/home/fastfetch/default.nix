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
    enable = mkEnableOption "Fastfetch, a neofetch-like tool";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [fastfetch];
  };
}
