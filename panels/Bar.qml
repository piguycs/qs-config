import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import qs.data

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            WlrLayershell.namespace: "dots.bar"
            WlrLayershell.layer: WlrLayer.Bottom

            anchors {
                top: true
                left: true
                right: true
            }

            color: "transparent"
            height: 56

            Rectangle {
                anchors {
                    fill: parent

                    leftMargin: 10
                    rightMargin: 10
                    topMargin: 10
                }

                color: "#1F1F28"

                RowLayout {
                    anchors.margins: 10
                    anchors.fill: parent

                    Text {
                        text: "HELLO"
                        color: "white"
                    }

                    Item { Layout.fillWidth: true }

                    BrightnessWidget {}

                    Item { Layout.preferredWidth: 3 }

                    VolumeWidget {}

                    Item { Layout.preferredWidth: 3 }

                    Text {
                        text: (Battery.charging ? "󰢟 " : "󰂎 ") + Battery.percentage + "%"
                        color: Battery.critical ? "#FF5555" : "#C5C9C5"
                        font.family: "Iosevka Nerd Font Propo"
                        font.pointSize: 12
                        visible: Battery.available
                    }

                    Item { Layout.preferredWidth: 3 }

                    TimeWidget {}
                }
            }
        }
    }
}
