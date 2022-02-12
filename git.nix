{ config, lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Franz Neulist Carroll";
    userEmail = "red.note4613@fastmail.com";
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = "false";
    };
  };
}
