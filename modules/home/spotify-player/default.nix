{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.spotify-player;
in {
  options.programs.spotify-player = {
    enable = mkEnableOption "Whether to enable spotify-player, a Spotify player in the terminal with full feature parity.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [spotify-player];
  };
}
