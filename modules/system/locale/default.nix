{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.locale;
in {
  options.modules.locale = {
    timeZone = mkOption {
      example = "Etc/UTC";
      type = with types; nullOr str;
      description = "The time zone used when displaying times and dates.";
    };

    language = mkOption {
      example = "en_US.UTF-8";
      type = with types; nullOr str;
      description = "The language to display applications in.";
    };

    units = mkOption {
      example = "en_US.UTF-8";
      type = with types; nullOr str;
      description = "The locale to display units in.";
    };

    layout = mkOption {
      example = "us";
      type = with types; nullOr str;
      description = "The keyboard layout used for console and Xorg.";
    };
  };

  config = {
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
    };

    console.keyMap = cfg.layout;
  };
}
