{ config, pkgs, lib, ... }:

with lib; {
  options.modules.librewolf = { enable = mkEnableOption "librewolf"; };

  config = mkIf config.modules.librewolf.enable {
    home.packages = with pkgs; [ librewolf ];
  };
}
