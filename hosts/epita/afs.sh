# On the initial setup, you must run:
# kinit -f timothee.le-roux-maertens@CRI.EPITA.FR

mkdir -p "$HOME/afs"

sshfs \
  -o reconnect \
  -o PubkeyAuthentication=no \
  -o GSSAPIAuthentication=yes \
  -o GSSAPIDelegateCredentials=yes \
  timothee.le-roux-maertens@ssh.cri.epita.fr:/afs/cri.epita.fr/user/t/ti/timothee.le-roux-maertens/u/ \
  ~/afs
