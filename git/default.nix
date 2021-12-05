{ config, lib, pkgs, ... }: {
  programs.git = {
    extraConfig = {
      http.sslVerify = true;
      pull.rebase = false;
      commit.verbose = true;
    };

    delta.enable = true;
  };
}
