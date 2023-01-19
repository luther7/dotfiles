{ config, pkgs, lib, ... }:
let username = "luther";
in {
  programs.zsh.enable = false;
  programs.bash.enable = true;
  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      # enable = true;
      autoUpdate = true;
      cleanup = "none";
    };
    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/bundle"
      "homebrew/core"
    ];
    brews = [
      "gawk"
      "gnu-getopt"
      "gnu-indent"
      "gnu-sed"
      "gnu-tar"
      "gnutls"
      "grep"
      "tree"
    ];
    casks = [
      "alt-tab"
      "betterdisplay"
      "caffeine"
      "docker"
      "dozer"
      "font-cascadia-code"
      "font-cascadia-mono"
      "gimp"
      "homebrew/cask-fonts/font-source-code-pro"
      "homebrew/cask-fonts/font-source-sans-pro"
      "homebrew/cask-fonts/font-source-serif-pro"
      "homebrew/cask-versions/firefox-developer-edition"
      "iterm2"
      "maccy"
      "libreoffice"
      "rectangle"
      "swinsian"
      "stats"
      "vlc"
    ];
  };
  users.users.luther = {
    name = "luther";
    home = "/Users/luther";
  };
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users."${username}" = import ./home.nix;
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
}
