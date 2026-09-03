pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

// Shared, tracked default-output volume source.
Singleton {
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool available: sink !== null && sink.audio !== null
    readonly property real volume: available ? sink.audio.volume : 0
    readonly property bool muted: available && sink.audio.muted

    PwObjectTracker {
        objects: Pipewire.nodes.values.filter(node => node.audio && !node.isStream)
    }

    function adjustVolume(delta: real) {
        if (!available)
            return;

        sink.audio.volume = Math.max(0, Math.min(1, sink.audio.volume + delta));
    }

    function toggleMuted() {
        if (available)
            sink.audio.muted = !sink.audio.muted;
    }
}
