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

  config = mkIf (config.stylix.enable && cfg.integrations.stylix.enable) {
    services.mithril-shell = {
      theme.colors.primary = config.lib.stylix.colors.base0D;
      settings.lockCommand = "${pkgs.hyprlock}/bin/hyprlock --immediate";
    };
  };
}
