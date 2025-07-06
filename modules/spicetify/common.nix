{
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  config.programs.spicetify = {
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };
}
