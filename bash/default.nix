{ config, lib, pkgs, ... }:
let
  homedir = builtins.getEnv "HOME";
  locale = "C.UTF-8";
in
{
  programs.bash = {
    enable = true;

    initExtra = builtins.readFile ./init;

    sessionVariables = {
      LANG = locale;
      LC_ALL = locale;
      EDITOR = "nvim";
      VISUAL = "nvim";
      JAVA_HOME = "${pkgs.openjdk.home}";
    } // (if (pkgs.stdenv.system == "x86_64-darwin") then {
      BASH_SILENCE_DEPRECATION_WARNING = 1;
      HOMEBREW_NO_AUTO_UPDATE = 1;
    } else
      { });
  };
}
