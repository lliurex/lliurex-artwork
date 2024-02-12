/*
    Lliurex wallpaper

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

import net.lliurex.ui 1.0 as LLX
import net.lliurex.ui.noise 1.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kcoreaddons 1.0 as KCoreAddons

import QtQuick 2.6
import QtQuick.Controls 2.6 as QQC2
import QtQuick.Layouts 1.15

Rectangle
{
    id: root
    color: "#2980b9"
    anchors.fill:parent

    KCoreAddons.KUser
    {
        id: kuser
    }

    LLX.Background
    {
        anchors.fill: parent
        isWallpaper: true
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

