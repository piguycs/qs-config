import Quickshell
import QtQuick

import qs.data

Item {
    id: root

    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight
    visible: Audio.available

    Text {
        id: label
        text: (Audio.muted ? "󰖁" : Audio.volume > 0.5 ? "󰕾" : Audio.volume > 0 ? "󰖀" : "󰕿")
              + " " + Math.round(Audio.volume * 100) + "%"
        color: "#C5C9C5"
        font.family: "Iosevka Nerd Font Propo"
        font.pointSize: 12
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
            if (mouse.button === Qt.RightButton)
                Quickshell.execDetached(["pavucontrol"]);
            else if (mouse.button === Qt.LeftButton)
                Audio.toggleMuted();
        }
        onWheel: wheel => {
            if (wheel.angleDelta.y !== 0)
                Audio.adjustVolume(wheel.angleDelta.y > 0 ? 0.05 : -0.05);
        }
    }
}
