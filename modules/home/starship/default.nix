{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.starship;
  loadPreset = name: with builtins; fromTOML (readFile "${pkgs.starship}/share/starship/presets/${name}.toml");
  plainTextSymbols = loadPreset "plain-text-symbols";
in {
  config = mkIf cfg.enable {
    programs.starship.settings = plainTextSymbols;
  };
}
