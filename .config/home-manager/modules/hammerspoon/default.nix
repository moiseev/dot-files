{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Hammerspoon itself is installed via Homebrew cask; this only manages config.
  home.file.".hammerspoon" = {
    source = ./files;
    recursive = true;
  };
}
