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
      # leader = "."

      plugins = with pkgs.vimPlugins; [
          fzfWrapper
          fzf-lua
          gruvbox
          kanagawa-nvim
          neocomplete-vim
          vim-commentary
          vim-ruby
          vim-rails
          vim-endwise
          ale
          vim-nerdtree-syntax-highlight
          vim-devicons
          vim-css-color
          vim-emoji
          vimagit
          vim-go
          vim-nix
          rust-vim

          lualine-nvim
          vimtex
          nvim-treesitter-context

          plenary-nvim

          base16-vim
          # nvim-web-devicons
          {
            plugin = nvim-treesitter;
            type = "lua";
            config = ''
              require'nvim-treesitter.configs'.setup {
                sync_install = false,
                auto_install = false,

                highlight = {
                  enable = true,

                  additional_vim_regex_highlighting = false,
                },
              }
            '';
          }
          {
            plugin = harpoon;
            type = "lua";
            config = ''
              local mark = require("harpoon.mark")
              local ui = require("harpoon.ui")

              vim.keymap.set("n", "<leader>a", mark.add_file)
              vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
              vim.keymap.set("n", "<C-1>", function () ui.nav_file(1) end)
              vim.keymap.set("n", "<C-2>", function () ui.nav_file(2) end)
              vim.keymap.set("n", "<C-3>", function () ui.nav_file(3) end)
              vim.keymap.set("n", "<C-4>", function () ui.nav_file(4) end)
            '';
          }

          {
            plugin = telescope-nvim;
            type = "lua";
            config = ''
              local builtin = require('telescope.builtin')
              vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
              vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
              vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
              vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            '';
          }
          {
            plugin = telescope-zoxide;
            type = "lua";
            config = ''
              vim.keymap.set('n', "<leader>fz", ":Telescope zoxide list<cr>")
            '';
          }
          {
            plugin = telescope-file-browser-nvim;
            type = "lua";
            config = ''
              -- You don't need to set any of these options.
              -- IMPORTANT!: this is only a showcase of how you can set default options!
              require("telescope").setup {
                extensions = {
                  file_browser = {
                    theme = "ivy",
                    mappings = {
                      ["i"] = {
                        -- your custom insert mode mappings
                      },
                      ["n"] = {
                        -- your custom normal mode mappings
                      },
                    },
                  },
                },
              }
              -- To get telescope-file-browser loaded and working with telescope,
              -- you need to call load_extension, somewhere after setup function:
              require("telescope").load_extension "file_browser"
              vim.keymap.set('n', "<leader>fb", ":Telescope file_browser path=%:p:h<cr>")
              vim.keymap.set('n', "<leader>fB", ":Telescope file_browser<cr>")
            '';
          }
      ];

      extraConfig = ''
        luafile ${./init.lua}
        source ${./yami.vim}

        set termguicolors
        hi Normal guibg=NONE ctermbg=NONE
        set background=dark

        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
        highlight Normal guibg=none
        highlight NonText guibg=none
      '';

      # extraConfig = lib.fileContents ./init.lua;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # home.file = {
    #   ".config/nvim/init.lua".source = ./init.lua;
    # };
  };
}
