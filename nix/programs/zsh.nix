{pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";

    initExtra = ''
      alias ls="ls --color"
      alias vimiki="nvim -c VimwikiIndex"
      alias diary="nvim -c VimwikiDiaryIndex"
    '' + (builtins.readFile ./init-extra.zsh);
    plugins = with pkgs; [
      {
	      name = "zsh-vi-mode";
	      src  = pkgs.fetchFromGitHub {
                owner  = "jeffreytse";
                repo   = "zsh-vi-mode";
                rev    = "v0.8.4";
                sha256 = "0a1rvc03rl66v8rgzvxpq0vw55hxn5b9dkmhdqghvi2f4dvi8fzx";
        };
      }
      {
	      name = "powerlevel10k";
	      file = "powerlevel10k.zsh-theme";
	      src = pkgs.fetchFromGitHub {
	        owner  = "romkatv";
	        repo   = "powerlevel10k";
	        rev    = "v1.15.0";
	        sha256 = "1b3j2riainx3zz4irww72z0pb8l8ymnh1903zpsy5wmjgb0wkcwq";
        };
      }
    ];
  };
}
