{ config, pkgs, ... }:
let
  locale = "C.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in
{
  imports = [
    ./git.nix
    ./vim/default.nix
    ./tmux.nix
  ];

  home = {
    username = username;
    homeDirectory = homedir;
    stateVersion = "21.03";

    sessionVariables = {
      LANG = locale;
      LC_ALL = locale;
      EDITOR = "nvim";
      VISUAL = "nvim";
      JAVA_HOME = "${pkgs.openjdk.home}";
      HOMEBREW_NO_AUTO_UPDATE = 1;
    };

    packages = with pkgs; [
      automake
      awscli
      # cask
      cmake
      conftest
      coreutils-full
      coursier
      curl
      direnv
      docker-credential-helpers
      docker-compose
      fd
      fontconfig
      fzf
      gcc
      gh
      gitAndTools.gitFull
      gnupg
      go
      google-cloud-sdk
      htop
      httpie
      jdk11
      jq
      kubectl
      libssh2
      lua
      luarocks
      # metals
      ninja
      nixfmt
      nodejs
      nodePackages.bash-language-server
      nodePackages.diagnostic-languageserver
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-json-languageserver
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      openssh
      pandoc
      postgresql
      python39
      python39Packages.black
      python39Packages.isort
      python39Packages.flake8
      pyright
      # reattach-to-user-namespace
      ripgrep
      rnix-lsp
      ruby
      rubocop
      # sbt
      # scala
      shellcheck
      solargraph
      sqlite
      syncthing
      tcpdump
      terraform
      terraform-ls
      tmux
      tree
      vault
      watch
      wget
    ];
  };

  programs.home-manager.enable = true;

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
}
