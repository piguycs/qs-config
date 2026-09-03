# Quickshell Rice — Agent Reference

This project is a Quickshell-based desktop shell (bar, background, OSDs, etc.) for a Linux Wayland compositor (likely Niri; see `.old/`). It uses **Quickshell v0.3.0**.

## Base Documentation URL

All type docs live under:  
**`https://quickshell.org/docs/v0.3.0/types/`**

Append the module path to reach specific types, e.g.:
- Core: `https://quickshell.org/docs/v0.3.0/types/Quickshell`
- Wayland: `https://quickshell.org/docs/v0.3.0/types/Quickshell.Wayland`

## Modules Used in This Project

| Import | Purpose | Doc Subpath |
|--------|---------|-------------|
| `Quickshell` | Core types (`Scope`, `Variants`, `Quickshell.screens`, `PanelWindow`) | `Quickshell` |
| `Quickshell.Wayland` | Wayland layer-shell (`WlrLayershell`, `WlrLayer`, `ExclusionMode`) | `Quickshell.Wayland` |
| `Quickshell.Io` | File/process IPC helpers | `Quickshell.Io` |
| `Quickshell.Widgets` | Bundled reusable widgets | `Quickshell.Widgets` |
| `Quickshell.Services.Mpris` | Media player control (MPRIS) | `Quickshell.Services.Mpris` |
| `Quickshell.Services.SystemTray` | System tray / DBusMenu | `Quickshell.Services.SystemTray` |
| `Quickshell.Services.UPower` | Battery / power info | `Quickshell.Services.UPower` |
| `Quickshell.Services.Pipewire` | Audio / volume (PipeWire) | `Quickshell.Services.Pipewire` |
| `Quickshell.Services.Notifications` | Notification daemon types | `Quickshell.Services.Notifications` |
| `Quickshell.Networking` | Network status | `Quickshell.Networking` |

## Project Layout

| Path | What |
|------|------|
| `shell.qml` | Root `Scope`; instantiates `Bar` + per-screen `Background` |
| `panels/` | QML modules imported as `qs.panels` (`Bar.qml`, etc.) |
| `Background.qml` | Full-screen `PanelWindow` on `WlrLayer.Background` with optional blur for overview |
| `.old/` | Previous iteration of widgets: `NiriSession.qml`, `SystemTray.qml`, `VolumeOSD.qml`, `MprisController.qml`, `WorkspaceIndicator.qml`, `Runner.qml`, etc. |

## Compositor Hints

- The Window Manager to be used is Niri
- `WlrLayershell` is supported, so it can be used

## Quickshell-Specific Patterns

- `Variants { model: Quickshell.screens ... }` creates one instance per monitor.
- `PanelWindow` is a top-level shell surface; anchor it with `anchors { top: true; left: true; ... }`.
- `WlrLayershell.namespace` must be unique per surface.
- `exclusionMode` / `WlrLayershell.layer` control stacking and input behavior.
