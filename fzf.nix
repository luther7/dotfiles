{ config, lib, pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;

    defaultOptions = [
      "--color=bg+:#2e3440 --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1 --color=fg+:#e5e9f0,hl+:#81a1c1 --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b"
    ];
  };
}
