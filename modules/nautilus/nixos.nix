{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.nautilus;
in {
  imports = [./extensions];
  options.programs.nautilus = {
    enable = mkEnableOption "Nautilus";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [nautilus];
  };
}
