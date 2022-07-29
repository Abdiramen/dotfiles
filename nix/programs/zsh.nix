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
      alias irb="irb --readline"
      alias emacs="emacs --no-window-system"

      # turning off translations for Stardew Valley
      export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
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
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
      {
        name = "nix-zsh-completions";
        file = "nix-zsh-completions.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "spwhitt";
          repo = "nix-zsh-completions";
          rev = "0.4.4";
          sha256 = "1n9whlys95k4wc57cnz3n07p7zpkv796qkmn68a50ygkx6h3afqf";
        };
      }
    ];
  };
}
