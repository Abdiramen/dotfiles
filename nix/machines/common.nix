{ pkgs, ... }:

{
  imports = [
    #~/nix/programs/wezterm.nix
    ~/nix/programs/zsh.nix
    ~/nix/programs/tmux.nix
    ~/nix/programs/fzf.nix
    ~/nix/programs/neovim.nix
    ~/nix/programs/go.nix
    ~/nix/programs/direnv.nix
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

    ngrok
  ];
}
