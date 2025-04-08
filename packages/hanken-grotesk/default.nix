{
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) fetchGit;
in
  pkgs.stdenvNoCC.mkDerivation {
    pname = "hanken-grotesk";
    version = "2024-01-30";

    src = fetchGit {
      url = "https://github.com/marcologous/hanken-grotesk";
      ref = "master";
      rev = "1ab416e82130b2d3ddb7710abf7ceabf07156a13";
    };

    installPhase = ''
      runHook preInstall

      mkdir --parents $out/share/fonts
      cp --recursive fonts/ttf $out/share/fonts/truetype
      cp --recursive fonts/variable $out/share/fonts/variable

      runHook postInstall
    '';

    meta = with lib; {
      description = "Hanken Grotesk is a sans serif typeface inspired by the classic grotesques.";
      homepage = "https://github.com/marcologous/hanken-grotesk";
      license = licenses.ofl;
      platforms = platforms.all;
    };
  }
