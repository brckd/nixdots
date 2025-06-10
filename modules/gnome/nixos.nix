{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.services.desktopManager.gnome;
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

    nixpkgs.overlays = [
      (final: prev: {
        src = inputs.mutter;
        preConfigure = ''
          cp -a "${inputs.gvdb} ./subprojects/gvdb"
        '';
      })
    ];
  };
}
