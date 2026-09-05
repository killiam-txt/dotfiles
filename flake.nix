{
  description = "Modular and minimalist NixOS configuration";
  inputs = {
    # nixos
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # temporary fix
    nixpkgs-niri-compat.url = "github:nixos/nixpkgs/e72e4f299401a3689d4b3d5fc6496b11db7064eb";

    # spotify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # nvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # hyprland
    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    spicetify-nix,
    nixvim,
    hyprland,
    niri-flake,
    ...
  }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          niri-flake.nixosModules.niri
          {
            # temporary overlay
            nixpkgs.overlays = [
              (final: prev: {
                libdisplay-info_0_2 = inputs.nixpkgs-niri-compat.legacyPackages.${prev.system}.libdisplay-info_0_2;
              })
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.killiam = {
              imports = [
                ./home/home.nix
                spicetify-nix.homeManagerModules.spicetify
                nixvim.homeModules.nixvim
                hyprland.homeManagerModules.default
              ];
            };
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = {inherit inputs;};
          }
        ];
      };
    };
  };
}