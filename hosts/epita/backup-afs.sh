# On the initial setup, you must run:
# kinit -f timothee.le-roux-maertens@CRI.EPITA.FR

set -euo pipefail

DEST="$HOME/afs-backup"

echo "This script will download a copy of the afs in $DEST through sftp."
echo "You can press Ctrl-C to cancel"
sleep 3

mkdir $DEST

# Note that `get -r *` won't download dotfiles as it would be too slow
# But you can download them using `get -r .` instead
sftp \
  -o PubkeyAuthentication=no \
  -o GSSAPIAuthentication=yes \
  -o GSSAPIDelegateCredentials=yes \
  timothee.le-roux-maertens@ssh.cri.epita.fr <<EOF
lcd $DEST
cd /afs/cri.epita.fr/user/t/ti/timothee.le-roux-maertens/u/
get -r *
EOF
