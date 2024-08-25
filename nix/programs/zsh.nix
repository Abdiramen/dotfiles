{ pkgs, ... }:

let
  bin = "~/bin"; # TODO: move to dotfile repo
in
{
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    defaultKeymap = "viins";
    dotDir = ".config/zsh";

    shellAliases = {
      ls = "ls --color";
      "vimwiki" = "nvim -c VimwikiIndex";
      "diary" = "nvim -c VimwikiDiaryIndex";
      "irb" = "irb --readline";
      "emacs" = "emacs --no-window-system";
      "mkgit" = "${bin}/builders/mkgit.rb";
      "pn" = "pnpm";
    };
    initExtra = ''
      # turning off translations for Stardew Valley
      export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

      if [ -f "''${HOME}/ngrok/.cache/ngrok-host-shellhook" ]; then
        source "''${HOME}/ngrok/.cache/ngrok-host-shellhook"
      elif command -v direnv 2>&1 >/dev/null ; then
        source <(direnv hook zsh)
      fi
    '';
    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "v0.8.4";
          sha256 = "0a1rvc03rl66v8rgzvxpq0vw55hxn5b9dkmhdqghvi2f4dvi8fzx";
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
