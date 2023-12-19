{ config, pkgs, lib, ... }:

with lib; {
  options.modules.kitty = {enable = mkEnableOption "kitty"; };

  config = mkIf config.modules.kitty.enable {
    home.packages = with pkgs; [ kitty ];
  };
}
