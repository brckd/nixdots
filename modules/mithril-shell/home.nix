{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.services.mithril-shell;
in {
  imports = [inputs.mithril-shell.homeManagerModules.default];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [grim];
    services.swaync.enable = true;

    services.mithril-shell = mkIf (config.stylix.enable && cfg.integrations.stylix.enable) {
      theme.colors.primary = config.lib.stylix.colors.base0D;
      settings.lockCommand = "${pkgs.hyprlock}/bin/hyprlock --immediate";
    };
  };
}
