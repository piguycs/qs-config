pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Shared brightness source backed by brightnessctl.
Singleton {
    id: root

    property bool available: false
    property int percentage: 0

    Process {
        id: query
        command: ["brightnessctl", "-m"]
        stdout: StdioCollector {
            onStreamFinished: {
                const percent = text.trim().split(",").find(field => field.endsWith("%"));
                const value = parseInt(percent, 10);
                if (!isNaN(value)) {
                    root.percentage = value;
                    root.available = true;
                }
            }
        }
    }

    Process {
        id: adjust
        onExited: query.running = true
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: query.running = true
    }

    function adjustBrightness(delta: int) {
        if (!available)
            return;

        percentage = Math.max(0, Math.min(100, percentage + delta));
        adjust.exec(["brightnessctl", "set", Math.abs(delta) + "%" + (delta > 0 ? "+" : "-")]);
    }
}
