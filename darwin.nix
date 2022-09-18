{ config, pkgs, lib, ... }:
let
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in {
  # $ darwin-rebuild switch -I darwin-config="${HOME}/.config/nixpkgs/darwin.nix"
  environment.darwinConfig = "${homedir}/.config/nixpkgs/darwin.nix";

  imports = [ <home-manager/nix-darwin> ];

  users.users."${username}" = {
    name = username;
    home = homedir;
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users."${username}" = import ./home.nix;

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "none";

    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/bundle"
      "homebrew/core"
    ];

    brews = [
      "bash"
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
      "betterdisplay"
      "caffeine"
      "docker"
      "font-cascadia-code"
      "font-cascadia-mono"
      "gimp"
      "homebrew/cask-fonts/font-source-code-pro"
      "homebrew/cask-fonts/font-source-sans-pro"
      "homebrew/cask-fonts/font-source-serif-pro"
      "homebrew/cask-versions/firefox-developer-edition"
      "iterm2"
      "rectangle"
      "swinsian"
      "vlc"
    ];
  };

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.zsh.enable = false;
  programs.bash.enable = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
}
