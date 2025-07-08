{
  config,
  lib,
  ...
}: let
  cfg = config.programs.hyprland;

  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    programs.hyprland.withUWSM = true;
  };
}
