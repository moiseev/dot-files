{ homeDirectory, pkgs, stateVersion, system, username }:

{
  home = {
    inherit homeDirectory stateVersion username;

    shellAliases = {
    };
  };

  imports = [
    ./modules/wezterm
  ];

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
