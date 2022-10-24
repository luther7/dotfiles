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
    plugins = with pkgs.vimPlugins; [
      completion-nvim
      editorconfig-vim
      gitsigns-nvim
      kommentary
      kotlin-vim
      lightline-vim
      lspsaga-nvim
      nordic-nvim
      nvim-compe
      nvim-dap
      nvim-lspconfig
      nvim-treesitter
      plenary-nvim
      popfix
      popup-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      vim-markdown-toc
      vim-nix
      vim-rooter
      vim-terraform
      vim-tmux-navigator
      vim-vsnip
    ];
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      nodePackages.diagnostic-languageserver
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-json-languageserver
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      pyright
      rnix-lsp
      solargraph
      terraform-ls
    ];
    extraConfig = builtins.concatStringsSep "\n" [''
      luafile ${builtins.toString ./vim.lua}
    ''];
  };
}
