{...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Bluetooth manager (run with blueman-manager)
  services.blueman.enable = true;
}
