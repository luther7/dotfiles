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
      bash-completion
      brotli
      coreutils-full
      gcc
      cmake
      curl
      direnv
      fd
      findutils
      fontconfig
      gh
      gnupg
      jq
      kubectl
      less
      lua
      luarocks
      luaformatter
      nixfmt
      nodejs
      nodePackages.prettier
      nodePackages.prettier-plugin-toml
      openssh
      pandoc
      poetry
      python310
      python310Packages.black
      ripgrep
      ruby
      rubocop
      shellcheck
      sqlite
      tcpdump
      terraform
      unzip
      watch
      wget
      yq-go
      yarn
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

  # home.file = {
  #   ".config/java-language-server" = {
  #     source = "${pkgs.java-language-server}/share/java/java-language-server";
  #     recursive = true;
  #   };
  # };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
}
