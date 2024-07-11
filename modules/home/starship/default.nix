{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.starship;
  loadPreset = name: with builtins; fromTOML (readFile "${pkgs.starship}/share/starship/presets/${name}.toml");
  nerdFontSymbols = loadPreset "nerd-font-symbols";
in {
  config = mkIf cfg.enable {
    programs.starship.settings = nerdFontSymbols // {};
  };
}
