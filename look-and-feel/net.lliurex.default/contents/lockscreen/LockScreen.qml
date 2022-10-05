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

import "." as Local

import net.lliurex.ui 1.0 as LLX

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.workspace.components 2.0 as PW
import org.kde.kirigami 2.16 as Kirigami

import org.kde.plasma.private.sessions 2.0

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15
import QtQuick.VirtualKeyboard 2.1


Item {
    id: root

     property bool debug: false
    property string notification
    signal clearPassword()

        // These are magical properties that kscreenlocker looks for
    property bool viewVisible: false
    property bool suspendToRamSupported: false
    property bool suspendToDiskSupported: false

    // These are magical signals that kscreenlocker looks for
    signal suspendToDisk()
    signal suspendToRam()

    anchors.fill: parent
    property int lockCount : 0
    property Item topWindow: welcomeWindow
    property var face: {
        if (kscreenlocker_userImage.toString().length==0) {
                return "user-identity";
            }
            else {
                return kscreenlocker_userImage;
            }
    }
    
    SessionManagement {
        id: sessionManagement
    }

    Connections {
        target: sessionManagement
        function onAboutToSuspend() {
            
        }
    }

    SessionsModel {
        id: sessionsModel
        showNewSessionEntry: false
    }

    PlasmaCore.DataSource {
        id: keystateSource
        engine: "keystate"
        connectedSources: "Caps Lock"
    }

    Connections {
        target: authenticator

        function onFailed() {
            message.text=i18nd("lliurex-plasma-theme","Login failed");
            txtPass.enabled=true;
            btnUnlock.enabled=true;
        }

        function onSucceeded() {
            Qt.quit();
        }

        function onInfoMessage(msg) {
            message.text="Info:"+msg;
        }

        function onErrorMessage(msg) {
            message.text=i18nd("lliurex-plasma-theme","Error:")+msg;
            txtPass.enabled=true;
            btnUnlock.enabled=true;
        }

        function onPrompt(msg) {
            authenticator.respond(txtPass.text);
        }

        function onPromptForSecret(msg) {
            authenticator.respond(txtPass.text);
        }
    }

    Keys.onEscapePressed: {
        root.topWindow = unlockWindow;
        root.lockCount=0;
        timer.running=true;
    }
    
    Keys.onPressed: {
        if (root.topWindow == unlockWindow) {
            root.lockCount = 0;
        }
    }
    
    LLX.Background {
        anchors.fill: parent
    }

    InputPanel {
        id: vkey
        width: {
            return ((root.height - (root.topWindow.height + root.topWindow.y) )* 3.2) *0.95;
        }
        anchors.bottom : parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 8

        active: chkVkey.checked

        visible: active && Qt.inputMethod.visible
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        
        onPositionChanged: {
            root.lockCount=0;

            if (root.topWindow == welcomeWindow) {
                root.topWindow = unlockWindow;
                timer.running=true;
            }
        }
        
    }
    
    Timer {
        id: timer
        running:false
        interval: 1000
        repeat:true
        
        onTriggered: {
            root.lockCount+=1;
            if (root.lockCount>=20) {
                
                root.topWindow = welcomeWindow;
                running=false;
                Qt.inputMethod.hide();
            }
        }
    }
      
    LLX.Window {
        id: welcomeWindow
        title: i18nd("lliurex-plasma-theme","Session locked")
        width:320
        height:320
        anchors.centerIn:parent
        visible: root.topWindow == this
        
        ColumnLayout {
            anchors.fill: parent

            ColumnLayout {
                Layout.topMargin: 12
                Layout.bottomMargin: 12
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                PlasmaCore.IconItem {
                    Layout.alignment: Qt.AlignHCenter

                    source: face
                    implicitWidth: 64
                    implicitHeight:64
                }

                PlasmaComponents.Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: kscreenlocker_userName
                }
            }

            Local.DateTime {
                visible: config.showClock
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth:true
            }

            Local.AnalogClock {
                visible: !config.showClock
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

        }
    }
    
    LLX.Window {
        id: sessionWindow
        title: i18nd("lliurex-plasma-theme","Sessions")
        width: 320
        height: 480
        
        anchors.centerIn:parent
        visible: root.topWindow == this
        
        ColumnLayout {
            anchors.fill: parent
            
            ListView {
                id: sessionsView
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth:true
                height: 400
                model: sessionsModel
                highlightFollowsCurrentItem: true
                focus: true

                highlight:
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#bfdcf1"
                        border.color: "#3daee9"
                        border.width: 1
                        radius: 3
                    }
                
                delegate: Item {
                    id: item
                    width: parent.width
                    height: 64

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                                sessionsView.currentIndex = index
                            }
                    }

                    RowLayout {
                        anchors.fill: parent

                        PlasmaCore.IconItem {
                            Layout.alignment: Qt.AlignLeft
                            Layout.margins: 4
                            implicitWidth: 48
                            implicitHeight: 48

                            source: {
                                if (model.isTty) {
                                    return "utilities-terminal";
                                }
                                if (model.icon=="") {
                                    return "user-identity";
                                }
                                return model.icon;
                            }
                        }

                        PlasmaComponents.Label {
                            Layout.alignment: Qt.AlignLeft
                            text: model.name
                        }
                        /*
                        PlasmaComponents.Label {
                            text: model.vtNumber
                        }

                        PlasmaComponents.Label {
                            text: model.displayNumber
                        }
                        */

                        PlasmaComponents.Button {
                            text: i18nd("lliurex-plasma-theme","Switch")
                            Layout.alignment: Qt.AlignRight
                            Layout.margins: 4
                            implicitWidth: 64
                            enabled: sessionsView.currentIndex==index

                            onClicked: {
                                root.topWindow = welcomeWindow;
                                sessionsModel.switchUser(model.vtNumber);
                            }
                        }
                    }
                }
            }
            
            PlasmaComponents.Button {
                text: i18nd("lliurex-plasma-theme","Cancel")
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                implicitWidth: PlasmaCore.Units.gridUnit * 6
                
                onClicked: {
                    root.topWindow=unlockWindow;
                }
            }
        }
    }
    
    LLX.Window {
        id: unlockWindow
        title: i18nd("lliurex-plasma-theme","Unlock")
        width:320
        height:360
        visible: root.topWindow == this

        anchors.horizontalCenter: parent.horizontalCenter
        y: {
            if (vkey.active) {
                return (parent.height*0.3)-(height*0.5);
            }
            else {
                return (parent.height*0.5)-(height*0.5);
            }
        }
        
        onVisibleChanged: {
            txtPass.text = "";
            txtPass.focus = true;
        }
        
        ColumnLayout {
            anchors.fill: parent

            ColumnLayout {
                Layout.topMargin: 12
                Layout.bottomMargin: 12
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                PlasmaCore.IconItem {
                    Layout.alignment: Qt.AlignHCenter

                    source: face
                    implicitWidth: 64
                    implicitHeight:64
                }

                PlasmaComponents.Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: kscreenlocker_userName
                }
            }

            RowLayout {

                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.minimumHeight: 22
                height:22

                PlasmaCore.IconItem {
                    visible: keystateSource.data["Caps Lock"]["Locked"]
                    Layout.alignment: Qt.AlignLeft
                    implicitWidth: 22
                    implicitHeight: 22

                    source: "data-warning"
                }

                PlasmaComponents.Label {
                    visible: keystateSource.data["Caps Lock"]["Locked"]
                    Layout.alignment: Qt.AlignHCenter
                    text: i18nd("lliurex-plasma-theme","Caps lock")
                }
            }

            PlasmaComponents.TextField {
                id: txtPass
                implicitWidth: 200
                Layout.alignment: Qt.AlignHCenter
                echoMode: TextInput.Password
                placeholderText: i18nd("lliurex-plasma-theme","Password")
                focus: true

                Keys.onReturnPressed: {
                    txtPass.enabled=false;
                    btnUnlock.enabled=false;
                    authenticator.tryUnlock();
                }

                Keys.onPressed: {
                    root.lockCount=0;
                }
            }
            
            PlasmaComponents.Button {
                id: btnUnlock
                text: i18nd("lliurex-plasma-theme","Unlock")
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: PlasmaCore.Units.gridUnit * 6
                
                onClicked: {
                    btnUnlock.enabled=false;
                    txtPass.enabled=false;
                    authenticator.tryUnlock();
                }
            }
            
            PlasmaComponents.Label {
                id: message
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                color: PlasmaCore.Theme.negativeTextColor
                width: PlasmaCore.Units.gridUnit * 16
            }
            
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                spacing: 16

                PlasmaComponents.Button {
                    text: i18nd("lliurex-plasma-theme","Change user")
                    Layout.alignment: Qt.AlignLeft
                    icon.name:"system-switch-user"
                    icon.width:24
                    icon.height:24

                    display: QQC2.AbstractButton.TextBesideIcon
                    visible: sessionsModel.canStartNewSession && sessionsModel.canSwitchUser
                    onClicked: {
                        if (sessionsModel.count === 0) {
                            sessionsModel.startNewSession(true);
                        }
                        else {
                            root.topWindow=sessionWindow;
                        }
                    }
                }

                PlasmaComponents.Button {
                    id: chkVkey
                    Layout.alignment: Qt.AlignRight
                    icon.name:"input-keyboard-virtual"
                    checkable: true
                    display: QQC2.AbstractButton.IconOnly
                    icon.width:24
                    icon.height:24

                    onClicked: {
                        txtPass.forceActiveFocus();
                    }
                }
            }
            
        }
    }
}
