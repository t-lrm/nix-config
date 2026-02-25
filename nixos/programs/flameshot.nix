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

      uiColor = "#285577";
      contrastOpacity=100;
      drawColor = "#ff0000";
    };
  };
};

}
