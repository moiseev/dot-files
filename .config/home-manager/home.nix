{ homeDirectory, pkgs, stateVersion, system, username }:

{
  home = {
    inherit homeDirectory stateVersion username;

    shellAliases = {
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
