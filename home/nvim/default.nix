{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.aaqaishtyaq.nvim;
in {
  options.aaqaishtyaq.nvim = {
    enable = mkEnableOption "Enable neovim editor";
  };
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
          nerdtree
          lightline-vim
          fzfWrapper
          gruvbox
          neocomplete-vim
          vim-commentary
          vim-ruby
          vim-rails
          vim-endwise
          ale
          # vim-ripgrep
          vim-nerdtree-syntax-highlight
          vim-devicons
          vim-css-color
          vim-emoji
          vimagit
          vim-go
          vim-nix
          rust-vim
          nvim-treesitter
      ];

      extraConfig = pkgs.lib.readFile ./extra.vim;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
