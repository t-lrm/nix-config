{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "generate_architecture";
      runtimeInputs = [pkgs.python3];
      text = ''
        exec ${pkgs.python3}/bin/python3 ${./generate_architecture.py} "$@"
      '';
    })

    (pkgs.writeShellApplication {
      name = "i3lock-custom";
      text = ''
        exec ${./i3lock-custom.sh}
      '';
    })
  ];
}
