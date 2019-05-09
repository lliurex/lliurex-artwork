import QtQuick 2.0
import QtQuick.Controls 2.0

//import QtQuick.Controls.Styles.Breeze 1.0
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
        color: "#eff0f1"
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
            /*
            ComboBox {
                id: cmbSession
                model: sessionModel
                currentIndex: sessionModel.lastIndex
                textRole: "name"
            }*/
            Button {
                icon.source: "images/shutdown.svg"
                width:32
                height:32
                
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
        color: "#eff0f1"
        radius: 5
        width: childrenRect.width+40
        height: childrenRect.height+40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        
        Column {
            
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            
            Image {
                source: "images/lliurex.svg"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Rectangle {
                color: "#7f8c8d"
                height: 5
                width: 320
            }
            
            TextField {
                id: txtUser
                width: 200
                placeholderText: "User name"
                anchors.horizontalCenter: parent.horizontalCenter
                
            }
            
            TextField {
                id: txtPass
                width: 200
                echoMode: TextInput.Password
                placeholderText: "Password"
                anchors.horizontalCenter: parent.horizontalCenter
                
                Image {
                    source: "images/upcase.svg"
                    anchors.right: parent.right
                    anchors.rightMargin:5
                    anchors.verticalCenter: parent.verticalCenter
                    
                    visible: keyboard.capsLock
                }
            }
            
            Button {
                text: "Login"
                anchors.horizontalCenter: parent.horizontalCenter
                
                onClicked: {
                    sddm.login(txtUser.text,txtPass.text,cmbSession.currentIndex)
                }
            }
            
            Button {
                icon.source: "images/settings.svg"
                anchors.right : parent.right
                
                width: 32
                height: 32
                
                onClicked: {
                }
            }
            
        }
    }
    
    // Shutdown frame
    Rectangle {
        id: shutdownFrame
        visible: false
        color: "#eff0f1"
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
                    
                    onClicked: {
                        sddm.powerOff()
                    }
                }
                
                Button {
                    text: "Reboot"
                    enabled: sddm.canReboot()
                    onClicked: {
                        sddm.reboot()
                    }
                }
                
                Button {
                    text: "Suspend"
                    enabled: sddm.canSuspend()
                    onClicked: {
                        sddm.suspend()
                    }
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
