{...}: {
  home.shellAliases = {
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
      ${builtins.readFile ./common/functions.sh}
      ${builtins.readFile ./zsh/zshrc}
    '';
  };
}
