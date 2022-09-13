/*
    Lliurex look and feel

    Copyright (C) 2022  Enrique Medina Gremaldos <quiqueiii@gmail.com>

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

import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.12 as Kirigami
import org.kde.kcm 1.5 as KCM

Kirigami.FormLayout {

    twinFormLayouts: parentLayout

    property alias cfg_showClock: showClock.checked
    property bool cfg_showClockDefault: true

    QQC2.CheckBox {
        id: showClock
        Kirigami.FormData.label: i18nd("lliurex-plasma-theme","Clock")
        text: i18nd("lliurex-plasma-theme","Display a date & time clock")
        KCM.SettingHighlighter {
            highlight: cfg_showClockDefault != cfg_showClock
        }
    }
}
