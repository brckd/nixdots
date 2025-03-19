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
    inputs.stylix.nixosModules.stylix
  ];
  config = mkIf cfg.enable {
    stylix = {
      cursor.size = 24;
      homeManagerIntegration.autoImport = false;
      targets.plymouth.enable = false;
      targets.qt.enable = true;
    };
  };
}
