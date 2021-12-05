{ config, lib, pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;

    defaultOptions = [
      "--color fg:-1,bg:-1,hl:33,fg+:235,bg+:-1,hl+:33 --color info:236,prompt:136,pointer:234,marker:234,spinner:136"
    ];
  };
}
