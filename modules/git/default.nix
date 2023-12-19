{ config, pkgs, lib, ... }:

with lib; {
  options.modules.git = { enable = mkEnableOption "git"; };

  config = mkIf config.modules.git.enable {
    home.packages = with pkgs; [ git ];
  };
}
