{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.vesktop;
in {
  options.programs.vesktop = {
    enable = mkEnableOption "Enable Discord chat app.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ vesktop ];
  };
}
