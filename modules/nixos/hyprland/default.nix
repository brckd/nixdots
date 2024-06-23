{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.hyprland;
in {
  config = mkIf cfg.enable {
    hardware.graphics.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
