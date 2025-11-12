{
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
with lib; {
  imports = [self.nixosModules.all ./hardware.nix ./disko.nix];

  # System
  networking.hostName = "desktop";
  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  # Users
  users.users = {
    bricked = {
      isNormalUser = true;
      description = "Bricked";
      extraGroups = ["networkmanager" "wheel" "gamemode" "uinput"];
    };
    personal = {
      isNormalUser = true;
      description = "Personal";
      extraGroups = ["networkmanager" "wheel" "uinput"];
    };
  };

  # Package Management
  nix = {
    package = pkgs.nix;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@wheel"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
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
      pkiBundle = "/var/lib/sbctl";
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
  programs.nixdg-ninja.enable = true;
  services.kanata.enable = true;

  # Desktop
  services.xserver.displayManager.gdm.enable = true;
  services.mithril-shell.enable = true;

  # Shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Gaming
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Networking
  services.tailscale.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  environment.systemPackages = with pkgs; [
    dconf2nix
    eza
    fd
    git
    hyperfine
    jaq
    moar
    nitch
    ripgrep
    rm-improved
    sd
    tealdeer
    vesktop
    xh
    (uutils-coreutils.override {prefix = "";})
  ];

  environment.variables = {
    EDITOR = "hx";
    PAGER = "moar";
    MOAR = "--wrap --quit-if-one-screen --colors 16";
  };
}
