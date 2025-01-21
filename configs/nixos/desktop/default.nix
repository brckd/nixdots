{
  pkgs,
  config,
  lib,
  inputs,
  systems,
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
      extraGroups = ["networkmanager" "wheel" "gamemode" "uinput"];
    };
    personal = {
      isNormalUser = true;
      description = "Personal";
      extraGroups = ["networkmanager" "wheel" "uinput"];
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
  programs.nix-ld.enable = true;
  programs.nix-index-database.comma.enable = true;

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
  services.kanata = {
    enable = true;
    keyboards.default.devices = ["/dev/input/by-id/usb-Razer_Razer_Huntsman_Mini_00000000001A-event-kbd"];
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

  # Virtualisation
  virtualisation = {
    waydroid.enable = true;
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
  };
  boot.binfmt.emulatedSystems = filter (sys: sys != pkgs.system) systems;
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

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
    nodejs_23
    bun
    deno
    pnpm
    aoc-cli
    rustc
    cargo
    rustfmt
    clang
    wineWowPackages.waylandFull
    winetricks
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
    nitch
    cavalier
    gnome-obfuscate
    bottles
    mission-center
    gnome-boxes
    qemu
    collision
    swtpm
    turtle
    meld
    blender
    appimage-run
    godot_4
    ripgrep
    moar
    fzf
    wl-clipboard
    jq
    inputs.nix-alien.packages.${system}.nix-alien
    (uutils-coreutils.override {prefix = "";})
    (writeShellScriptBin "wine-mono" "mono")
    (writeShellScriptBin "xdg-terminal-exec" "kitty -e $@")
  ];

  environment.variables = {
    EDITOR = "nvim";
    PAGER = "moar";
    MOAR = "--wrap --quit-if-one-screen --colors 8";
  };

  services.flatpak.packages = [
    {
      appId = "org.gimp.GIMP";
      origin = "flathub-beta";
    }
    "app.fotema.Fotema"
    "org.gnome.design.Palette"
  ];
}
