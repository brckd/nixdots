{ config, pkgs, lib, ... }:

with lib; {
  options.modules.fastfetch = {enable = mkEnableOption "fastfetch"; };

  config = mkIf config.modules.fastfetch.enable {
    home.packages = with pkgs; [ fastfetch ];
  };
}
