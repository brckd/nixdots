{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.hyprland;
in {
  options.modules.hyprland = {
    enable = mkEnableOption "Enable Hyprland Wayland compositor.";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
    };

    hardware.opengl = {
      enable = true;
      driSupport = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
