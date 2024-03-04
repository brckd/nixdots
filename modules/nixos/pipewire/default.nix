{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.pipewire;
in {
  config = mkIf cfg.enable {
    services.pipewire = {
      alsa.enable = mkDefault true;
      alsa.support32Bit = mkDefault true;
      pulse.enable = mkDefault true;
    };
  };
}
