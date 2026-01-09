{...}:
{
  systemd.user.services."startup-initialisation" = {
    description = "Set the volume/brightness at startup.";

    serviceConfig = {
      Type = "oneshot";
    };

    wantedBy = [ "default.target" ];

    # This scripts doesn't work for now
    script = ''
      pactl set-sink-volume @DEFAULT_SINK@ 60%
      pactl set-sink-mute @DEFAULT_SINK@ 1
      brightnessctl set 80%
    '';
  };
}
