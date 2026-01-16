{ config, pkgs, ... }:

{
  # To add a fingerprint, simply run `sudo fprintd-enroll`
  services.fprintd = {
    enable = true;

    package = pkgs.fprintd-tod;

    tod = {
      enable = true;

      # device id starts with `27c6:550a:`
      driver = pkgs.libfprint-2-tod1-goodix-550a;
    };
  };

  # 1Password uses polkit+PAM for auth
  security.polkit.enable = true;

  # Enable fingerprint on services
  security.pam.services.login.fprintAuth = true;
  security.pam.services.i3lock.fprintAuth = true;
  security.pam.services.polkit-1.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;

  # Popup windows to tell the user to put it's finger on the reader
  environment.systemPackages = [ pkgs.polkit_gnome ];
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}

