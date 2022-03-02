
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
            if (root.lockCount==20) {
                
                root.topWindow = welcomeWindow;
                running=false;
            }
        }
    }
    
    Timer {
            id: clock
            interval: 500
            running: true
            repeat: true
            
            onTriggered: {
                
                var date = Qt.formatDateTime(new Date(), "ddd d MMMM yyyy");
                var time = Qt.formatDateTime(new Date(), "HH:mm");
                
                labelClock.text=date+"\n"+time;
            }
        }
    
    LLX.Window {
        id: welcomeWindow
        title: i18nd("lliurex-plasma-theme","Session locked")
        width:320
        height:240
        anchors.centerIn:parent
        visible: root.topWindow == this
        
        ColumnLayout {
            anchors.fill: parent
            
            QQC2.Label {
                id: labelClock
                Layout.alignment: Qt.AlignHCenter
            }
            
            PlasmaCore.IconItem {
                Layout.alignment: Qt.AlignHCenter
                
                source: face
                implicitWidth: 64
                implicitHeight:64
            }
            
            QQC2.Label {
                Layout.alignment: Qt.AlignHCenter
                text: kscreenlocker_userName
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
                Layout.alignment: Qt.AlignHCenter
                height: 400
                model: sessionsModel
                
                delegate: ColumnLayout {
                    PlasmaComponents.Label {
                        text: model.name
                    }
                    
                    PlasmaCore.IconItem {
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
                        text: model.vtNumber
                    }
                    
                    PlasmaComponents.Label {
                        text: model.displayNumber
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
        height:320
        visible: root.topWindow == this
        anchors.centerIn:parent
        
        onVisibleChanged: {
            txtPass.text = "";
            txtPass.focus = true;
        }
        
        ColumnLayout {
            anchors.fill: parent
            
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
            
            PlasmaComponents.TextField {
                id: txtPass
                width: 200
                Layout.alignment: Qt.AlignHCenter
                echoMode: TextInput.Password
                placeholderText: i18nd("lliurex-plasma-theme","Password")
                
                Keys.onReturnPressed: {
                    authenticator.tryUnlock(txtPass.text)
                }
            }
            
            PlasmaComponents.Button {
                text: i18nd("lliurex-plasma-theme","Unlock")
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: PlasmaCore.Units.gridUnit * 6
                
                onClicked: {
                    authenticator.tryUnlock(txtPass.text)
                }
            }
            
            QQC2.Label {
                id: msg
                text:""
            }
            
            PlasmaComponents.Button {
                text: i18nd("lliurex-plasma-theme","Change user")
                icon.name:"system-switch-user"
                icon.width:24
                icon.height:24
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
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
            
            
        }
    }
}
