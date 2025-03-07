{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.xserver;
in {
  config = mkIf cfg.enable {
    services.xserver.excludePackages = with pkgs; [
      xterm
    ];
  };
}
