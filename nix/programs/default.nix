{ pkgs, ... }:

{
  imports = [
    ./direnv.nix
    ./zsh.nix
    ./neovim.nix
    ./tmux.nix
    ./fzf.nix
 ];
}
