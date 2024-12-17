{
  pkgs,
  lib,
  nixpkgs,
  ...
}:
with lib; {
  imports = [./hardware.nix];

  # System
  networking.hostName = "desktop";
  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  # Users
  users.users = {
    bricked = {
      isNormalUser = true;
      description = "Bricked";
      extraGroups = ["networkmanager" "wheel" "gamemode"];
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

  # Package Management
  nix = {
    package = pkgs.nix;
    nixPath = ["nixpkgs=${nixpkgs}"];
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
  services.flatpak.enable = true;

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
  stylix = {
    enable = true;
    targets = {
      plymouth.enable = false;
    };
  };
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

  # Gaming
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Misc
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
    nodejs_23
    bun
    deno
    pnpm
    aoc-cli
    rustc
    cargo
    rustfmt
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
    libreoffice
    git
    kitty
    kooha
    switcheroo
    conjure
    upscaler
    curtail
    fragments
    dconf-editor
    dconf2nix
    nurl
    (writeShellScriptBin "wine-mono" "mono")
    (writeShellScriptBin "xdg-terminal-exec" "kitty -e $@")
  ];

  services.flatpak.packages = [
    "app.fotema.Fotema"
  ];
}
