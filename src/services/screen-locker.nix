{...}: {
  services.screen-locker = {
    enable = true;
    inactiveInterval = 1;
    lockCmd = "i3lock-custom";
    xautolock.enable = true;
    xautolock.extraOptions = ["-corners" "000-" "-cornerdelay" "1" "-cornerredelay" "1" "-cornersize" "30"];
  };
}
