{ config, lib, pkgs, getchoo, ... }:

with lib;

let cfg = config.modules.theseus;
in {
  options.modules.theseus = {
    enable = mkEnableOption "Enable Minecraft";
  };

  config = mkIf cfg.enable {
    home.packages = with getchoo.packages.${pkgs.system}; [
      modrinth-app
    ];
  };
}
