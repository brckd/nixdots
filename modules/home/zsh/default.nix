{ config, lib, ... }:

with lib; {
  options.modules.zsh = { enable = mkEnableOption "zsh"; };

  config = mkIf config.modules.zsh.enable {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      autocd = true;
    };
  };
}
