{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.aaqaishtyaq.zsh;
  dotDir = ".config/zsh.d";
in {
  options.aaqaishtyaq.zsh = {
    enable = mkEnableOption "Enable the Z Shell";
  };
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = "${dotDir}";
      enableCompletion = true;
      enableAutosuggestions = true;
      history = {
        path = "$HOME/${dotDir}/.zsh_history";
        save = 50000;
        ignoreDups = true;
        share = true;
        extended = true;
      };
      autocd = true;
      shellAliases = {
        k = "kubectl";
        kctx = "kubectx";
        kns = "kunens";
        kx = "kubectx";
        ls = "ls --color=auto";
        l = "ls -lah";
        la = "ls -lAh";
        ll = "ls -lh";
        lsa = "ls -lah";
        sl = "ls -al";
        tree = "tree -C";
        chmox = "chmod u+x";
        cl = "clear";
        ctags = "/usr/local/bin/ctags";
        e = "nvim";
        grep = "grep --color=auto";
        ipaddr = "dig +short myip.opendns.com @resolver1.opendns.com";
        ipinfo = "curl ipinfo.io";
        more = "less -R";
        weather = "curl wttr.in";
        nixclean = "nix-collect-garbage -d";
        mnt-drive = "udisksctl mount -b /dev/sda1";
      };
      sessionVariables = {
        EDITOR = "vim";
        HISTCONTROL = "ignoreboth";
        PAGER = "less";
        LESS = "-iR";
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
        LC_CTYPE = "en_US";
        LC_MESSAGES="en_US";
        TERM="xterm-256color";
      };
      initExtra = ''
        if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
        eval "$(direnv hook zsh)"
        ZSH_AUTOSUGGEST_USE_ASYNC=true

        export GPG_TTY=$(tty)

        for file in "$HOME/${dotDir}/"*.zsh; do
          if [[ -r "$file" ]] && [[ -f "$file" ]]; then
            source "$file"
          fi
        done

        if command -v grep &>/dev/null; then
          if [ -r ~/.config/dircolors/dircolors ]; then
            eval "$(dircolors -b ~/.config/dircolors/dircolors)"
          else
            eval "$(dircolors -b)"
          fi
        fi

        if [ ! "$TERM" = dumb ]; then
          autoload -Uz add-zsh-hook
          _iay_prompt() {
            PROMPT="$(iay -zm)"
          }
          add-zsh-hook precmd _iay_prompt
        fi

        RPROMPT=""

        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

        export PATH="$HOME/.local/bin":$PATH
      '';
    };

    home.file = {
      ".config/zsh.d/completion.zsh".source = ./completion.zsh;
      ".config/zsh.d/bindings.zsh".source = ./bindings.zsh;
      ".config/zsh.d/functions.zsh".source = ./functions.zsh;
      ".config/zsh.d/options.zsh".source = ./options.zsh;
      ".config/dircolors/dircolors".source = ../dircolors/dircolors;

      ".local/bin/alatheme".source = ../bin/alatheme;
      ".local/bin/datepath".source = ../bin/datepath;
      ".local/bin/git-checkout-ss".source = ../bin/git-checkout-ss;
      ".local/bin/git-diff-exclude".source = ../bin/git-diff-exclude;
      ".local/bin/hnow".source = ../bin/hnow;
      ".local/bin/inc.awk".source = ../bin/inc.awk;
      ".local/bin/ix".source = ../bin/ix;
      ".local/bin/log".source = ../bin/log;
      ".local/bin/mkdirp".source = ../bin/mkdirp;
      ".local/bin/muxx".source = ../bin/muxx;
      ".local/bin/notes".source = ../bin/notes;
      ".local/bin/now".source = ../bin/now;
      ".local/bin/nvim-mode".source = ../bin/nvim-mode;
      ".local/bin/todo".source = ../bin/todo;
      ".local/bin/zzip".source = ../bin/zzip;
    };
  };
}
