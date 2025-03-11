{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.stylix;
in {
  imports = [
    ./common.nix
    inputs.stylix.homeManagerModules.stylix
  ];
  config = mkIf cfg.enable {
    stylix = {
      iconTheme = {
        enable = true;
        package = pkgs.morewaita-icon-theme;
        dark = "MoreWaita";
      };
      targets.librewolf = {
        profileNames = ["default"];
        colorTheme.enable = true;
        firefoxGnomeTheme.enable = true;
      };
      targets.vscode.profileNames = ["default"];
    };
  };
}
