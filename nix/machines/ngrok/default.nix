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

  programs.zsh.shellAliases = {
    "enable_sso" = "export NGROK_USE_SSO=true && direnv reload";
    "disable_sso" = "export NGROK_USE_SSO=false && direnv reload";
  };
  home.packages = with pkgs; [
    graphite-cli
  ];
}
