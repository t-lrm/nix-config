{...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$python$character";
      python = {
        format = " [venv:$virtualenv]($style)";

        detect_extensions = [];
        detect_files = [];
        detect_folders = [];
      };
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
}
