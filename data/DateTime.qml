pragma Singleton

import Quickshell

// Shared clock source; minute precision avoids unnecessary updates.
Singleton {
    readonly property string time: Qt.formatTime(clock.date, "HH:mm")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
