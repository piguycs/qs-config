pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Shared brightness source backed by brightnessctl.
Singleton {
    id: root

    property bool available: false
    property int percentage: 0
    property string device: ""

    Process {
        id: query
        command: ["brightnessctl", "-m"]
        stdout: StdioCollector {
            onStreamFinished: {
                const fields = text.trim().split(",");
                const percent = fields.find(field => field.endsWith("%"));
                const value = parseInt(percent, 10);
                if (!isNaN(value)) {
                    root.device = fields[0];
                    root.percentage = value;
                    root.available = true;
                }
            }
        }
    }

    Process {
        id: watch
        command: ["inotifywait", "-m", "-q", "-e", "modify", "/sys/class/backlight/" + root.device + "/brightness"]
        running: root.device !== ""
        stdout: SplitParser {
            onRead: root.refresh()
        }
    }

    Process {
        id: adjust
        onExited: root.refresh()
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }

    function refresh() {
        if (!query.running)
            query.running = true;
    }

    function adjustBrightness(delta: int) {
        if (!available)
            return;

        percentage = Math.max(0, Math.min(100, percentage + delta));
        adjust.exec(["brightnessctl", "set", Math.abs(delta) + "%" + (delta > 0 ? "+" : "-")]);
    }
}
