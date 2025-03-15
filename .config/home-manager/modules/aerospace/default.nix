{ config, lib, pkgs, ... }:

{
  home.file = {
    ".aerospace.toml".source = ./files/aerospace.toml;
  };
}
