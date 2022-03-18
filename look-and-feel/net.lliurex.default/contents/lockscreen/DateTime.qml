import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15

Item {
    id: root
    
    property string date;
    property string time;

    height:PlasmaCore.Theme.defaultFont.pointSize * 8
    
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
        anchors.fill:parent

        PlasmaComponents.Label {
            Layout.alignment: Qt.AlignHCenter
            text:root.date
            font.pointSize:PlasmaCore.Theme.defaultFont.pointSize * 1.4
        }

        PlasmaComponents.Label {
            Layout.alignment: Qt.AlignHCenter
            text:root.time
            font.pointSize:PlasmaCore.Theme.defaultFont.pointSize * 1.6
        }
    }

}
