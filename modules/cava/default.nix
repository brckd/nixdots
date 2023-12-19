{ config, pkgs, lib, ... }:

with lib; {
  options.modules.cava = {enable = mkEnableOption "cava"; };

  config = mkIf config.modules.cava.enable {
    home.packages = with pkgs; [ kitty ];
  };
}
