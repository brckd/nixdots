{
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
with lib; let
  proxy = "http://10.16.1.1:8080";
in {
  # This configuration is made to be used with nixos-generators.
  # It may not work on live systems.

  imports = [self.nixosModules.all];

  # System
  networking.hostName = "school";
  nixpkgs.config.allowUnfree = true;

  # Users
  users.users.student = {
    isNormalUser = true;
    description = "Student";
    extraGroups = ["networkmanager" "wheel"];
    initialPassword = "student";
  };

  # Package Management
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@wheel"];
    };
    gc.automatic = true;
  };
  programs.nh.enable = true;
  services.flatpak.enable = true;

  # Boot
  boot = {
    plymouth.enable = true;
    initrd.systemd.tpm2.enable = false;
    silent = true;
    loader.timeout = mkForce 0;
  };
  systemd.tpm2.enable = false;

  # Networking
  systemd.services.nix-daemon.environment = {
    http_proxy = proxy;
    https_proxy = proxy;
  };
  networking.proxy = {
    default = proxy;
    noProxy = "127.0.0.1,localhost";
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
  programs.nautilus = {
    enable = true;
    extensions.open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
  };

  environment.systemPackages = with pkgs; [
    libreoffice
    git
    kitty
    nitch
    mission-center
    blender
    godot_4
    gimp
    gnome-software
    inputs.nix-software-center.packages.${system}.nix-software-center
    (writeShellScriptBin "xdg-terminal-exec" "kitty -e $@")
  ];
}
