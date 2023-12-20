{ config, pkgs, lib, ... }:

with lib; {
  options.modules.kitty = {enable = mkEnableOption "kitty"; };

  config = mkIf config.modules.kitty.enable {
    home.packages = with pkgs; [ kitty ];
    
    programs.kitty.font.package = pkgs.cascadia-mono;
    programs.kitty.font.name = "Cascadia Mono";
  };
}
