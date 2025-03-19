{
  config,
  lib,
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
      iconTheme.enable = true;
      cursor.size = 24;
      targets.librewolf = {
        profileNames = ["default"];
        colorTheme.enable = true;
        firefoxGnomeTheme.enable = true;
      };
      targets.vscode.profileNames = ["default"];
    };
  };
}
