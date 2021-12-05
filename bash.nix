{ config, lib, pkgs, ... }:
let
  homedir = builtins.getEnv "HOME";
  locale = "C.UTF-8";
  path = builtins.getEnv "PATH";
  promptcommand = builtins.getEnv "PROMPT_COMMAND";
  sshauthsock = builtins.getEnv "SSH_AUTH_SOCK";
in
{
  programs.bash = {
    enable = true;

    profileExtra = ''
    [[ -z "${sshauthsock}" ]] && eval "$(ssh-agent -s)"
    '';

    sessionVariables = {
      EDITOR = "nvim";
      HOMEBREW_NO_AUTO_UPDATE = 1;
      JAVA_HOME = "${pkgs.openjdk.home}";
      LANG = locale;
      LC_ALL = locale;
      PATH = "${path}:${homedir}/.nix-profile/bin/";
      PROMPT_COMMAND = "history -a; history -c; history -r; ${promptcommand}";
      PS1 = "  \\W \$ ";
      VISUAL = "nvim";
    };
  };
}
