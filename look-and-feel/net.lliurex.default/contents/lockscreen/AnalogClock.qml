import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15

Item {
    id: root
    width: 100
    height: 100

    property int hours: 0
    property int minutes: 0
    property int seconds: 0

    Timer {
        interval: 1000
        running: true
        triggeredOnStart: true
        repeat: true

        onTriggered: {

            var time = new Date();
            root.hours = time.getHours();
            root.minutes = time.getMinutes();
            root.seconds = time.getSeconds();
            if (root.hours>12) {
                root.hours = root.hours - 12;
            }
            canvas.requestPaint();

        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.fillStyle = PlasmaCore.Theme.backgroundColor;

            ctx.fillRect(0, 0, width, height);

            var min = width;

            if (height<min) {
                min = height;
            }

            var cx = width/2;
            var cy = height/2;

            var to = (6/4*Math.PI);
            var tp = (2.0*Math.PI);

            //ctx.rotate(270 * Math.PI / 180);

            ctx.fillStyle = Qt.rgba(1,1,1,1);
            ctx.beginPath();
            ctx.arc(cx, cy, (min/2) - 2, 0, 2 * Math.PI);
            ctx.fill();

            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.arc(cx, cy, (min/2) - 2, 0, 2 * Math.PI);
            ctx.stroke();

            ctx.fillStyle = PlasmaCore.Theme.highlightColor;

            for (var n=0;n<12;n++) {

                var th = (n/12.0);
                var px = Math.cos(to+(tp*th)) * (0.80*min/2);
                var py = Math.sin(to+(tp*th)) * (0.80*min/2);

                ctx.beginPath();
                ctx.arc(cx+px, cy+py, 4, 0, 2 * Math.PI);
                ctx.fill();

                if (n==0) {
                    ctx.fillStyle = Qt.rgba(0.8,0.8,0.8,1);
                }
            }

            ctx.lineWidth = 1;
            ctx.beginPath();
            var ts = (root.seconds/60.0);
            var px = -Math.cos(to+(tp*ts)) * (0.1*min/2);
            var py = -Math.sin(to+(tp*ts)) * (0.1*min/2);
            ctx.moveTo(cx+px,cy+py);
            px = Math.cos(to+(tp*ts)) * (0.9*min/2);
            py = Math.sin(to+(tp*ts)) * (0.9*min/2);
            ctx.lineTo(cx+px,cy+py);
            ctx.stroke();

            ctx.beginPath();
            var tm = (root.minutes/60.0);
            px = -Math.cos(to+(tp*tm)) * (0.1*min/2);
            py = -Math.sin(to+(tp*tm)) * (0.1*min/2);
            ctx.moveTo(cx+px,cy+py);
            px = Math.cos(to+(tp*tm)) * (0.8*min/2);
            py = Math.sin(to+(tp*tm)) * (0.8*min/2);
            ctx.lineTo(cx+px,cy+py);
            ctx.lineWidth = 2;
            ctx.stroke();

            ctx.beginPath();
            var th = ((root.hours+tm)/12.0);
            px = -Math.cos(to+(tp*th)) * (0.1*min/2);
            py = -Math.sin(to+(tp*th)) * (0.1*min/2);
            ctx.moveTo(cx+px,cy+py);
            px = Math.cos(to+(tp*th)) * (0.6*min/2);
            py = Math.sin(to+(tp*th)) * (0.6*min/2);
            ctx.lineTo(cx+px,cy+py);
            ctx.stroke();

        }
    }

}
