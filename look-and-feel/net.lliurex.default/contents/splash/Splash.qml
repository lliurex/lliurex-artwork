/*
    Lliurex look and feel

    Copyright (C) 2019  Enrique Medina Gremaldos <quiqueiii@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/* depends on lliurex sddm package */
import net.lliurex.ui 1.0 as LLX

import SddmComponents 2.0 as Sddm
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kcoreaddons 1.0 as KCoreAddons

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15

Item {
    id: root
    property int stage: 0
    
    anchors.fill:parent
    
    KCoreAddons.KUser {
        id: kuser
    }
    
    LLX.Background {
        anchors.fill: parent
    }
   
    LLX.Window {
        id: pane
        width: 320
        height:240
        
        anchors.centerIn:parent
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins:4
            
            PlasmaCore.IconItem {
                Layout.alignment: Qt.AlignCenter 
                implicitWidth: 64
                implicitHeight: 64
                
                source: {
                    if (kuser.faceIconUrl.toString().length==0) {
                        return "user-identity";
                    }
                    else {
                        return kuser.faceIconUrl;
                    }
                }
                
            }
            
            PlasmaComponents.Label {
                Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                text: kuser.fullName
            }
            
            PlasmaComponents.Label {
                Layout.alignment: Qt.AlignCenter
                text: i18nd("lliurex-plasma-theme","Loading desktop...")
            }
            
            PlasmaComponents.ProgressBar {
                Layout.alignment: Qt.AlignCenter
                implicitWidth: 200
                value: root.stage/6.0
                
                Behavior on value { 
                    PropertyAnimation {
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
}
