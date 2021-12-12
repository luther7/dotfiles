{ config, pkgs, ... }:
let
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
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

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      JAVA_HOME = "${pkgs.openjdk.home}";
    };

    packages = with pkgs; [
      automake
      awscli
      cmake
      conftest
      coreutils-full
      # coursier
      curl
      docker-credential-helpers
      docker-compose
      fd
      fontconfig
      gcc
      gh
      gnupg
      git
      # go
      google-cloud-sdk
      htop
      httpie
      # jdk11
      # jdk
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
      python39Packages.flake8
      python39Packages.isort
      python39Packages.mypy
      # python39Packages.pip
      # python39Packages.virtualenv
      pyright
      ripgrep
      rnix-lsp
      # ruby
      # rubocop
      # sbt
      # scala
      shellcheck
      # solargraph
      sqlite
      syncthing
      tcpdump
      terraform
      terraform-ls
      # tree
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
