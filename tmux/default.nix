{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    secureSocket = true;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.nord;
        extraConfig = ''
          set -g @nord_tmux_no_patched_font "1"
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
