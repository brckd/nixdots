{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.bun;
in {
  options.programs.bun = {
    enable = mkEnableOption "Bun";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [bun];
  };
}
