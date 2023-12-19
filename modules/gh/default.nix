{ config, pkgs, lib, ... }:

with lib; {
  options.modules.gh = {enable = mkEnableOption "gh"; };

  config = mkIf config.modules.gh.enable {
    home.packages = with pkgs; [ gh ];
  };
}
