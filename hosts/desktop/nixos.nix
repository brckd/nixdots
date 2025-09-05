{
  pkgs,
  config,
  lib,
  inputs,
  systems,
  self,
  ...
}:
with lib; {
  imports = [self.nixosModules.all ./hardware.nix ./disko.nix];

  # System
  networking.hostName = "desktop";
  system.stateVersion = "25.11";
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
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    overrides.global.Context.sockets = ["wayland" "!x11" "!fallback-x11"]; # Force Wayland by default
  };
  services.snap.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.nix-data = {
    enable = true;
    systemconfig = "${./nixos.nix}";
    flake = "${self.lib.tree.dirs.root}/flake.nix";
  };

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
  services.displayManager.gdm.enable = true;
  services.mithril-shell.enable = true;

  # Shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Gaming
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Virtualisation
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  boot.binfmt.emulatedSystems = filter (sys: sys != pkgs.system) systems;
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

  # Networking
  services.tailscale.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
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

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    dconf2nix
    distrobox
    distroshelf
    eza
    fd
    git
    gnome-boxes
    hyperfine
    jaq
    moar
    nitch
    qemu
    ripgrep
    rm-improved
    sd
    tealdeer
    vesktop
    xh
    inputs.nix-fast-build.packages.${system}.default
    inputs.nix-alien.packages.${system}.nix-alien
    (uutils-coreutils.override {prefix = "";})
  ];

  environment.variables = {
    EDITOR = "hx";
    PAGER = "moar";
    MOAR = "--wrap --quit-if-one-screen --colors 16";
  };
}
