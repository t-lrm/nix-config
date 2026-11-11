{...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Timothée Le Roux Maertens";
        email = "timothee.le-roux-maertens@epita.fr";

        # gpg fingerprint (can be found with 'gpg -k')
        signingkey = "DDDE3652BD24ED9E6822793DEF63CCDFBECDC634";
      };

      gpg.format = "openpgp";
      commit.gpgsign = true;

      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = "all";
      };

      push = {
        autoSetupRemote = true;
      };

      alias = {
        gs = "git status";
        ga = "git add";
        gap = "git add -Ap";
        gc = "git commit";
        gcm = "git commit -m";
        gcl = "git clone";
        gp = "git push";
        gpf = "git push --follow-tags";
        gt = "git tag -ma";
        gtl = "git tag --list";
        gtd = "git tag --delete";
        gd = "git diff";
        gds = "git diff --staged";
        gr = "git restore -p";
        grs = "git restore --staged";
        gl = "git log --all --graph --decorate=full";
      };

      url = {
        "git@github.com:" = {insteadOf = "gh:";};
        "git@gitlab.com:" = {insteadOf = "gl:";};
        "git@gitlab.cri.epita.fr:" = {insteadOf = "cri:";};
        "git@gitlab.com:prologin/" = {insteadOf = "prolo:";};
      };

      # Required to mount afs from home
      "ssh.cri.epita.fr" = {
        GSSAPIAuthentication = "yes";
        GSSAPIDelegateCredentials = "yes";
      };
    };

    ignores = [
      # Global
      ".env"
      ".envrc"
      ".direnv/"
      "*.swp"

      # MacOS
      ".DS_Store"

      # Python
      "__pycache__"
      "*.pyc"
      ".pytest_cache/"

      # C
      "*.o"
      "*.d"
      "compile_commands.json"
    ];
  };
}
