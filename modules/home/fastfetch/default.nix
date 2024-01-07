{ config, pkgs, lib, ... }:

with lib; {
  options.modules.fastfetch = {
    enable = mkEnableOption "Enable Fastfetch system information tool.";
  };

  config = mkIf config.modules.fastfetch.enable {
    home.packages = with pkgs; [ fastfetch ];
  };
}
