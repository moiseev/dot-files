{ homeDirectory, pkgs, stateVersion, system, username }:

{
  home = {
    inherit homeDirectory stateVersion username;

    packages = with pkgs; [
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
      watchexec
      wget
      yazi
      yq
      zoxide
    ] ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
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
    ./modules/aerospace
    ./modules/wezterm
  ];

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
