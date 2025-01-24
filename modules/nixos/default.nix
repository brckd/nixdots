{
  inputs,
  self,
  ...
}: let
  internalModules = builtins.attrValues (builtins.removeAttrs self.nixosModules ["default"]);
  externalModules = with inputs; [
    nur.modules.nixos.default
    stylix.nixosModules.stylix
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    nix-flatpak.nixosModules.nix-flatpak
    nixos-generators.nixosModules.all-formats
    nix-index-database.nixosModules.nix-index
    nix-data.nixosModules.nix-data
  ];
in {
  system.stateVersion = "25.05";

  imports = internalModules ++ externalModules;
}
