{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../remote
  ];

  # allow home manager to manage shell
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
    };
    initExtra = ''
      # see https://nix-community.github.io/home-manager/index.html#ch-installation
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      exec ~/.nix-profile/bin/zsh
    '';
  };
  home.packages = with pkgs; [
    graphite-cli
  ];
}
