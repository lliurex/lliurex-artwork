import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent
    
    property string date;
    property string time;
    
    Timer {
        id: clock
        interval: 500
        running: root.enabled
        repeat: true
        
        onTriggered: {
            
            date = Qt.formatDateTime(new Date(), "ddd d MMMM yyyy");
            time = Qt.formatDateTime(new Date(), "HH:mm");
            
        }
    }
    
    ColumnLayout {
        width: parent.width
        height: PlasmaCore.Theme.defaultFont.pointSize * 4
        
        PlasmaComponents.Label {
            Layout.alignment: Qt.AlignHCenter
            text:root.date
            font.pointSize:PlasmaCore.Theme.defaultFont.pointSize * 1.5
        }
        
        PlasmaComponents.Label {
            Layout.alignment: Qt.AlignHCenter
            text:root.time
            font.pointSize:PlasmaCore.Theme.defaultFont.pointSize * 1.5
        }
        
    }
}
