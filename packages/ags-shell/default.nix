{
  pkgs,
  inputs,
  ...
}: let
  agsPkgs = inputs.ags.packages.${pkgs.system};
  astalPkgs = inputs.astal.packages.${pkgs.system};
  pname = "ags-shell";
  version = "0.1.0";
  entry = "./app.ts";
in
  pkgs.stdenv.mkDerivation {
    inherit pname version;

    src = ./.;

    nativeBuildInputs = with pkgs; [
      wrapGAppsHook
      gobject-introspection
      agsPkgs.default
    ];

    buildInputs = [
      pkgs.glib
      pkgs.gjs
      astalPkgs.io
      astalPkgs.astal4
    ];

    installPhase = ''
      runHook preInstall

      mkdir --parents $out/bin
      mkdir --parents $out/share
      cp --recursive ./* $out/share
      ags bundle ${entry} $out/bin/${pname} --gtk 4

      runHook postInstall
    '';
  }
