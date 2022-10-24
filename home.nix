{ config, pkgs, lib, ... }:
let
  username = "luther";
in {
  imports = [
    ./bash.nix
    ./vim.nix
    ./tmux.nix
  ];
  programs.home-manager.enable = true;
  programs.man.enable = true;
  programs.info.enable = false;
  home = {
    stateVersion = "21.11";
    username = username;
    packages = with pkgs; [
      cachix
      nix-prefetch-git
      nixpkgs-fmt
      # bash-completion
      coreutils-full
      curl
      direnv
      fd
      findutils
      fontconfig
      gh
      gnupg
      jq
      less
      nixfmt
      openssh
      ripgrep
      shellcheck
      unzip
      wget
    ];
    language = {
      base = "en_US.UTF-8";
      collate = "en_US.UTF-8";
      ctype = "en_US.UTF-8";
      messages = "en_US.UTF-8";
      monetary = "en_US.UTF-8";
      numeric = "en_US.UTF-8";
      time = "en_US.UTF-8";
    };
  };
  programs.direnv = {
    enable = true;
    nix-direnv = { enable = true; };
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.git = {
    enable = true;
    # userName = "Red Note";
    # userEmail = "red.note4613@fastmail.com";
    extraConfig = {
      core = { whitespace = "trailing-space,space-before-tab"; };
      init.defaultBranch = "main";
      pull.rebase = "false";
      url."ssh://git@host".insteadOf = "otherhost";
    };
  };
}
