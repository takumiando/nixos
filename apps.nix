{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Common utils
    vim
    tmux
    git
    fzf
    distrobox

    # Terminal
    ghostty

    # Media player
    mpv

    # Sound effector
    easyeffects

    # Non-free apps
    vivaldi
    spotify
    discord
  ];
}
