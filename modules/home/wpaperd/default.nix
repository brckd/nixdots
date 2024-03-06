{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.wpaperd;
in {
  config = mkIf cfg.enable {
    programs.wpaperd = {
      settings.default = {
        path = config.stylix.image;
      };
    };
    wayland.windowManager.hyprland.settings.exec-once = ["wpaperd"];
  };
}
