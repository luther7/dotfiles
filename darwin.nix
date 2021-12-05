{ config, pkgs, ... }:
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
    cleanup = "zap";

    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/bundle"
      "homebrew/core"
    ];

    casks = [
      "1password"
      "1password-cli"
      "caffeine"
      "chromium"
      "docker"
      "font-caskaydia-cove-nerd-font"
      "homebrew/cask-versions/firefox-developer-edition"
      "iterm2"
      # "joplin"
      "microsoft-excel"
      "microsoft-outlook"
      "microsoft-powerpoint"
      "microsoft-remote-desktop"
      "microsoft-word"
      "mullvadvpn"
      "slack"
      "swinsian"
      "rectangle"
      "vlc"
      "zoom"
    ];

    extraConfig = ''
      brew "docker-credential-helper-ecr"
      cask_args appdir: "${homedir}/Applications"
    '';
  };

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.zsh.enable = true;
  programs.bash.enable = true;

  system.stateVersion = 4;
}
