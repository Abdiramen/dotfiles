{ pkgs, ... }:

{
  imports = [
    ../programs
    ../langs
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    #curl
    tmux
    bat
    git
    ripgrep
    jq
    bc
    # will need to move, I don't want texlive on every computer
    # texlive.withPackages (ps: [ps.titlesec ps.realscripts ps.xelatex-dev])
    #texliveFull # last case scenario

    ngrok
  ];

  # will need to move, I don't want texlive on every computer
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: {
      # can't find puenc-greek.def
      #inherit (tpkgs) collection-basic;
      #inherit (tpkgs) collection-latex;
      inherit (tpkgs) collection-xetex fontspec xltxtra url parskip xcolor layaureo hyperref titlesec enumitem xunicode graphics kvoptions etoolbox geometry latex-tools-dev pdftexcmds infwarerr greek-fontenc;
    };
  };
}
