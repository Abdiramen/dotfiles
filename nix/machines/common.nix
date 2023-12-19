{ pkgs, ... }:

{
  imports = [
    ../programs
    ../langs
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    curl
    tmux
    bat
    git
    graphite-cli
    ripgrep
    jq
    bc

    ngrok
  ];
}
