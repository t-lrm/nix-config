{
  lib,
  programs,
  ...
}: {
  programs.zsh = {
    enable = true;
    initContent = lib.concatStringsSep "\n\n" (map builtins.readFile [
      "${vars.dotfiles}/shell/config.sh"
      "${vars.dotfiles}/shell/common-aliases.sh"
      "${vars.dotfiles}/shell/common-functions.sh"
      "${vars.dotfiles}/shell/epita.sh"
      "${vars.dotfiles}/zsh/zshrc"
    ]);
  };
}
