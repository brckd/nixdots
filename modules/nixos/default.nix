{
	pkgs,
	nixpkgs-staging,
  stylix,
  erosanix,
  ...
}: {
  imports = [
    erosanix.nixosModules.protonvpn
    stylix.nixosModules.stylix
    ./stylix
    ./locale
    ./hyprland
    ./sddm
    ./pipewire
    ./steam
  ];

	system.replaceRuntimeDependencies = [
	{
		original = pkgs.xz;
		replacement = nixpkgs-staging.legacyPackages.${pkgs.system}.xz;
	}
	];
}
