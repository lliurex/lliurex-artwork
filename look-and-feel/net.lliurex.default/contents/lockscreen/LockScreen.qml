
import net.lliurex.ui 1.0 as LLX

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.workspace.components 2.0 as PW

import org.kde.plasma.private.sessions 2.0

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15


Item {
    id: root
    focus: true
    anchors.fill: parent
    property int lockCount : 0
    property Item topWindow: welcomeWindow
    
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
    
    Connections {
        target: authenticator
        function onFailed() {
            msg.text="Failed";
        }
        function onGraceLockedChanged() {
            if (!authenticator.graceLocked) {
                txtPass.text="";
            }
        }
        function onMessage(message) {
            msg.text = message;
        }
        function onError(err) {
            msg.text = err;
        }
    }
    
    Keys.onEscapePressed: {
        root.topWindow = unlockWindow;
        root.lockCount=0;
        timer.running=true;
    }
    
    Keys.onPressed: {
        
    }
    
    LLX.Background {
        anchors.fill: parent
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        
        onPositionChanged: {
            root.lockCount=0;
        }
        
    }
    
    Timer {
        id: timer
        running:false
        interval: 1000
        repeat:true
        
        onTriggered: {
            root.lockCount+=1;
            console.log("tick ",root.lockCount);
            if (root.lockCount==10) {
                
                root.topWindow = welcomeWindow;
                running=false;
            }
        }
    }
    
    LLX.Window {
        id: welcomeWindow
        title: "Locked Screen"
        width:320
        height:240
        anchors.centerIn:parent
        visible: root.topWindow == this
        
        ColumnLayout {
            anchors.fill: parent
            
            QQC2.Label {
                Layout.alignment: Qt.AlignHCenter
                text: "Locked by quique"
            }
        }
    }
    
    LLX.Window {
        id: unlockWindow
        title: "Unlock"
        width:320
        height:320
        visible: root.topWindow == this
        anchors.centerIn:parent
        
        ColumnLayout {
            anchors.fill: parent
            
            PlasmaCore.IconItem {
                Layout.alignment: Qt.AlignHCenter
                
                id: faceIcon
                source: kscreenlocker_userImage
                implicitWidth: 64
                implicitHeight:64
            }
            
            PlasmaComponents.Label {
                Layout.alignment: Qt.AlignHCenter
                text: kscreenlocker_userName
            }
            
            PlasmaComponents.TextField {
                id: txtPass
                width: 200
                Layout.alignment: Qt.AlignHCenter
                echoMode: TextInput.Password
                placeholderText: "password"
            }
            
            PlasmaComponents.Button {
                text: "Unlock"
                Layout.alignment: Qt.AlignHCenter
                
                onClicked: {
                    authenticator.tryUnlock(txtPass.text)
                }
            }
            
            PlasmaComponents.Button {
                text: "Change user"
                Layout.alignment: Qt.AlignHCenter
                
                onClicked: {
                    sessionsModel.startNewSession(true);
                }
            }
            
            QQC2.Label {
                id: msg
                text:""
            }
        }
    }
}
