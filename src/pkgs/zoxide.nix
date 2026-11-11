{...}: {
  # TODO: set the DB path in the repo

  programs.zoxide = {
    enable = true;
    options = [
      #"--cmd cd"
    ];
  };
}
