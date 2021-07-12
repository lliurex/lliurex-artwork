/*
    Lliurex Splash

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
import Lliurex.Noise 1.0 as Noise

import SddmComponents 2.0 as Sddm
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.16 as Kirigami
import org.kde.kcoreaddons 1.0 as KCoreAddons

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    property int stage: 0
    
    anchors.fill:parent
    
    color: "#2980b9"
    
    Noise.UniformSurface {
        opacity: 0.025
        
        anchors.fill: parent
    }
    
    KCoreAddons.KUser {
        id: kuser
    }
    
    Rectangle {
        id: shadow
        color: "#40000000"
        radius:5
        anchors.centerIn: parent
        width: pane.width+6
        height: pane.height+6
    }
    
    Rectangle {
        id: pane
        width: 320
        height:240
        radius: 5
        color: "#eff0f1"
        
        anchors.centerIn:parent
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins:12
            
            QQC2.Button {
                flat:true
                icon.width:64
                icon.height:64
                Layout.alignment: Qt.AlignCenter
                
                icon.source:kuser.faceIconUrl
                icon.name:kuser.faceIconUrl=="" ? "user-identity" : ""
                
            }
            
            QQC2.Label {
                Layout.alignment: Qt.AlignCenter
                text: kuser.fullName
            }
            
            QQC2.Label {
                Layout.alignment: Qt.AlignCenter
                text: i18nd("lliurex-plasma-theme","Loading desktop...")
            }
            
            QQC2.ProgressBar {
                Layout.alignment: Qt.AlignCenter
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
