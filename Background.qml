import Quickshell
import Quickshell.Wayland
import QtQuick
import Qt5Compat.GraphicalEffects

Variants {
    model: Quickshell.screens
    property bool overview: false
    required property string picture

    delegate: Component {
        PanelWindow {
            required property var modelData
            screen: modelData

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.namespace: overview ? "dots.overview-background" : "dots.background"

            implicitWidth: screen.width
            implicitHeight: screen.height

            Image {
                id: background
                anchors.fill: parent
                clip: true
                fillMode: Image.PreserveAspectCrop

                source: picture
            }

            FastBlur {
                anchors.fill: background
                source: background
                radius: 64
                visible: overview
            }
        }
    }
}
