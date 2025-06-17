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
    enabledExtensions = with spicePkgs.extensions; [
      beautifulLyrics
      {
        src = inputs.spicetify-waveform-extension;
        name = "waveform.js";
      }
    ];
  };
}
