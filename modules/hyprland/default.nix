{ config, pkgs, lib, ... }:

with lib; {
  options.modules.hyprland = {enable = mkEnableOption "hyprland"; };

  config = mkIf config.modules.hyprland.enable {
    home.packages = with pkgs; [ hyprland ];

    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  };
}
