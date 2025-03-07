{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.steam;
in {
  config = mkIf cfg.enable {
    programs.steam = {
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
