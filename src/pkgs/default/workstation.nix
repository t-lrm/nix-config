{pkgs, ...}: {
  imports = [
    ./cli.nix
  ];

  home.packages = with pkgs; [
    firefox
    chromium
    tor-browser
    spotify
    discord
    vlc
    obsidian
    ollama
    libreoffice-still
    qbittorrent
  ];
}
