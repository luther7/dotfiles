{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    newSession = true;
    secureSocket = false;
    baseIndex = 1;
    escapeTime = 50;
    keyMode = "vi";
    terminal = "alacritty";
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.yank;
        extraConfig = ''
          set -g @yank_selection "primary"
        '';
      }
      {
        plugin = tmuxPlugins.nord;
        extraConfig = ''
          set -g @nord_tmux_no_patched_font "1"
        '';
      }
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
