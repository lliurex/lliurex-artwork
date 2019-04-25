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
    
    TextBox {
        
    }
    
    Component.onCompleted: {
        /*if (user_entry.text === "")
            user_entry.focus = true
        else
            pw_entry.focus = true*/
        pw_entry.focus = true
    }
}
