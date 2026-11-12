{
  pkgs,
  lib,
  ...
}: {
  home.packages =
    [
      (pkgs.writeShellApplication {
        name = "archi";
        runtimeInputs = [pkgs.python3];
        text = ''
          exec python3 ${./generate_architecture.py} "$@"
        '';
      })

      (pkgs.writeShellApplication {
        name = "backup-afs";
        runtimeInputs = with pkgs; [
          bash
          coreutils
          openssh
          krb5
        ];
        text = ''
          exec bash ${./backup-afs.sh} "$@"
        '';
      })
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      (pkgs.writeShellApplication {
        name = "i3lock-custom";

        runtimeInputs = with pkgs; [
          i3lock-color
        ];

        text = ''
          exec bash ${./i3lock-custom.sh} "$@"
        '';
      })
    ];
}
