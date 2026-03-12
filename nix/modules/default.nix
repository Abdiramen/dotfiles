{ lib, ... }:

{
  imports = [
    ./desktop
    ./programs
    ./tex
  ];

  # common software i want enabled between all hosts
  cli_tools.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  fzf.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  tmux.enable = lib.mkDefault true;
}
