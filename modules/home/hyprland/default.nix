{ config, pkgs, lib, ... }:

with lib; {
  options.modules.hyprland = {
    enable = mkEnableOption "Enable Hyprland Wayland compositor.";
  };

  config = mkIf config.modules.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = readFile ./hyprland.conf;
    };
  };
}
