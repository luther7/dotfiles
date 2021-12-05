{ config, pkgs, ... }:
{
  imports =
    if builtins.currentSystem == "x86_64-darwin"
    then [ ./common.nix ./darwin.nix ]
    else [ ./common.nix ];
}
