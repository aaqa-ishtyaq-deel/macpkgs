{ lib, pkgs, ... }:

{
  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # SSH
  # https://nix-community.github.io/home-manager/options.html#opt-programs.ssh.enable
  # Some options also set in `../darwin/homebrew.nix`.
  programs.ssh.enable = true;
  programs.ssh.controlPath = "~/.ssh/%C"; # ensures the path is unique but also fixed length

  programs.zoxide.enable = true;

  programs.fzf = {
    enableZshIntegration = true;
    enable = true;
  };

  home.packages = lib.attrValues ({
    # Some basics
    inherit (pkgs)
      bandwhich # display current network utilization by process
      bottom # fancy version of `top` with ASCII graphs
      coreutils
      curl
      du-dust # fancy version of `du`
      fd # fancy version of `find`
      htop # fancy version of `top`
      ripgrep # better version of `grep`
      tealdeer # rust implementation of `tldr`
      unrar # extract RAR archives
      wget
      xz # extract XZ archives
      iay
      pinentry_mac
      gnupg
      diff-so-fancy
      fzf
      tree
      jq
      yq
      aria
      zstd
    ;

    # Runtimes
    inherit (pkgs)
      go
    ;

    # GoLang
    inherit (pkgs)
      gotests
      golangci-lint
      gomodifytags
      impl
      go-tools
      delve
      gopls
      gofumpt
      go-outline
      godef
      golint
    ;

    gcloud = pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ];

    # Dev stuff
    inherit (pkgs)
      cloc # source code line counter
      nodejs
      typescript
      kubectl
      awscli2
      kubectx
      skopeo
    ;

    # Useful nix related tools
    inherit (pkgs)
      cachix # adding/managing alternative binary caches hosted by Cachix
      comma # run software from without installing it
      # niv # easy dependency management for nix projects
      nix-output-monitor # get additional information while building packages
      nix-tree # interactively browse dependency graphs of Nix derivations
      nix-update # swiss-knife for updating nix packages
      nixpkgs-review # review pull-requests on nixpkgs
      node2nix # generate Nix expressions to build NPM packages
      statix # lints and suggestions for the Nix programming language
    ;

    # GUI
    inherit(pkgs)
      obsidian
    ;

  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    inherit (pkgs)
      cocoapods
      m-cli # useful macOS CLI commands
    ;
  });
}
