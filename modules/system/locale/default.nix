{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.locale;
in {
  options.modules.locale = {
    enable = mkEnableOption "Enable locale configurations";

    timeZone = mkOption {
      example = "Etc/UTC";
      type = types.str;
      description = "The time zone used when displaying times and dates.";
    };

    language = mkOption {
      example = "en_US.UTF-8";
      type = types.str;
      description = "The language to display applications in.";
    };

    units = mkOption {
      example = "en_US.UTF-8";
      type = types.str;
      description = "The locale to display units in.";
    };

    layout = mkOption {
      example = "us";
      type = types.str;
      description = "The keyboard layout used for console and Xorg.";
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.timeZone;

    i18n = {
      defaultLocale = cfg.language;

      extraLocaleSettings = {
        LC_ADDRESS = cfg.units;
        LC_IDENTIFICATION = cfg.units;
        LC_MEASUREMENT = cfg.units;
        LC_MONETARY = cfg.units;
        LC_NAME = cfg.units;
        LC_NUMERIC = cfg.units;
        LC_PAPER = cfg.units;
        LC_TELEPHONE = cfg.units;
        LC_TIME = cfg.units;
      };
    };

    services.xserver = {
      layout = cfg.layout;
      xkbVariant = "";
    };

    console.keyMap = cfg.layout;
  };
}
