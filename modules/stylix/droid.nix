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
    inputs.stylix.nixOnDroidModules.stylix
  ];
  config = mkIf cfg.enable {
    stylix.homeManagerIntegration.autoImport = false;
  };
}
