pragma Singleton

import Quickshell
import Quickshell.Services.UPower

// Battery data source using UPower.
// Provides read-only properties for easy consumption by widgets.
Singleton {
    // Whether a battery device is available.
    readonly property bool available: UPower.displayDevice.isLaptopBattery

    // Current charge percentage (0–100).
    readonly property int percentage: available ? Math.round(UPower.displayDevice.percentage * 100) : 0

    // Whether the device is currently charging.
    readonly property bool charging: available && UPower.displayDevice.state === UPowerDeviceState.Charging

    // Whether the battery level is critically low.
    readonly property bool critical: available && UPower.displayDevice.percentage <= 0.1

    // Human-readable state: "Charging", "Discharging", etc.
    readonly property string stateText: {
        if (!available) return "";
        switch (UPower.displayDevice.state) {
            case UPowerDeviceState.Charging:       return "Charging";
            case UPowerDeviceState.Discharging:    return "Discharging";
            case UPowerDeviceState.FullyCharged:   return "Full";
            case UPowerDeviceState.PendingCharge:  return "Pending Charge";
            case UPowerDeviceState.PendingDischarge: return "Pending Discharge";
            case UPowerDeviceState.Unknown:        return "Unknown";
            default:                               return "";
        }
    }
}
