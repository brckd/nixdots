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
  system.stateVersion = "25.11";
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
  services.kanata = {
    enable = true;
    keyboards.default.devices = ["/dev/input/by-path/platform-i8042-serio-0-event-kbd"];
  };

  # Desktop
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.hyprland.enable = true;

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Networking
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Misc
  programs.nautilus = {
    enable = true;
    extensions.open-any-terminal = {
      enable = true;
      terminal = "ghostty";
    };
  };

  environment.systemPackages = with pkgs; [
    gimp
    fractal
    tuba
    libreoffice
    git
    ghostty
    kooha
    switcheroo
    conjure
    upscaler
    curtail
    fragments
    dconf-editor
    dconf2nix
    nurl
    nitch
    cavalier
    gnome-obfuscate
    mission-center
    collision
    papers
    (uutils-coreutils.override {prefix = "";})
    (writeShellScriptBin "xdg-terminal-exec" "ghostty -e $@")
  ];
}
