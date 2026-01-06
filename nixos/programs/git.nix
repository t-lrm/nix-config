{...}: {
  programs.git = {
    enable = true;

    settings.user = {
      name = "Timothée Le Roux Maertens";
      email = "timothee.le-roux-maertens@epita.fr";
    };

    ignores = [
      ".env"
      "*.swp"
    ];
  };
}
