{
  description = "Selim's Unified NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    whitesur-src = {
      url = "github:vinceliuice/WhiteSur-icon-theme";
      flake = false;
    };
    
    slimmer-icons.url = "github:SlimmerCH/Slimmer-icon-theme";
    slimmer-icons.flake = false; # Important if the repo doesn't have its own flake.nix
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland (Bleeding Edge)
    hyprland.url = "github:hyprwm/Hyprland";
    
    # Plugins (Synced versions)
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    
    # AGS
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Pass inputs to all modules
      specialArgs = { inherit inputs; };
      
      modules = [
        # 1. Your System Config
        ./configuration.nix
        ./hardware-configuration.nix

        # 2. Home Manager as a System Module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # Pass inputs to home-manager modules too
          home-manager.extraSpecialArgs = { inherit inputs; };
          
          # Import your home.nix
          home-manager.users.selim = import ./home.nix;
          
          # Optional: Backup existing files if they conflict
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}