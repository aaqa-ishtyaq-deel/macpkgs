{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf elem;
  caskPresent = cask: lib.any (x: x.name == cask) config.homebrew.casks;
  brewEnabled = config.homebrew.enable;
  homePackages = config.home-manager.users.${config.users.primaryUser.username}.home.packages;
in

{
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "aaqaishtyaq/tap"
  ];


  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "hammerspoon"
    "visual-studio-code"

    "font-blex-mono-nerd-font"
  ];
}
