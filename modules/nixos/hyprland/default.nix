{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.hyprland;
in {
  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
