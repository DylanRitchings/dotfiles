{
  description = "Nix for macOS configuration";

 

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      "https://cache.nixos.org"
      #"https://mirrors.ustc.edu.cn/nix-channels/store"
      
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    username = "dylan";
    useremail = "accounts@dylanrit.uk";
    system = "aarch64-darwin";
    hostname = "Dylans-MacBook-Pro";

    specialArgs =
      inputs
      // {
        inherit username useremail hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix
        ./modules/launchd.nix

        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ./home;
        }
      ];
    };

    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
