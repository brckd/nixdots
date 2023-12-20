{ config, pkgs, lib, ... }:

with lib; {
  options.modules."spotify-player" = {enable = mkEnableOption "spotify-player"; };

  config = mkIf config.modules."spotify-player".enable {
    home.packages = with pkgs; [ spotify-player ];

    home.file.".config/spotify-player/app.toml".source = ./app.toml;
  };
}
