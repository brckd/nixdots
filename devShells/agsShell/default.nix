{
  pkgs,
  inputs,
  ...
}: let
  agsPkgs = inputs.ags.packages.${pkgs.system};
  astalPkgs = inputs.astal.packages.${pkgs.system};
in
  pkgs.mkShell {
    packages = [
      (agsPkgs.default.override {
        extraPackages = [
          pkgs.glib
          pkgs.gjs
          astalPkgs.io
          astalPkgs.astal4
        ];
      })
    ];
  }
