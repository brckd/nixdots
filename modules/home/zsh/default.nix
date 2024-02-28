{ config, lib, ... }:

with lib;

let
  cfg = config.programs.zsh;
in {
  config = mkIf cfg.enable {
    programs.zsh = {
      enableAutosuggestions = mkDefault true;
      enableSyntaxHighlighting = mkDefault true;
      autocd = mkDefault true;
    };
  };
}
