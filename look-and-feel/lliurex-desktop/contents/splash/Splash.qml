/*
    Lliurex Splash

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

import QtQuick 2.1

Image {
    
    id: root
    source: "images/background.svg"

    property int stage

    onStageChanged: {
    }
    
    Image {
        id: isotype
        source: "images/isotype.svg"
        
        anchors.centerIn: parent
    }
    
    Image {
        id: logotype
        source: "images/logotype.svg"
        
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: isotype.bottom
    }
    
    Rectangle {
        id: progressbar
        color: "#65b0dc"
        height: 8
        y: parent.height-48
        x: 0
        width: (stage==0) ? 0: (parent.width*stage/6.0)
        Behavior on width { 
            PropertyAnimation {
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
    }
    
}