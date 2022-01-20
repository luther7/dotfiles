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
      # automake
      awscli
      # beets
      # chromaprint
      # cmake
      # conftest
      coreutils-full
      # coursier
      curl
      docker-credential-helpers
      docker-compose
      dig
      # envsubst
      fd
      fontconfig
      # gcc
      gh
      gnupg
      git
      # go
      google-cloud-sdk
      # gst_all_1.gstreamer
      htop
      jq
      kubectl
      less
      libssh2
      lua
      luarocks
      # metals
      # ninja
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
      pandoc
      # postgresql
      poetry
      python310
      # python39
      # python39Packages.black
      # python39Packages.isort
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
