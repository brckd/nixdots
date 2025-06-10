{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.stylix;
in {
  imports = [
    ./common.nix
    inputs.stylix.homeModules.stylix
  ];
  config = mkIf cfg.enable {
    stylix = {
      iconTheme.enable = true;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };
      targets.librewolf = {
        profileNames = ["default"];
        firefoxGnomeTheme.enable = true;
      };
      targets.vscode.profileNames = ["default"];
    };
  };
}
