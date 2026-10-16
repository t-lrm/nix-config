#!/bin/sh

LOGIN="timothee.le-roux-maertens"
DEST="$(mktemp -d "$HOME"/afs-backup/backup.XXXX)"
SRC="/afs/cri.epita.fr/user/${LOGIN:0:1}/${LOGIN:0:2}/$LOGIN/u"

echo "This script will download a copy $SRC in $DEST through sftp."
echo "You can press Ctrl-C to cancel."
sleep 3

LOG="$(mktemp /tmp/kerberos.XXXXXX)"
echo "Log can be found at $LOG."

klist -a &> "$LOG"

if [ -z "$(cat "$LOG" | grep "$LOGIN")" ]; then
    kinit -f "$LOGIN"@CRI.EPITA.FR
fi

sftp \
  -o PubkeyAuthentication=no \
  -o GSSAPIAuthentication=yes \
  -o GSSAPIDelegateCredentials=yes \
  "$LOGIN"@ssh.cri.epita.fr <<EOF
lcd $DEST
cd $SRC
get -r *
EOF
