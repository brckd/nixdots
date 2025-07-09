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
    programs.hyprlock.enable = true;
    services.pipewire.wireplumber.enable = true;
    services.playerctld.enable = true;
  };
}
