{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.forge;
in {
  options.stylix.targets.forge.enable =
    config.lib.stylix.mkEnableTarget "Forge Gnome extension" true;

  config = mkIf (config.stylix.enable && cfg.enable) {
    xdg.configFile."forge/stylesheet/forge/stylesheet.css".source = config.lib.stylix.colors {
      template = ./stylesheet.css.mustache;
      extension = ".css";
    };
  };
}
