{...}: {
  home.shellAliases = {
    # TODO: extract in eza
    ls = "eza -1 --icons=always --group-directories-first --hyperlink --sort=name";
    la = "eza --all --long --group-directories-first --icons=always --hyperlink --sort=name --total-size --git";
    lt = "eza --tree --icons=always --hyperlink --group-directories-first --sort=name --total-size --git --all --ignore-glob='__pycache__|.venv|.git|.idea|.vscode|.DS_Store'";

    t3 = "tree . -I 'obj|bin|.idea|.git' -a";
    y = "yazi";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    # TODO: extract in docker
    dc = "docker compose";

    cf = "find . -iname \"*.h\" -o -iname \"*.c\" -exec clang-format -i";
    grep = "grep --exclude-dir=.git --exclude-dir=.venv --exclude-dir=__pycache__";
  };

  programs.bash = {
    shellAliases = {
    };

    initExtra = ''
      ${builtins.readFile ./common/functions.sh}
      ${builtins.readFile ./bash/bashrc}
    '';
  };

  programs.zsh = {
    shellAliases = {
      nd = "nix develop -c zsh";
      db = "docker build --platform linux/amd64";
    };

    initContent = ''
      ${builtins.readFile ../common/functions.sh}
      ${builtins.readFile ../zsh/zshrc}
    '';
  };
}
