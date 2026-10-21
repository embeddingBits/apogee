import QtQuick
import Quickshell
import Quickshell.Io
import "./services"
import "./modules/popups"

// Standalone Quickshell calendar, launched on demand by the Waybar clock.
// It reuses the same CalendarPopup/CalendarService as the full shell.
ShellRoot {
    id: root

    property bool calendarOpen: true

    // Waybar does not expose the clicked output to on-click commands, so the
    // launcher passes niri's currently focused output instead.
    property var targetScreen: {
        const name = String(Quickshell.env("QS_CALENDAR_SCREEN") ?? "");
        if (name === "")
            return null;
        for (let i = 0; i < Quickshell.screens.length; i++) {
            if (Quickshell.screens[i].name === name)
                return Quickshell.screens[i];
        }
        return null;
    }

    CalendarService {
        id: calendarService
    }

    // Invisible 1px anchor at the bottom edge of the Waybar bar (45px tall),
    // so CalendarPopup places itself just below it.
    PanelWindow {
        id: barAnchor

        anchors {
            top: true
            left: true
            right: true
        }

        margins.top: 44
        implicitHeight: 1
        color: "transparent"
        exclusiveZone: -1
        mask: Region {}
        screen: root.targetScreen
    }

    CalendarPopup {
        bar: barAnchor
        calendarService: calendarService
        calendarOpen: root.calendarOpen
    }

    // Click-away dismiss, matching the full shell's popup behavior.
    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            required property var modelData

            screen: modelData
            visible: root.calendarOpen

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            color: "transparent"
            exclusiveZone: -1

            MouseArea {
                anchors.fill: parent
                onClicked: root.closeCalendar()
            }
        }
    }

    function closeCalendar() {
        root.calendarOpen = false;
        Qt.quit();
    }

    IpcHandler {
        target: "calendar"

        function close(): string {
            root.closeCalendar();
            return "closed";
        }
    }
}
