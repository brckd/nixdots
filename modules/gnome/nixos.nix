{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.xserver.desktopManager.gnome;
in {
  config = mkIf cfg.enable {
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-connections
      kgx
      epiphany
      simple-scan
      gnome-software
      gnome-weather
      gnome-system-monitor
      evince
    ];
  };
}
