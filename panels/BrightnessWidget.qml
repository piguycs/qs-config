import QtQuick

import qs.data

Item {
    id: root

    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight
    visible: Brightness.available

    Text {
        id: label
        text: "󰃠 " + Brightness.percentage + "%"
        color: "#C5C9C5"
        font.family: "Iosevka Nerd Font Propo"
        font.pointSize: 12
    }

    MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
            if (wheel.angleDelta.y !== 0)
                Brightness.adjustBrightness(wheel.angleDelta.y > 0 ? 5 : -5);
        }
    }
}
