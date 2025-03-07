{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.nautilus.extensions.open-any-terminal;
in {
  options.programs.nautilus.extensions.open-any-terminal = {
    enable = mkEnableOption "opening terminal emulators other than gnome-terminal";
    terminal = mkOption {
      type = with types; nullOr str;
      default = null;
    };
  };
  config = mkIf cfg.enable {
    programs.nautilus-open-any-terminal = {
      enable = true;
      inherit (cfg) terminal;
    };

    programs.nautilus.extensions.python.enable = true;
  };
}
