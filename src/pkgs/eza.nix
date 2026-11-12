{...}: {
  programs.eza = {
    enable = true;

    icons = "always";
    git = true;

    enableZshIntegration = true;
    enableBashIntegration = true;

    extraOptions = [
      "--group-directories-first"
      "--sort=name"
    ];
  };

  home.shellAliases = {
    ls = "eza -1";
    la = "eza --all --long --total-size";
    lt = "eza --tree  --total-size --all --ignore-glob='__pycache__|.venv|.git|.idea|.vscode|.DS_Store'";
  };
}
