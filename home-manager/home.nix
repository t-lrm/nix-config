{
  config,
  pkgs,
  ...
}: {
  xdg = {
    enable = true;
    configFile = {
      "i3/config".source = ./../dotfiles/i3/config;
      "i3status-rust/config.toml".source = ./../dotfiles/i3status-rust/config.toml;
      "alacritty/alacritty.toml".source = ./../dotfiles/alacritty/alacritty.toml;
    };
  };

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [
    # Fonts
    jetbrains-mono
    font-awesome

    # Apps
    alacritty
    firefox
    google-chrome
    obsidian
    discord
    vlc
    libreoffice-still
    vscode
    spotify
    todoist-electron

    # Other
    pavucontrol
    maim
    xclip # screenshots
    dunst
    libnotify # notification manager
    brightnessctl

    # i3 related tools
    rofi # app launcher
    i3lock-color # better i3lock
    i3status-rust # better i3status
  ];

  programs.home-manager.enable = true;

  # Bash setup (aliases/functions)
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # --- Aliases ---

      # Basic shortcuts
      alias ll='ls -alF --color=auto'
      alias la='ls -A --color=auto'
      alias l='ls -CF --color=auto'
      alias ..='cd ..'
      alias ...='cd ../..'
      alias t3='tree . -I "obj|bin|.idea|.git" -a'

      # Git shortcuts
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit -m'
      alias gp='git push'
      alias gpt='git push --follow-tags'
      alias gt='git tag -ma'
      alias gd='git diff'

      # Python virtualenv helper
      alias venv='source .venv/bin/activate'

      # --- Functions ---

      # Quick mkcd - make directory and cd into it
      mkcd () {
          mkdir -p "$1" && cd "$1"
      }

      # Copy text to clipboard
      cb () {
          xclip -selection clipboard < "$1"
      }

      # Run clang-format on a whole repo
      formatc() {
        find . -iname '*.h' -o -iname '*.c' | xargs clang-format -i
      }
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$character";
      username = {
        show_always = true;
        format = "$user@";
      };
      hostname = {
        ssh_only = false;
        format = "$hostname";
      };
      directory = {
        format = " [$path]($style)";
      };
      git_branch = {
        format = " [$symbol$branch]($style)";
      };
      character = {
        format = " $symbol ";
        success_symbol = "➜";
        error_symbol = "✗";
      };
    };
  };

  home.stateVersion = "25.11"; # DOT NOT CHANGE
}
