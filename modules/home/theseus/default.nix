{ config, lib, pkgs, getchoo, ... }:

with lib;

let
  cfg = config.programs.theseus;
in {
  options.programs.theseus = {
    enable = mkEnableOption "Whether to enable Theseus, a game launcher which can be used as a CLI, GUI, and a library for creating and playing Modrinth projects.";
  };

  config = mkIf cfg.enable {
    home.packages = with getchoo.packages.${pkgs.system}; [ modrinth-app ];
  };
}
