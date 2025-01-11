{
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; {
  imports = [./hardware.nix ./disko.nix];

  # System
  networking.hostName = "laptop";
  system.stateVersion = "25.05";
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

  # Virtualisation
  virtualisation.libvirtd.enable = true;

  # Misc
  programs.nautilus = {
    enable = true;
    extensions.open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
  };

  # Taken from https://github.com/NixOS/nixpkgs/issues/115996#issuecomment-2224296279
  # Fixes libvirtd QEMU integration for GNOME boxes
  systemd.tmpfiles.rules = let
    firmware = pkgs.runCommandLocal "qemu-firmware" {} ''
      mkdir $out
      cp ${pkgs.qemu}/share/qemu/firmware/*.json $out
      substituteInPlace $out/*.json --replace ${pkgs.qemu} /run/current-system/sw
    '';
  in ["L+ /var/lib/qemu/firmware - - - - ${firmware}"];

  environment.systemPackages = with pkgs; [
    comma
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
    nitch
    cavalier
    gnome-obfuscate
    mission-center
    collision
    gnome-boxes
    qemu
    (uutils-coreutils.override {prefix = "";})
    (writeShellScriptBin "xdg-terminal-exec" "kitty -e $@")
  ];
}
