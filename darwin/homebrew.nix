{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf elem;
  caskPresent = cask: lib.any (x: x.name == cask) config.homebrew.casks;
  brewEnabled = config.homebrew.enable;
  homePackages = config.home-manager.users.${config.users.primaryUser.username}.home.packages;
  pinentry-program = "${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac";
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
    "homebrew/services"
    "aaqaishtyaq/tap"
  ];

  homebrew.brews = [
    "libpq"
  ];

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "alacritty"
    "firefox"
    "flameshot"
    "hammerspoon"
    "hiddenbar"
    "meetingbar"
    "obsidian"
    "openlens"
    "tableplus"
    "utm"
    "visual-studio-code"
  ];
  home-manager.sharedModules = [
      {
        home.file = {
          gpg-agent = {
            target = ".gnupg/gpg-agent.conf";
            text = ''
              pinentry-program ${pinentry-program}
              default-cache-ttl 43200
              default-cache-ttl-ssh 43200
              max-cache-ttl 43200
              max-cache-ttl-ssh 43200
            '';
          };
        };
      }
    ];
}
