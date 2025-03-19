{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkForce types id;
  inherit (config.lib.themix) mkTargetOption;
  cfg = config.themix;
in {
  options.themix = {
    enable = mkEnableOption "Themix";
    force = mkEnableOption "overriding options";
    themes = {
      adwaita.enable = mkEnableOption "Adwaita";
      breeze.enable = mkEnableOption "Breeze";
      macos.enable = mkEnableOption "MacOS";
      windows.enable = mkEnableOption "Windows";
    };
    targets = {
      colors.enable = mkTargetOption "color palette";
      fonts.enable = mkTargetOption "fonts";
      icons.enable = mkTargetOption "icons";
      cursor.enable = mkTargetOption "cursor";
      gtk.enable = mkTargetOption "GTK";
      shell.enable = mkTargetOption "desktop shell";
      wallpaper.enable = mkTargetOption "wallpaper";
    };
    polarity = mkOption {
      description = "Polarity of the color palette";
      type = types.enum ["light" "dark"];
    };
  };

  config.lib.themix = {
    mkTargetOption = description:
      mkOption {
        description = "Whether to enable the ${description} target.";
        type = types.bool;
        default = true;
        example = false;
      };
    mkForcable =
      if cfg.force
      then mkForce
      else id;
  };
}
