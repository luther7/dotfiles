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
    withNodeJs = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      completion-nvim
      editorconfig-vim
      kommentary
      lightline-vim
      nvim-compe
      nvim-lspconfig
      nvim-treesitter
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      nord-nvim
      vim-markdown-toc
      vim-nix
      vim-rooter
      vim-terraform
      vim-tmux-navigator
      vim-vsnip
      # vim-rego
      # nvim-metals
    ];

    extraConfig = builtins.concatStringsSep "\n" [''
      luafile ${builtins.toString ./init-lua.lua}
    ''];
  };
}
