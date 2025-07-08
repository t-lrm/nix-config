# Packages
## 1Password (CLI and GUI)
---
```nixos
{
  # 1Password CLI
  programs._1password = { enable = true; };
  
  # 1Password GUI
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "baunky" ]; # this makes system auth etc. work properly
  };
}
```
#  Key shortcuts
## Open terminal
---
To open a new terminal, we need to identify the console application in `/nix/store`:
```bash
cd /nix/store
ls -d */ | grep "console" # List only directories
```
---
```bash
fa599f287v2dkdmhiks8nfshhlfzm3mc-unit-reload-systemd-vconsole-setup.service/
hqn5v4hpsny08jd72r41wv8aq3prkhs6-gnome-console-48.0.1/
i63yv6rpb017pg8vp9ycwx5x0rwxyjsm-unit-console-getty.service-disabled/
mccqlybmml12k1bn3lavxbcqk8vy1xkr-console-env/
```
---
In the output we can identify `gnome-console` that is our console. So to open a new terminal, you just need to run the following command:
```bash
/nix/store/hqn5v4hpsny08jd72r41wv8aq3prkhs6-gnome-console-48.0.1/bin/kgx
```
---
In the settings, you can now assign a shortcut to this command.
# SSH keys
---
As we've installed a brand new system, we need to setup a new SSH key. To so this, run the following command:
```bash
ssh-keygen -a 100 -t ed25519
```
---
Now you can copy the `.pub` file and paste your key in every services you need:
- Github
- CRI
- ...
# Git
## Configuration
---
Once you've added your SSH key, you can setup your identity on git by running:
```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```
