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
  system.stateVersion = "25.05";
  networking.hostName = "laptop";
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
  };

  # Nix
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
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd = {
      enable = true;
      tpm2.enable = false;
    };
    plymouth.enable = true;
    silent = true;
  };
  systemd.tpm2.enable = false;

  # Preferences
  stylix.enable = true;
  locale = {
    timeZone = "Europe/Berlin";
    language = "en_DK.UTF-8";
    units = "en_DK.UTF-8";
    layout = "de";
  };
  services.kanata.enable = true;

  # Desktop
  services.xserver.displayManager.gdm.enable = true;
  services.mithril-shell.enable = true;

  # Shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Networking
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
  ];
}
