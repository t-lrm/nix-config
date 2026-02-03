{...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$python$nix_shell$character";
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
      python = {
        format = " [venv:$virtualenv]($style)";

        detect_extensions = [];
        detect_files = [];
        detect_folders = [];
      };
      nix_shell = {
        heuristic = true;
        symbol = "󱄅 ";
        format = " [$symbol$state]($style)";
        style = "bold blue";
        pure_msg = "dev";
        impure_msg = "dev";
        unknown_msg = "sh";
      };
      character = {
        format = " $symbol ";
        success_symbol = "➜";
        error_symbol = "✗";
      };
    };
  };
}
