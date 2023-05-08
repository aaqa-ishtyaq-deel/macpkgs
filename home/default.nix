{ config, pkgs, ... }: {
  imports = [
    ./packages.nix
    ./zsh/default.nix
    ./tmux/default.nix
  ];

  aaqaishtyaq = {
    zsh.enable = true;
    tmux.enable = true;
  };
}
