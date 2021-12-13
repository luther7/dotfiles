{ config, lib, pkgs, ... }:
let homedir = builtins.getEnv "HOME";
in
{
  programs.bash = {
    enable = true;

    initExtra = builtins.readFile ./init;

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PS1 = "  \\W $ ";
      JAVA_HOME = "${pkgs.openjdk.home}";
    } // (if (pkgs.stdenv.system == "x86_64-darwin") then {
      BASH_SILENCE_DEPRECATION_WARNING = 1;
      HOMEBREW_NO_AUTO_UPDATE = 1;
    } else
      { });

    shellAliases = {
      vim = "nvim";
      rv = "gh repo view -w";
      prw = "gh pr create --web";
      prv = "gh pr view --web";
    } // (if (pkgs.stdenv.system == "x86_64-darwin") then {
      rbs =
        "darwin-rebuild switch -I darwin-config=${homedir}/.config/nixpkgs/darwin.nix";
    } else {
      rbs = "home-manager switch";
    });

    shellOptions = [ "histappend" "checkwinsize" "extglob" ]
      ++ (if (pkgs.stdenv.system == "x86_64-darwin") then
      [ ]
    else [
      "globstar"
      "checkjobs"
    ]);
  };
}
