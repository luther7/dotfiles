{ config, pkgs, ... }:
let home-dir = builtins.getEnv ("HOME");
in
{
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
      cask_args appdir: "${home-dir}/Applications"
    '';
  };

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  system.stateVersion = 4;
}
