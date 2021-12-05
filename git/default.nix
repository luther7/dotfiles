{ config, lib, pkgs, ... }: {
  programs.git = {
    extraConfig = {
      commit.verbose = true;
      default = "current";
      http.sslVerify = true;
      pull.rebase = false;
    };

    delta.enable = true;
  };
}
