{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.wezterm = {
    enable = false;
    package = pkgs.wezterm;
  };

  home.file = {
    ".wezterm.lua".source = ./files/wezterm.lua;
  };
}
