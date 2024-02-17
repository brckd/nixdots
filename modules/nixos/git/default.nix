{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.git;
in {
  options.modules.git = {
    enable = mkEnableOption "Enable Git.";
  };

  config = mkIf cfg.enable {
    programs.git.enable = true;
    environment.systemPackages = with pkgs; [ gh ];
  };
}
