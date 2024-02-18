{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.steam;
in {
  config = mkIf cfg.enable {
    programs.steam = {
      remotePlay.openFirewall = mkDefault true;
      dedicatedServer.openFirewall = mkDefault true;
    };
  };
}
