{ config, pkgs, lib, ... }:

let
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
  isWSL = (builtins.getEnv "WSL_DISTRO_NAME") != "";
in {
  imports = [
    ./bash/default.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./vim/default.nix
    ./tmux/default.nix
  ];

  home = {
    username = username;
    homeDirectory = homedir;
    stateVersion = "21.03";

    packages = with pkgs; [
      awscli
      coreutils-full
      curl
      docker-credential-helpers
      docker-compose
      dig
      fd
      fontconfig
      gh
      gnupg
      git
      google-cloud-sdk
      htop
      jq
      kubectl
      less
      libssh2
      lua
      luarocks
      nixfmt
      nodejs
      nodePackages.bash-language-server
      nodePackages.diagnostic-languageserver
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-json-languageserver
      nodePackages.prettier
      nodePackages.prettier-plugin-toml
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      openssh
      unzip
      pandoc
      poetry
      python310
      python310Packages.black
      pyright
      ripgrep
      rnix-lsp
      shellcheck
      sqlite
      tcpdump
      terraform
      terraform-ls
      tree
      vault
      watch
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

  programs.home-manager.enable = true;

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
}
