{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.heroic;
  json = pkgs.formats.json {};
in {
  options.programs.heroic = {
    enable = mkEnableOption "Heroic game launcher";

    settings = {
      general = mkOption {
        type = json.type;
        default = {};
        description = "Attribute set of general Heroic settings.";
      };

      store = mkOption {
        type = json.type;
        default = {};
        description = "Attribute set of Heroic store settings.";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [heroic];

    xdg.configFile = {
      "heroic/config.json".source = json.generate "heroic-config" cfg.settings.general;
      "heroic/store/config.json".source = json.generate "heroic-store-config" cfg.settings.store;
    };
  };
}
