{config, ...}:
{
  services.flameshot = {
  enable = true;
  settings = {
    General = {
      savePath = "${config.home.homeDirectory}/Pictures/Screenshots";
      disabledTrayIcon = true;
      showStartupLaunchMessage = false;
      saveAsFileExtension = ".png";
      showDesktopNotification = false;
      showAbortNotification = false;
      showHelp = false;
      showSidePanelButton = false;

      uiColor = "#740096";
      contrastUiColor = "#270032";
      drawColor = "#ff0000";
    };
  };
};

}
