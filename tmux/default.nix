{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    newSession = true;
    secureSocket = false;
    baseIndex = 1;
    escapeTime = 50;
    keyMode = "vi";
    terminal = "xterm-256color";

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.yank;
        extraConfig = ''
          set -g @yank_selection "primary"
        '';
      }
      {
        plugin = tmuxPlugins.tmux-colors-solarized;
        extraConfig = ''
          set -g @colors-solarized 'light'
        '';
      }
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
