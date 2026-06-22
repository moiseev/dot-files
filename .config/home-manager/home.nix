{ homeDirectory, pkgs, stateVersion, system, username }:

{
  home = {
    inherit homeDirectory stateVersion username;

    packages = [
      pkgs.just
    ];

    shellAliases = {
      ",j" = "just";
    };
  };

  imports = [
    ./modules/aerospace
    ./modules/wezterm
  ];

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
