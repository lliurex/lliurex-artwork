import net.lliurex.ui 1.0 as LLX

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.workspace.components 2.0 as PW
import org.kde.kcoreaddons 1.0 as KCoreAddons

import org.kde.plasma.private.sessions 2.0

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
    
    Timer {
        id: timer
        running:true
        interval: 1000
        repeat:true
        
        onTriggered: {
            root.timeRemaining-=1;
            
            if (root.timeRemaining == 0) {
                repeat = false;
            }
        }
    }
    
    LLX.Background {
        anchors.fill: parent
    }
    
    LLX.Window {
        id: logoutWIndow
        title: ""
        width:480
        height:320
        anchors.centerIn:parent
        //visible: root.topWindow == this
        
        ColumnLayout {
            anchors.fill: parent
            
            PlasmaCore.IconItem {
                Layout.alignment: Qt.AlignHCenter
                
                id: faceIcon
                source: kuser.faceIconUrl
                //visible: (face.status == Image.Error || face.status == Image.Null)
                implicitWidth: 64
                implicitHeight:64
                //anchors.fill: parent
                //anchors.margins: PlasmaCore.Units.gridUnit * 0.5 // because mockup says so...
                //colorGroup: PlasmaCore.ColorScope.colorGroup
            }
            
            QQC2.Label {
                Layout.alignment: Qt.AlignHCenter
                text: kuser.fullName
            }
            
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-sddm-theme","Suspend")
                    
                    implicitWidth: PlasmaCore.Units.gridUnit*6
                    icon.name: "system-suspend"
                    display: QQC2.AbstractButton.TextUnderIcon
                    
                    onClicked: root.suspendRequested(2);
                    
                }
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-sddm-theme","Power off")
                    
                    implicitWidth: PlasmaCore.Units.gridUnit*6
                    icon.name: "system-shutdown"
                    display: QQC2.AbstractButton.TextUnderIcon
                    focus: sdtype == ShutdownType.ShutdownTypeHalt
                    
                    onClicked: root.haltRequested();
                    
                }
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-sddm-theme","Reboot")
                    
                    implicitWidth: PlasmaCore.Units.gridUnit*6
                    icon.name: "system-reboot"
                    display: QQC2.AbstractButton.TextUnderIcon
                    focus: sdtype == ShutdownType.ShutdownTypeReboot
                    
                    onClicked: root.rebootRequested();
                    
                }
                
                PlasmaComponents.Button {
                    text: i18nd("lliurex-sddm-theme","Log out")
                    
                    implicitWidth: PlasmaCore.Units.gridUnit*6
                    icon.name: "system-log-out"
                    display: QQC2.AbstractButton.TextUnderIcon
                    focus: sdtype == ShutdownType.ShutdownTypeNone
                    
                    onClicked: root.logoutRequested();
                    
                }
            }
            
            QQC2.ProgressBar {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                value: root.timeRemaining/20.0
                
                Behavior on value { 
                    PropertyAnimation {
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            
            PlasmaComponents.Button {
                Layout.alignment: Qt.AlignRight
                text: i18nd("lliurex-sddm-theme","Cancel")
                implicitWidth: PlasmaCore.Units.gridUnit * 6
                
                onClicked: root.cancelRequested();
            }
                
            
            
        }
    }
}
