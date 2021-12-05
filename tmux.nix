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
    extraConfig = ''
      set-window-option -g automatic-rename on
      set-option -g set-titles on
      set -g status-keys vi
      set -g mode-keys vi
      set -g mouse on

      set -g status-interval 1
      set -g status-position top
      set -g status-justify centre
      set -g status-left-length 20
      set -g status-right-length 140
      set -g status-left ""
      set -g status-right ""

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi r send-keys -X rectangle-toggle

      bind-key s split-window -h
      bind-key v split-window -v

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key H resize-pane -L 5
      bind-key L resize-pane -R 5
    '';
  };
}
