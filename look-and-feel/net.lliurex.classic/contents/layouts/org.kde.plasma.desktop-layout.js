/*
 * Heavily inspired on KDE layout script
*/

var plasma = getApiVersion(1);

const config = ConfigFile("lliurexrc");
config.group = "plasma";
var wname = "/usr/share/wallpapers/" + config.readEntry("wallpaper");

var panel = new Panel;
var panelScreen = panel.screen

panel.height = 2 * Math.floor(gridUnit * 2.5 / 2)

const geo = screenGeometry(panelScreen);
const maximumWidth = geo.width;

panel.alignment = "center";
panel.minimumLength = maximumWidth;
panel.maximumLength = maximumWidth;

var kickoff = panel.addWidget("org.kde.plasma.kickoff");
panel.addWidget("org.kde.placesWidget");
var iconTasks = panel.addWidget("org.kde.plasma.icontasks");
panel.addWidget("org.kde.plasma.marginsseparator");
panel.addWidget("org.kde.plasma.systemtray");
panel.addWidget("org.kde.plasma.digitalclock");
var userSwitcher = panel.addWidget("org.kde.plasma.userswitcher");

kickoff.currentConfigGroup = ["Shortcuts"];
kickoff.writeConfig("global", "Alt+F1");

iconTasks.currentConfigGroup = ["General"];
iconTasks.writeConfig("launchers",[ "applications:org.kde.dolphin.desktop","applications:systemsettings.desktop","applications:firefox.desktop","applications:org.kde.kcalc.desktop","applications:zero-center.desktop"]);
iconTasks.writeConfig("showOnlyCurrentDesktop",false);

userSwitcher.currentConfigGroup = ["General"];
userSwitcher.writeConfig("showFace",true);
userSwitcher.writeConfig("showFullname",false);
userSwitcher.writeConfig("showName",false);

var desktopsArray = desktopsForActivity(currentActivity());
for( var j = 0; j < desktopsArray.length; j++) {
    desktopsArray[j].wallpaperPlugin = 'org.kde.image';
    desktopsArray[j].currentConfigGroup = ["Wallpaper","org.kde.image","General"];
    desktopsArray[j].writeConfig("Image",wname);
}
