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

import org.kde.plasma.private.sessions
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.workspace.components 2.0 as PW
import org.kde.plasma.private.sessions 2.0
import org.kde.coreaddons 1.0 as KCoreAddons
import org.kde.kirigami 2.16 as Kirigami

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
    
    SessionsModel {
        id: sessionsModel
        showNewSessionEntry: false
    }
    
    Component.onCompleted: {
        if (sdtype!=ShutdownType.ShutdownTypeNone) {
            if (sessionsModel.count>0) {
                message.type=Kirigami.MessageType.Warning;
                message.text=i18nd("lliurex-plasma-theme","There are running sessions");
                message.visible=true;
                timer.running=false;
                progressbar.value=1.0;
            }
        }
        else {
            allWindow.visible = true;
            logoutWindow.visible = false;
        }
    }
    
    Timer {
        id: timer
        running:true
        interval: 1000
        repeat:true
        
        onTriggered: {
            root.timeRemaining-=1;
            
            if (root.timeRemaining == 0) {
                repeat = false;
                
                switch (sdtype) {
                    case ShutdownType.ShutdownTypeHalt:
                        root.haltRequested();
                    break;
                    
                    case ShutdownType.ShutdownTypeReboot:
                        root.rebootRequested();
                    break;
                    
                    case ShutdownType.ShutdownTypeDefault:
                    case ShutdownType.ShutdownTypeNone:
                        root.logoutRequested();
                    break;
                }
                
            }
            else {
                var action = "";
                
                switch (sdtype) {
                    case ShutdownType.ShutdownTypeHalt:
                        action = i18nd("lliurex-plasma-theme","System is about to power off");
                    break;
                    
                    case ShutdownType.ShutdownTypeReboot:
                        action = i18nd("lliurex-plasma-theme","System is about to reboot");
                    break;
                    
                    case ShutdownType.ShutdownTypeDefault:
                    case ShutdownType.ShutdownTypeNone:
                        action = i18nd("lliurex-plasma-theme","Session is about to log out");
                    break;

                }
                
                msgText.text=action + ": " + root.timeRemaining+i18nd("lliurex-plasma-theme"," seconds");;
            }
        }
    }
    
    Keys.onReturnPressed: {
        
        switch (sdtype) {
            case ShutdownType.ShutdownTypeHalt:
                root.haltRequested();
            break;
            
            case ShutdownType.ShutdownTypeReboot:
                root.rebootRequested();
            break;
            
            case ShutdownType.ShutdownTypeDefault:
            case ShutdownType.ShutdownTypeNone:
                root.logoutRequested();
            break;
        }
    }
    
    /*
    LLX.Background {
        anchors.fill: parent
    }
    */
    Rectangle {
        color: "#000000"
        opacity: 0.8
    }
    
    LLX.Window {
        id: allWindow
        title: ""
        width:580
        height:220
        anchors.centerIn:parent
        visible: false

        ColumnLayout {
            anchors.fill: parent

            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter

                PlasmaComponents.Button {

                    text: i18nd("lliurex-plasma-theme","Power off")

                    implicitWidth: Kirigami.Units.gridUnit*6
                    icon.name: "system-shutdown"
                    display: QQC2.AbstractButton.TextUnderIcon
                    visible: maysd

                    onClicked: root.haltRequested();
                }

                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Reboot")

                    implicitWidth: Kirigami.Units.gridUnit*6
                    icon.name: "system-reboot"
                    display: QQC2.AbstractButton.TextUnderIcon
                    visible: maysd

                    onClicked: root.rebootRequested();
                }

                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Log out")

                    implicitWidth: Kirigami.Units.gridUnit*6
                    icon.name: "system-log-out"
                    display: QQC2.AbstractButton.TextUnderIcon

                    onClicked: root.logoutRequested();

                }
            }

            PlasmaComponents.Button {
                Layout.alignment: Qt.AlignRight
                text: i18nd("lliurex-plasma-theme","Cancel")
                implicitWidth: Kirigami.Units.gridUnit * 6

                onClicked: root.cancelRequested();
            }
        }

    }

    LLX.Window {
        id: logoutWindow
        title: ""
        width:480
        height:320
        anchors.centerIn:parent
        //visible: root.topWindow == this
        focus: true
        
        ColumnLayout {
            anchors.fill: parent
            
            Kirigami.Icon {
                Layout.alignment: Qt.AlignHCenter
                
                id: faceIcon
                source: kuser.faceIconUrl
                //visible: (face.status == Image.Error || face.status == Image.Null)
                implicitWidth: 64
                implicitHeight: 64
                focus: false
                //anchors.fill: parent
                //anchors.margins: Kirigami.Units.gridUnit * 0.5 // because mockup says so...
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
                visible: false
                
                
            }
            
            PlasmaComponents.Label {
                id: msgText
                focus: false
            }
            
            Kirigami.InlineMessage {
                id: message
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                
            }
            
            PlasmaComponents.ProgressBar {
                id: progressbar
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                value: root.timeRemaining/20
                focus: false
                Behavior on value { 
                    PropertyAnimation {
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignRight
                /*
                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Suspend")
                    
                    implicitWidth: Kirigami.Units.gridUnit*6
                    icon.name: "system-suspend"
                    display: QQC2.AbstractButton.TextUnderIcon
                    
                    onClicked: root.suspendRequested(2);
                    
                }
                */

                PlasmaComponents.Button {
                    Layout.alignment: Qt.AlignLeft
                    //text: i18nd("lliurex-plasma-theme","Other")
                    implicitWidth: Kirigami.Units.gridUnit * 3
                    icon.name: "arrow-left"

                    onClicked: {
                        logoutWindow.visible=false;
                        allWindow.visible=true;
                        timer.running=false;
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                PlasmaComponents.Button {
                    id: btnHalt
                    text: i18nd("lliurex-plasma-theme","Power off")
                    
                    implicitWidth: Kirigami.Units.gridUnit*6
                    icon.name: "system-shutdown"
                    //display: QQC2.AbstractButton.TextUnderIcon
                    visible: sdtype === ShutdownType.ShutdownTypeHalt
                    
                    onClicked: root.haltRequested();
                }
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Reboot")
                    
                    implicitWidth: Kirigami.Units.gridUnit*6
                    icon.name: "system-reboot"
                    //display: QQC2.AbstractButton.TextUnderIcon
                    visible: sdtype === ShutdownType.ShutdownTypeReboot
                    
                    onClicked: root.rebootRequested();
                }
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Log out")
                    
                    implicitWidth: Kirigami.Units.gridUnit*6
                    icon.name: "system-log-out"
                    //display: QQC2.AbstractButton.TextUnderIcon
                    visible: sdtype === ShutdownType.ShutdownTypeNone
                    
                    onClicked: root.logoutRequested();
                    
                }
                
                PlasmaComponents.Button {
                    Layout.alignment: Qt.AlignRight
                    text: i18nd("lliurex-plasma-theme","Cancel")
                    implicitWidth: Kirigami.Units.gridUnit * 6
                    
                    onClicked: root.cancelRequested();
                }
                
            }
            
        }
    }
}
