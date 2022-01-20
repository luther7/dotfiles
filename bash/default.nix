{ config, lib, pkgs, ... }:
let
  homedir = builtins.getEnv "HOME";
  macos = pkgs.stdenv.system == "x86_64-darwin";
in
{
  programs.bash = {
    enable = true;

    profileExtra = builtins.readFile ./private-profile-extra + ''
      [[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)"
    '';

    initExtra = ''
      PATH="$PATH:$HOME/.nix-profile/bin/";
    '';

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PS1 = " \\W $ ";
    } // (if macos then {
      BASH_SILENCE_DEPRECATION_WARNING = 1;
      HOMEBREW_NO_AUTO_UPDATE = 1;
    } else
      { });

    shellAliases = import ./private-aliases.nix // {
      vim = "nvim";
      ops = "eval $(op login my)";
      rv = "gh repo view -w";
      prw = "gh pr create --web";
      prv = "gh pr view --web";
    } // (if macos then {
      rbs =
        "darwin-rebuild switch -I darwin-config=${homedir}/.config/nixpkgs/darwin.nix";
    } else {
      rbs = "home-manager switch";
    });

    shellOptions = [ "histappend" "checkwinsize" "extglob" ]
      ++ (if macos then
      [ ]
    else [
      "globstar"
      "checkjobs"
    ]);
  };
}
