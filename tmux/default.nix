{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    secureSocket = true;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.nord;
      }
      {
        plugin = tmuxPlugins.yank;
        extraConfig = ''
          set -g @yank_selection "primary"
        '';
      }
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
