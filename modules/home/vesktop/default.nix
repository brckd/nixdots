{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.vesktop;
in {
  options.programs.vesktop = {
    enable = mkEnableOption "Vesktop";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [vesktop];
  };
}
