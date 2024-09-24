{
  config,
  lib,
  pkgs,
  spicetify-nix,
  ...
}:
with lib; let
  cfg = config.programs.spicetify;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  config = mkIf cfg.enable {
    programs.spicetify = {
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        beautifulLyrics
        {
          src = pkgs.fetchFromGitHub {
            owner = "SPOTLAB-Live";
            repo = "Spicetify-waveform";
            rev = "89fa8a6e29258984bc296790e6f41ee017e87c71";
            hash = "sha256-LOOtdlnpKRE/D95hbuk8vTtFUsA+nUtmsKTiQiy2s7w=";
          };
          name = "waveform.js";
        }
      ];
      enabledCustomApps = with spicePkgs.apps; [
        ncsVisualizer
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
