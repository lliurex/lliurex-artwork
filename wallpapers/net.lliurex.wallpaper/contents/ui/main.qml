/*
    Lliurex wallpaper

    Copyright (C) 2024  Enrique Medina Gremaldos <quique@necos.es>

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

import net.lliurex.ui 1.0 as LLX
import net.lliurex.ui.noise 1.0

import Edupals.Base 1.0 as Edupals

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15

Rectangle
{
    id: root
    color: wallpaper.configuration.Color
    anchors.fill:parent

    function computeDaylight()
    {
        const date = new Date();

        var h = date.getHours();

        if (h > 6 && h < 18 ) {
            var f =  ((17 - h) / 10);

            background.ambient = Math.sin(3.1416 * f);
        }
        else {
            background.ambient = 0;
        }

    }

    Component.onCompleted:
    {
        console.log(user.name);
        console.log(user.group);
        console.log(user.groups);

        const date = new Date();
        background.seed = (date.getDate() * 4) + date.getDay();
        console.log("seed:",background.seed);

        computeDaylight();

        var children = false;
        var admin = false;

        if (name == "alumnat") {
            children = true;
        }
        else {
            for (var n=0;n<user.groups.length;n++) {
                var group = user.groups[n];

                if (group.startsWith("ALU_PRI") || group.startsWith("ALU_ESO")) {
                    children = true;
                }

                if (group == "AdminSai") {
                    children = false;
                    admin = true;
                }

            }
        }

        if (children) {
            background.isWallpaper = true;
            background.rats = true;
        }
        else {
            if (admin) {
                background.isWallpaper = false;
                background.rats = false;
                background.baseColor = Qt.rgba(0.8,0.1,0.1,1.0);
            }
            else {
                background.isWallpaper = true;
                background.rats = false;
            }
        }
    }

    Edupals.User
    {
        id: user
    }

    LLX.Background
    {
        id: background
        anchors.fill: parent
        isWallpaper: true
        rats: true
        ambient: 0.3
    }

    Timer
    {
        interval: 1000 * 60
        running: true
        repeat: true

        onTriggered:
        {
            computeDaylight();
            background.requestPaint();
        }
    }

    Image
    {
        id: logo
        source: "media/logo.svg"
        smooth: true
        width: 512
        height: 128
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.top:parent.top
    }

    Image
    {
        id: gva
        source: "media/gva.svg"
        smooth: true
        width: 128
        height:128

        anchors.right:parent.right
        anchors.top:parent.top
    }
}

