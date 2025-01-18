{
  inputs,
  self,
  ...
}: let
  internalModules = builtins.attrValues (builtins.removeAttrs self.homeModules ["default"]);
  externalModules = with inputs; [
    nur.modules.homeManager.default
    stylix.homeManagerModules.stylix
    spicetify-nix.homeManagerModules.default
    nix-flatpak.homeManagerModules.nix-flatpak
    nixvim.homeManagerModules.nixvim
    nix-index-database.hmModules.nix-index
  ];
in {
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  imports = internalModules ++ externalModules;
}
