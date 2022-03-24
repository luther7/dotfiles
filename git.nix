{ config, lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    # userName = "Franz Neulist Carroll";
    # userEmail = "red.note4613@fastmail.com";
    extraConfig = {
      core = {
        whitespace = "trailing-space,space-before-tab";
      };
      init.defaultBranch = "main";
      pull.rebase = "false";
      url."ssh://git@host".insteadOf = "otherhost";
    };
  };
}
