/*
    Lliurex look and feel

    Copyright (C) 2022  Enrique Medina Gremaldos <quiqueiii@gmail.com>

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

import net.lliurex.ui 1.0 as LLX

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.workspace.components 2.0 as PW
import org.kde.kcoreaddons 1.0 as KCoreAddons

import org.kde.plasma.private.sessions 2.0

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15

Item {
    id: root
    focus: true
    anchors.fill: parent
    
    property int timeRemaining: 20
    
    signal logoutRequested()
    signal haltRequested()
    signal suspendRequested(int spdMethod)
    signal rebootRequested()
    signal rebootRequested2(int opt)
    signal cancelRequested()
    signal lockScreenRequested()
    
    KCoreAddons.KUser {
        id: kuser
    }
    
    Timer {
        id: timer
        running:true
        interval: 500
        repeat:true
        
        onTriggered: {
            root.timeRemaining-=1;
            
            if (root.timeRemaining == 0) {
                repeat = false;
            }
            else {
                var action;
                
                switch (sdtype) {
                    case ShutdownType.ShutdownTypeHalt:
                        action = "shutdown";
                    break;
                    
                    default:
                        action = "";
                }
                
                msgText.text="System is going to "+action+" in "+root.timeRemaining+" s";
            }
        }
    }
    
    Component.onCompleted: {
        switch (sdtype) {
            case ShutdownType.ShutdownTypeHalt:
                btnHalt.forceActiveFocus();
            break;
            
        }
        
        btnHalt.forceActiveFocus();
    }
    
    Keys.onReturnPressed: {
        console.log("Enter Item");
    }
    
    LLX.Background {
        anchors.fill: parent
        focus: false
    }
    
    LLX.Window {
        id: logoutWIndow
        title: ""
        width:480
        height:320
        anchors.centerIn:parent
        //visible: root.topWindow == this
        focus: true
        
        ColumnLayout {
            anchors.fill: parent
            
            PlasmaCore.IconItem {
                Layout.alignment: Qt.AlignHCenter
                
                id: faceIcon
                source: kuser.faceIconUrl
                //visible: (face.status == Image.Error || face.status == Image.Null)
                implicitWidth: 64
                implicitHeight: 64
                focus: false
                //anchors.fill: parent
                //anchors.margins: PlasmaCore.Units.gridUnit * 0.5 // because mockup says so...
                //colorGroup: PlasmaCore.ColorScope.colorGroup
            }
            
            PlasmaComponents.Label {
                Layout.alignment: Qt.AlignHCenter
                text: kuser.fullName
                focus: false
            }
            
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Suspend")
                    
                    implicitWidth: PlasmaCore.Units.gridUnit*6
                    icon.name: "system-suspend"
                    display: QQC2.AbstractButton.TextUnderIcon
                    
                    onClicked: root.suspendRequested(2);
                    
                }
                
                PlasmaComponents.Button {
                    id: btnHalt
                    text: i18nd("lliurex-plasma-theme","Power off")
                    
                    implicitWidth: PlasmaCore.Units.gridUnit*6
                    icon.name: "system-shutdown"
                    display: QQC2.AbstractButton.TextUnderIcon
                    focus: sdtype === ShutdownType.ShutdownTypeHalt
                    //focus: true
                    
                    onClicked: root.haltRequested();
                    
                }
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Reboot")
                    
                    implicitWidth: PlasmaCore.Units.gridUnit*6
                    icon.name: "system-reboot"
                    display: QQC2.AbstractButton.TextUnderIcon
                    focus: sdtype === ShutdownType.ShutdownTypeReboot
                    
                    onClicked: root.rebootRequested();
                    
                }
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Log out")
                    
                    implicitWidth: PlasmaCore.Units.gridUnit*6
                    icon.name: "system-log-out"
                    display: QQC2.AbstractButton.TextUnderIcon
                    focus: sdtype === ShutdownType.ShutdownTypeNone
                    
                    onClicked: root.logoutRequested();
                    
                }
            }
            
            PlasmaComponents.Label {
                id: msgText
                focus: false
            }
            
            PlasmaComponents.ProgressBar {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                value: root.timeRemaining/20.0
                focus: false
                Behavior on value { 
                    PropertyAnimation {
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            
            PlasmaComponents.Button {
                Layout.alignment: Qt.AlignRight
                text: i18nd("lliurex-plasma-theme","Cancel")
                implicitWidth: PlasmaCore.Units.gridUnit * 6
                focus: false
                onClicked: root.cancelRequested();
            }
                
            
            
        }
    }
}
