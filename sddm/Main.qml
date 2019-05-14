import QtQuick 2.0
import QtQuick.Controls 2.0
import SddmComponents 2.0 as Sddm
import "lliurex" as Lliurex


Rectangle {
    
    width: 640
    height: 480
    
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    Sddm.TextConstants { id: textConstants }
    
    Connections {
        target: sddm
        onLoginSucceeded: {
            message.text="Yo man"
        }
        onLoginFailed: {
            message.text="Login fail"
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
    

     Timer {
        id: timerClock
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            txtDate.text = Qt.formatDateTime(new Date(), "ddd d MMMM yyyy");
            txtClock.text = Qt.formatDateTime(new Date(), "HH:mm");
        }
    }

    Column {
        spacing: 10
        /*
        anchors.right:parent.right
        anchors.rightMargin: 40
        */
        anchors.verticalCenter: parent.verticalCenter
        x: parent.width*0.7
        
        Text {
            id: txtHostname
            text: "server"
            anchors.horizontalCenter: parent.horizontalCenter
            
            color:"white"
            font.pointSize: 32
            style:Text.Outline
            styleColor: "#40000000"

            
        }
        
        Text {
            id: txtDate
            text: "--"
            anchors.horizontalCenter: parent.horizontalCenter
            
            color:"white"
            font.pointSize: 32
            style:Text.Outline
            styleColor: "#40000000"

            
        }
        
        Text {
            id: txtClock
            text: "--"
            anchors.horizontalCenter: parent.horizontalCenter
            
            color:"white"
            font.pointSize: 96
            style:Text.Outline
            styleColor: "#40000000"

        }
    
    }
    
    Image {
        source: "images/shutdown.svg"
        
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin:40
        anchors.bottomMargin: 40
        
        MouseArea {
            anchors.fill: parent
            
            acceptedButtons: Qt.LeftButton
            
            onClicked: {
                loginFrame.visible=false
                shutdownFrame.visible=true
            }
        }
    }
    
    // login frame
    Item {
        id: loginFrame
        width: childrenRect.width+40
        height: childrenRect.height+40
        anchors.left: parent.left
        anchors.leftMargin:200
        anchors.verticalCenter: parent.verticalCenter
        
        Rectangle {
            color: "#40000000"
            
            width: loginTop.width+5
            height: loginTop.height+5
            radius:5
            
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        
        
        Rectangle {
            
            id: loginTop
            color: "#eff0f1"
            radius: 5
            width: childrenRect.width+40
            height: childrenRect.height+40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            
            
            Column {
                
                spacing: 16
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
                
                Text {
                    id: message
                    color: "red"
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Lliurex.Button {
                    text: "Login"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    onClicked: {
                        sddm.login(txtUser.text,txtPass.text,cmbSession.currentIndex)
                    }
                }
                
                ComboBox {
                    flat: true
                    anchors.left:parent.left
                    model: sessionModel
                    currentIndex: sessionModel.lastIndex
                    textRole: "name"
                    
                    indicator: {}
                }
                
            }
        }
    }
    
    
    // Shutdown frame
    Item {
        id: shutdownFrame
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
            
         Rectangle {
            color: "#40000000"
            
            width: shutdownTop.width+5
            height: shutdownTop.height+5
            radius:5
            
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        
        Rectangle {
            id: shutdownTop
            color: "#eff0f1"
            width: childrenRect.width+40
            height: childrenRect.height+40
            radius: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            
            Column {
                spacing: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                
                Row {
                    spacing: 10
                    
                    Lliurex.Button {
                        text: "Power Off"
                        enabled:sddm.canPowerOff
                        
                        onClicked: {
                            sddm.powerOff()
                        }
                    }
                    
                    Lliurex.Button {
                        text: "Reboot"
                        enabled: sddm.canReboot
                        onClicked: {
                            sddm.reboot()
                        }
                    }
                    
                    Lliurex.Button {
                        text: "Suspend"
                        enabled: sddm.canSuspend
                        onClicked: {
                            sddm.suspend()
                        }
                    }
                }
                
                Lliurex.Button {
                    text: "Cancel"
                    anchors.right: parent.right
                    
                    onClicked: {
                        loginFrame.visible=true
                        shutdownFrame.visible=false
                    }
                }
                
            }
            
        }
    }
    
    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function(myxhr) {
            return function() {
                if(myxhr.readyState === 4) { callback(myxhr); }
            }
        })(xhr);

        xhr.open("GET", url);
        xhr.send();
    }

    Component.onCompleted: {
        request("http://192.168.122.216", function (o) {
            if (o.status === 200)
            {
                console.log("Connected to server!");
            }
            else
            {
                console.log("Some error has occurred");
                message.text="No connection to server"
            }
        });
    }
}
