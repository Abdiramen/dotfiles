{
  config,
  lib,
  ...
}:
{

  options = {
    latex.enable = lib.mkEnableOption "enable latex configs";
  };
  # texlive, latex, xatex, etc
  config = lib.mkIf config.latex.enable {
    fonts.fontconfig.enable = true;
    programs.texlive = {
      enable = true;
      extraPackages = tpkgs: {
        # can't find puenc-greek.def
        #inherit (tpkgs) collection-basic;
        #inherit (tpkgs) collection-latex;
        inherit (tpkgs)
          collection-xetex
          fontspec
          xltxtra
          url
          parskip
          xcolor
          layaureo
          hyperref
          titlesec
          enumitem
          xunicode
          graphics
          kvoptions
          etoolbox
          geometry
          latex-tools-dev
          pdftexcmds
          infwarerr
          greek-fontenc
          eso-pic
          fontawesome5
          ;
      };
    };
  };
}
