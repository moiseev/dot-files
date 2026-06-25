{
  homeDirectory,
  pkgs,
  stateVersion,
  system,
  username,
}:

{
  home = {
    inherit homeDirectory stateVersion username;

    packages =
      with pkgs;
      [
        age
        bat
        btop
        cloc
        curlie
        difftastic
        eternal-terminal
        eza
        fd
        fzf
        gh
        jq
        just
        lnav
        pandoc
        ripgrep
        tig
        vim
        watchexec
        wget
        yazi
        yq
        zoxide
      ]
      ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
        reattach-to-user-namespace
      ];

    shellAliases = {
      ",j" = "just";
      "ls" = "eza";
      "ll" = "eza -lha";
      ",y" = "yazi";
      ",z" = "zoxide";
    };
  };

  imports = [
    ./modules/wezterm
  ];

  targets.darwin = pkgs.lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    copyApps.enable = true;
    linkApps.enable = false;
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
