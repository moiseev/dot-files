{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";  # For Apple Silicon Macs (use x86_64-darwin for Intel Macs)
      stateVersion = "25.05";

      pkgs = nixpkgs.legacyPackages.${system};

      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";

      mkHomeConfiguration = username:
        let
          homeDirectory = "/${homeDirPrefix}/${username}";
          home = (import ./home.nix {
            inherit homeDirectory pkgs stateVersion system username;
          });

        in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
              home
            ];

          };
    in {
      homeConfigurations = {
        "moiseev" = mkHomeConfiguration "moiseev";
        "maxim" = mkHomeConfiguration "maxim";
      };
    };
}
