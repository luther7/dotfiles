{ config, lib, pkgs, ... }: with lib;
let
  homedir = builtins.getEnv "HOME";
in
{
  programs.bash = {
    enable = true;
    historyFileSize = 100000;
    historySize = 100000;
    profileExtra = ''
      if [[ -z "$__PROFILE_SOURCED" ]] && [[ -f "$HOME/.profile" ]]; then
        umask 027
        if [ -f "${config.home.profileDirectory}/etc/profile.d/nix.sh" ]; then
          . "${config.home.profileDirectory}/etc/profile.d/nix.sh"
        fi
        [[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)"
        # export TERM=xterm-256color
        export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
        export PATH="$HOME/.local/bin:$PATH"
        export PATH="$HOME/bin:$PATH"
        export __PROFILE_SOURCED=1
      fi
    '';
    bashrcExtra = ''
      export EDITOR=nvim
      export VISUAL=nvim
      export HISTCONTROL=ignoredups:erasedups
      export HISTSIZE=100000
      export HISTFILESIZE=100000
      export PS1=" \\W $ "
      export BASH_SILENCE_DEPRECATION_WARNING=1
      export HOMEBREW_NO_AUTO_UPDATE=1
    '';
    shellAliases = {
      vim = "nvim";
      rv = "gh repo view -w";
      prw = "gh pr create --web";
      prv = "gh pr view --web";
    } // optionalAttrs pkgs.stdenv.isLinux { rbs = "home-manager switch"; }
    // optionalAttrs pkgs.stdenv.isDarwin {
      rbs =
        "darwin-rebuild switch --flake ~/.config/nixpkgs";
      awk = "gawk";
      grep = "ggrep";
      sed = "gsed";
    };
    shellOptions = flatten [
      [ "histappend" "histreedit" "checkwinsize" "hostcomplete" "extglob" ]
      (optional pkgs.stdenv.isLinux [ "globstar" "checkjobs" ])
      (optional pkgs.stdenv.isDarwin [ ])
    ];
  };
}
