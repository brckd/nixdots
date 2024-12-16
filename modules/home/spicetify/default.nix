{
  config,
  lib,
  pkgs,
  spicetify-nix,
  spicetify-waveform-extension,
  ...
}:
with lib; let
  cfg = config.programs.spicetify;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  config = mkIf cfg.enable {
    programs.spicetify = {
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        beautifulLyrics
        {
          src = spicetify-waveform-extension;
          name = "waveform.js";
        }
      ];
    };
  };
}
