{ config, pkgs, lib, ... }:
let
  pluginGit = ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };

  plugin = pluginGit "HEAD";
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # withNodeJs = true;
    # withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      completion-nvim
      editorconfig-vim
      kommentary
      lightline-vim
      nord-nvim
      nvim-compe
      nvim-lspconfig
      nvim-treesitter
      plenary-nvim
      popup-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      trouble-nvim
      vim-markdown-toc
      vim-nix
      vim-rooter
      vim-terraform
      vim-tmux-navigator
      vim-vsnip
    ];

    extraConfig = builtins.concatStringsSep "\n" [''
      luafile ${builtins.toString ./init-lua.lua}
    ''];
  };
}
