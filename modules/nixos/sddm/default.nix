{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.xserver.displayManager.sddm;
in {
  config = mkIf cfg.enable {
    services.xserver.displayManager.sddm = {
      theme = "catppuccin-sddm-corners";
      wayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      catppuccin-sddm-corners
      libsForQt5.qtbase
      libsForQt5.qtsvg
      libsForQt5.qtgraphicaleffects
      libsForQt5.qtquickcontrols2
    ];
  };
}
