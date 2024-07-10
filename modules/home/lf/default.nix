{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.lf;
in {
  config = mkIf cfg.enable {
    programs.lf = {
      commands = {
        q = "quit";
      };
      previewer = {
        keybinding = "i";
        source = "${pkgs.ctpv}/bin/ctpv";
      };
      extraConfig = ''
        &${pkgs.ctpv}/bin/ctpv -s $id
        cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
        set cleaner ${pkgs.ctpv}/bin/ctpvclear
      '';
    };
  };
}
