{ config, pkgs, ... }:

let home-dir = builtins.getEnv ("HOME");
in {
  environment.systemPackages = with pkgs; [
    automake
    awscli
    cask
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
    metals
    neovim
    ninja
    nixfmt
    nodejs
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-json-languageserver
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    pandoc
    postgresql
    python39
    python39Packages.black
    python39Packages.isort
    python39Packages.flake8
    pyright
    reattach-to-user-namespace
    ripgrep
    rnix-lsp
    ruby
    rubocop
    sbt
    scala
    shellcheck
    solargraph
    tcpdump
    terraform
    terraform-ls
    tmux
    # tree
    vault
    vimPlugins.packer-nvim
    watch
    wget

  ];

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    taps = [
      "homebrew/bundle"
      "homebrew/core"
      "homebrew/cask"
      "homebrew/cask-fonts"
    ];
    casks = [
      "caffeine"
      "docker"
      "font-caskaydia-cove-nerd-font"
      "iterm2"
      # "joplin"
      "mullvadvpn"
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

  programs.zsh.enable = true;
  programs.bash.enable = true;

  system.stateVersion = 4;
}
