{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.steam;
in {
  options.modules.steam = {
    enable = mkEnableOption "Enable Steam game launcher.";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
