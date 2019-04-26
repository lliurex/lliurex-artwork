import QtQuick 2.0
import SddmComponents 2.0


Rectangle {
    
    width: 640
    height: 480
    
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    TextConstants { id: textConstants }
    
    Connections {
        target: sddm
        onLoginSucceeded: {}
        onLoginFailed: {
            pw_entry.text = ""
            pw_entry.focus = true
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
        }
    }
    
    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }
    
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        
        Row {
            spacing: 20
            anchors.right: parent.right
            
            Text {
                text: "User"
            }
            TextBox {
                id: txtuser
                width: 164
            }
        }
        
        Row {
            spacing: 20
            anchors.right: parent.right
            
            Text {
                text: "Password"
            }
            PasswordBox {
                id: txtpass
                width: 164
            }
        }
        
        Button {
            text: "Login"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#eff0f1"
            activeColor: "#eff0f1"
            pressedColor: "#93cee9"
            textColor: "#000000"
        }
    }
    
    Row {
        spacing: 20
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        
        Text {
            text: "Session"
        }
        
        ComboBox {
            
        }
        
    }
    
    Component.onCompleted: {
        /*if (user_entry.text === "")
            user_entry.focus = true
        else
            pw_entry.focus = true*/
        pw_entry.focus = true
    }
}
