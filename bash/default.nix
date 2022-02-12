{ config, lib, pkgs, ... }:

with lib;

let homedir = builtins.getEnv "HOME";
in {
  programs.bash = {
    enable = true;
    historyFileSize = 100000;
    historySize = 100000;

    profileExtra = builtins.readFile ./private-profile-extra + ''
      umask 027

      if [ -f "${config.home.profileDirectory}/etc/profile.d/nix.sh" ]; then
        . "${config.home.profileDirectory}/etc/profile.d/nix.sh"
      fi

      [[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)"

      export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$HOME/bin:$PATH"
      export __PROFILE_SOURCED=1
    '';

    initExtra = ''
      if [[ -z "$__PROFILE_SOURCED" ]] && [[ -f "$HOME/.profile" ]]; then
        source "$HOME/.profile"
      fi
    '';

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      HISTCONTROL = "ignoredups:erasedups";
      HISTSIZE = "100000";
      HISTFILESIZE = "100000";
      PS1 = " \\W $ ";
    } // optionalAttrs pkgs.stdenv.isLinux { }
      // optionalAttrs pkgs.stdenv.isDarwin {
        BASH_SILENCE_DEPRECATION_WARNING = 1;
        HOMEBREW_NO_AUTO_UPDATE = 1;
      };

    shellAliases = import ./private-aliases.nix // {
      vim = "nvim";
      ops = "eval $(op login my)";
      rv = "gh repo view -w";
      prw = "gh pr create --web";
      prv = "gh pr view --web";
    } // optionalAttrs pkgs.stdenv.isLinux { rbs = "home-manager switch"; }
      // optionalAttrs pkgs.stdenv.isDarwin {
        rbs =
          "darwin-rebuild switch -I darwin-config=${homedir}/.config/nixpkgs/darwin.nix";
      };

    shellOptions = flatten [
      [ "histappend" "histreedit" "checkwinsize" "hostcomplete" "extglob" ]
      (optional pkgs.stdenv.isLinux [ "globstar" "checkjobs" ])
      (optional pkgs.stdenv.isDarwin [ ])
    ];
  };
}
