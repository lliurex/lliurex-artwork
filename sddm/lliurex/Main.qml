/*
    Lliurex Sddm theme

    Copyright (C) 2019  Enrique Medina Gremaldos <quiqueiii@gmail.com>

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

import QtQuick 2.0
import QtQuick.Controls 2.0
import SddmComponents 2.0 as Sddm
import "ui" as Lliurex

Rectangle {
    
    width: 640
    height: 480
    
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    Sddm.TextConstants { id: textConstants }
    
    /* catch login events */
    Connections {
        target: sddm
        
        onLoginSucceeded: {
            message.text=""
        }
        
        onLoginFailed: {
            message.text=qsTr("Login failed")
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
    
    /* Clock refresh timer */
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
    
    /* login frame */
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
                    placeholderText: qsTr("User name")
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                TextField {
                    id: txtPass
                    width: 200
                    echoMode: TextInput.Password
                    placeholderText: qsTr("Password")
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    Keys.onReturnPressed: {
                        sddm.login(txtUser.text,txtPass.text,cmbSession.currentIndex)
                    }
                    
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
                    text: qsTr("Login");
                    minWidth: 200
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    onClicked: {
                        sddm.login(txtUser.text,txtPass.text,cmbSession.currentIndex)
                    }
                }
                
                ComboBox {
                    id: cmbSession
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
    
    /* Shutdown frame */
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
                        text: qsTr("Power off")
                        enabled:sddm.canPowerOff
                        onClicked: {
                            sddm.powerOff()
                        }
                    }
                    
                    Lliurex.Button {
                        text: qsTr("Reboot")
                        enabled: sddm.canReboot
                        onClicked: {
                            sddm.reboot()
                        }
                    }
                    
                    Lliurex.Button {
                        text: qsTr("Suspend")
                        enabled: sddm.canSuspend
                        onClicked: {
                            sddm.suspend()
                        }
                    }
                    
                    Lliurex.Button {
                        text: qsTr("Hibernate")
                        enabled: sddm.canHibernate
                        onClicked: {
                            sddm.hibernate()
                        }
                    }
                }

                Lliurex.Button {
                    text: qsTr("Cancel")
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
        request("http://server", function (o) {
            if (o.status === 200) {
                console.log("Connected to server!");
            }
            else {
                console.log("Some error has occurred");
                message.text=qsTr("No connection to server")
            }
        });
    }
}