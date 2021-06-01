var plasma = getApiVersion(1);

const config = ConfigFile("lliurexrc");
config.group = "plasma";
var wname = config.readEntry("wallpaper");

var layout = {
    "desktops": [
        {
            "applets": [
            ],
            "config": {
                "/": {
                    "ItemGeometriesHorizontal": "",
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "540",
                    "DialogWidth": "720"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                },
                "/General": {
                    "ToolBoxButtonState": "topcenter",
                    "ToolBoxButtonX": "565",
                    "sortMode": "-1"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Image": wname
                }
            },
            "wallpaperPlugin": "org.kde.image"
        }
    ],
    "panels": [
        {
            "alignment": "center",
            "applets": [
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "100"
                        },
                        "/Configuration/General": {
                            "favoriteApps":["firefox.desktop","systemsettings.desktop","zero-center.desktop","org.kde.dolphin.desktop","lliurex-store.desktop","org.kde.konsole.desktop"]
                        },
                        "/Shortcuts" : {
                            "global" : "Alt+F1"
                        }
                    },
                    "plugin": "org.kde.plasma.kicker"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "65"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "length": "1165",
                            "widgetWidth": "300"
                        }
                    },
                    "plugin": "org.kde.placesWidget"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "42"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Shortcuts" : {
                            "global" : "Alt+d"
                        }
                    },
                    "plugin": "org.kde.plasma.minimizeall"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "0"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "launchers":[ "applications:org.kde.dolphin.desktop","applications:systemsettings.desktop","applications:org.kde.konsole.desktop","applications:firefox.desktop","applications:org.kde.kcalc.desktop","applications:org.kde.ksysguard.desktop"],
                            "showOnlyCurrentDesktop": "false"
                        }
                    },
                    "plugin": "org.kde.plasma.icontasks"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "128"
                        }
                    },
                    "plugin": "org.kde.plasma.systemtray"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "3"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        }
                    },
                    "plugin": "org.kde.plasma.digitalclock"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "64"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "showFace": "true",
                            "showFullName": "false",
                            "showName": "false"
                        }
                    },
                    "plugin": "org.kde.plasma.userswitcher"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "84",
                    "DialogWidth": "1920"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                }
            },
            "height": 2.7777777777777777,
            "hiding": "normal",
            "location": "bottom",
            "maximumLength": 106.66666666666667,
            "minimumLength": 82.44444444444444,
            "offset": 0
        }
    ],
    "serializationFormatVersion": "1"
}
;

plasma.loadSerializedLayout(layout);
