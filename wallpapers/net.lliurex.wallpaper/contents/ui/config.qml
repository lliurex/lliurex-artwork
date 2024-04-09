/*
    SPDX-FileCopyrightText: 2013 Marco Martin <mart@kde.org>
    SPDX-FileCopyrightText: 2014 Kai Uwe Broulik <kde@privat.broulik.de>
    SPDX-FileCopyrightText: 2019 David Redondo <kde@david-redondo.de>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0 // for Screen
import org.kde.plasma.wallpapers.image 2.0 as PlasmaWallpaper
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kquickcontrols 2.0 as KQuickControls
import org.kde.kquickcontrolsaddons 2.0
import org.kde.kcm 1.5 as KCM
import org.kde.kirigami 2.12 as Kirigami

ColumnLayout {
    id: root

    property string cfg_Mode
    property alias cfg_Color : btnColor.color
    property alias cfg_Light : chkLight.checked
    property alias cfg_Characters : chkCharacters.checked

    RowLayout {
        PlasmaComponents.Label {
            text: i18nd("lliurex-plasma-theme","Wallpaper mode:")
        }

        PlasmaComponents.ComboBox {
            id: comboMode

            property bool manual : (currentText === "Manual")

            model: ["Auto", "Infantil", "Neutral", "Admin", "Manual"]

            Component.onCompleted: {
                currentIndex = find(root.cfg_Mode);
            }

            onActivated: {
                root.cfg_Mode = comboMode.currentText;
            }
        }
    }

    RowLayout {
        PlasmaComponents.Label {
            text: i18nd("lliurex-plasma-theme","Color:")
        }

        KQuickControls.ColorButton
        {
            id: btnColor
            dialogTitle: i18nd("lliurex-plasma-theme","Background color")
            enabled: comboMode.manual

            onColorChanged: {

            }
        }
    }

    RowLayout {

        QQC2.CheckBox {
            id: chkLight
            enabled: comboMode.manual
            text: i18nd("lliurex-plasma-theme","Light effect")
        }
    }

    RowLayout {

        QQC2.CheckBox {
            id: chkCharacters
            enabled: comboMode.manual
            text: i18nd("lliurex-plasma-theme","Characters")
        }
    }

    RowLayout {
        PlasmaComponents.Button {
            text: i18nd("lliurex-plasma-theme","Restore defaults")

            onClicked: {
                comboMode.currentIndex = 0;
                btnColor.color = "#2980b9";
            }
        }

    }

    Item {
        Layout.fillHeight:true
    }

}
