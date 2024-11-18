{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [./hardware.nix];

  # System
  networking.hostName = "desktop";
  system.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;

  # Users
  users.users = {
    bricked = {
      isNormalUser = true;
      description = "Bricked";
      extraGroups = ["networkmanager" "wheel"];
    };
    personal = {
      isNormalUser = true;
      description = "Personal";
      extraGroups = ["networkmanager" "wheel"];
    };
    john = {
      isNormalUser = true;
      description = "John";
      extraGroups = ["networkmanager"];
    };
  };

  # Nix
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@wheel"];
    };
  };
  programs.nh.enable = true;

  # Boot
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    initrd.systemd.enable = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    plymouth.enable = true;
    silent = true;
  };

  # Preferences
  stylix.enable = true;
  locale = {
    timeZone = "Europe/Berlin";
    language = "en_DK.UTF-8";
    units = "en_DK.UTF-8";
    layout = "de";
  };

  # Desktop
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Misc
  programs.steam.enable = true;
  programs.nautilus = {
    enable = true;
    extensions.open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
  };

  environment.systemPackages = with pkgs; [
    comma
    busybox
    nodejs_22
    rustc
    cargo
    clang
    gimp
    wineWowPackages.waylandFull
    winetricks
    mono5
    cartridges
    heroic
    modrinth-app
    itch
    fractal
    tuba
    git
    kitty
    mission-center
    (writeShellScriptBin "wine-mono" "mono")
    (writeShellScriptBin "xdg-terminal-exec" "kitty -e $@")
  ];
}
