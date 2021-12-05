{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "$TERM";
    secureSocket = true;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.tmux-colors-solarized;
        extraConfig = ''
          set -g @colors-solarized 'light'
        '';
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
