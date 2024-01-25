{ config, pkgs, lib, ... }:

with lib; 

let cfg = config.modules.eww;
in {
  options.modules.eww = {
    enable = mkEnableOption "Enable ElKowars wacky widgets.";
  };

  config = mkIf cfg.enable {
    programs.eww = {
      enable = true;
      package = pkgs.eww-wayland;
      configDir = ./config;
    };
  };
}
