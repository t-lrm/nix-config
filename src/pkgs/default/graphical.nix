{pkgs, ...}: {
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
