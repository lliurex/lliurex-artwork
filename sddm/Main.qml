import QtQuick 2.0
import QtQuick.Controls 2.0
import SddmComponents 2.0 as Sddm


Rectangle {
    
    width: 640
    height: 480
    
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    Sddm.TextConstants { id: textConstants }
    
    Connections {
        target: sddm
        onLoginSucceeded: {}
        onLoginFailed: {
            txtPass.text = ""
            txtPass.focus = true
            
            txtPass.borderColor="red"
        }
    }
    
    Sddm.Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }
    
    //top frame
    Rectangle {
        //color: "#eff0f1"
        color: "white"
        width: parent.width
        height: 48
        
         Timer {
            id: timerClock
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                txtClock.text = Qt.formatDateTime(new Date(), "HH:mm    ddd d MMMM yyyy");
            }
        }

        Text {
            id: txtHostname
            text: sddm.hostname
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
        
        Text {
            id: txtClock
            text: "--"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        
        Row {
            spacing: 10
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
            
            ComboBox {
                id: cmbSession
                model: sessionModel
                currentIndex: sessionModel.lastIndex
                textRole: "name"
            }
            Button {
                text: "Power off"
                
                onClicked: {
                    loginFrame.visible=false
                    shutdownFrame.visible=true
                }
            }
            
        }
    }
    
    // login frame
    Rectangle {
        
        id: loginFrame
        color: "white"
        width: childrenRect.width+40
        height: childrenRect.height+40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        
        Column {
            
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            
            Image {
                id: imgFace
            }
            
            TextField {
                id: txtUser
                width: 164
                placeholderText: "User name"
                
            }
            TextField {
                id: txtPass
                width: 164
                echoMode: TextInput.Password
                placeholderText: "Password"
            }
            
            Button {
                text: "Login"
                anchors.horizontalCenter: parent.horizontalCenter
                
                onClicked: {
                    sddm.login(txtUser.text,txtPass.text,cmbSession.currentIndex)
                }
            }
        }
    }
    
    // Shutdown frame
    Rectangle {
        id: shutdownFrame
        visible: false
        color: "white"
        width: childrenRect.width+40
        height: childrenRect.height+40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        
        Column {
            spacing: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            
            Row {
                spacing: 10
                
                Button {
                    text: "Power Off"
                    enabled:sddm.canPowerOff()
                }
                
                Button {
                    text: "Reboot"
                    enabled: sddm.canReboot()
                }
                
                Button {
                    text: "Suspend"
                    enabled: sddm.canSuspend()
                }
            }
            
            Button {
                text: "Cancel"
                anchors.right: parent.right
                
                onClicked: {
                    loginFrame.visible=true
                    shutdownFrame.visible=false
                }
            }
            
        }
        
    }
    
    Component.onCompleted: {
    }
}
