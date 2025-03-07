{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.lf;
in {
  options.programs.lf = {
    ctpv.enable = mkEnableOption "ctpv plugin";
  };

  config = mkIf cfg.enable {
    programs.lf = {
      commands = {
        q = "quit";
      };
      previewer = mkIf cfg.ctpv.enable {
        keybinding = "i";
        source = "${pkgs.ctpv}/bin/ctpv";
      };
      extraConfig = mkIf cfg.ctpv.enable ''
        &${pkgs.ctpv}/bin/ctpv -s $id
        cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
        set cleaner ${pkgs.ctpv}/bin/ctpvclear
      '';
    };
  };
}
