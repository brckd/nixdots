{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault mkEnableOption;
  cfg = config.services.mithril-shell;
in {
  options.services.mithril-shell = {
    enable = mkEnableOption "Mithril Shell";
  };

  config = mkIf cfg.enable {
    fonts.packages = [pkgs.adwaita-fonts];
    hardware.bluetooth.enable = mkDefault true;
    networking.networkmanager.enable = mkDefault true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    programs.dconf.enable = mkDefault true;
    programs.file-roller.enable = mkDefault true; # Archive manager
    programs.geary.enable = mkDefault true; # Mail client
    programs.gnome-disks.enable = mkDefault true; # Disks viewer
    programs.hyprland.enable = true; # Wayland compositor
    programs.seahorse.enable = mkDefault true; # Secrets manager
    services.udisks2.enable = mkDefault true; # Mount disks
    services.upower.enable = mkDefault true; # Battery status

    environment.systemPackages = [
      pkgs.baobab # Disk usage analyzer
      pkgs.bottles # Wine manager
      pkgs.cartero # API client
      pkgs.cartridges # Game library
      pkgs.collision # Hash viewer
      pkgs.fragments # BitTorrent client
      pkgs.decibels # Audio player
      pkgs.dconf-editor # DConf editor
      pkgs.d-spy # D-Bus viewer
      pkgs.eloquent # Proofreading software
      pkgs.fractal # Matrix client
      pkgs.geopard # Gemini browser
      pkgs.ghostty # Terminal emulator
      pkgs.gimp3 # Image editor
      pkgs.gnome-text-editor # Text editor
      pkgs.gnome-calculator # Calculator application
      pkgs.gnome-calendar # Calendar application
      pkgs.gnome-characters # Characters viewer
      pkgs.gnome-clocks # Clock application
      pkgs.gnome-contacts # Address book
      pkgs.gnome-font-viewer # Font library
      pkgs.gnome-logs # Systemd journal viewer
      pkgs.gnome-maps # Map application
      pkgs.gnome-weather # Weather application
      pkgs.ghex # Hex editor
      pkgs.gradia # Screenshot annotation program
      pkgs.grim # Screenshot application
      pkgs.icon-library # Icon library
      pkgs.inspector # System information viewer
      pkgs.libreoffice # Office application
      pkgs.loupe # Image viewer
      pkgs.mission-center # System monitor
      pkgs.nautilus # File manager
      pkgs.papers # Document viewer
      pkgs.pinta # Drawing program
      pkgs.snapshot # Camera application
      pkgs.totem # Movie player
      pkgs.tuba # Mastodon client
      pkgs.typewriter # Typst editor
      pkgs.wl-clipboard # Clipboard manager
      (pkgs.writeShellScriptBin "xdg-terminal-exec" "ghostty -e $@")
    ];
  };
}
