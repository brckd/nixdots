{
  config,
  lib,
  pkgs,
  ...
}: {
  options.stylix.targets.steam.enable = config.lib.stylix.mkEnableTarget "Steam" true;

  config = lib.mkIf (config.stylix.enable && config.stylix.targets.steam.enable) {
    home.packages = with pkgs; [adwsteamgtk];

    home.activation.adwaitaForSteam = let
      shellScript = pkgs.writeShellScript "adwaitaForSteam" ''
        rm -f "$HOME/.cache/AdwSteamInstaller/extracted/custom/custom.css"
        ${lib.getExe pkgs.adwsteamgtk}  -i
      '';
    in
      config.lib.dag.entryAfter ["writeBoundary" "dconfSettings"] ''
        run --quiet ${shellScript}
      '';

    xdg.configFile."AdwSteamGtk/custom.css".source = config.lib.stylix.colors {
      template = ./custom.mustache;
      extension = "css";
    };

    # Use custom.css
    dconf.settings."io/github/Foldex/AdwSteamGtk".prefs-install-custom-css = true;
  };
}
