{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.programs.spicetify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  config = mkIf cfg.enable {
    programs.spicetify = {
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        beautifulLyrics
        {
          src = inputs.spicetify-waveform-extension;
          name = "waveform.js";
        }
      ];
    };
  };
}
