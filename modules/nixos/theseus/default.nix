{
  config,
  lib,
  pkgs,
  getchoo,
  ...
}:
with lib; let
  cfg = config.programs.theseus;
in {
  options.programs.theseus = {
    enable = mkEnableOption "Theseus, a launcher for Modrinth projects";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with getchoo.packages.${pkgs.system}; [modrinth-app];
  };
}
