{ config, lib, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
  };

  home.file = {
    ".wezterm.lua".source = ./files/wezterm.lua;
  };
}
