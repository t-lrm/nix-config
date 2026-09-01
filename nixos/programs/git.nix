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

      apply.whitespace = "error";

      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = "all";
      };

      url = {
        "git@github.com:" = {
          insteadOf = "gh:";
        };

        "git@gitlab.com:" = {
          insteadOf = "gl:";
        };

        "git@gitlab.cri.epita.fr:" = {
          insteadOf = "cri:";
        };

        "git@github.com:t-lrm/" = {
          insteadOf = "t-lrm:";
        };

        "git@github.com:umyedi/" = {
          insteadOf = "umyedi:";
        };

        "git@gitlab.cri.epita.fr:timothee.le-roux-maertens/" = {
          insteadOf = "tlrm:";
        };

        "git@gitlab.com:prologin/" = {
          insteadOf = "prolo:";
        };
      };
    };

    ignores = [".env" "*.swp" ".DS_Store"];

  };
}
