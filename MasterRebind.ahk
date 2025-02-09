#SingleInstance
A_HotkeyInterval := 0
suspended := false
F9::
{
    global suspended
    TrayTip( "Horizontal Scroll", (suspended ? "Suspended" : "Enabled"), 0x1)
    Sleep(1000)
    TrayTip
    suspended := !suspended
}
^!+r::
{
    TrayTip( "Reloading script...", "Reloading", 0x1)
    Sleep(1000)
    TrayTip
    Reload
}
+Esc::{
    Suspend(-1)
    TrayTip("Suspended", "", 0x1)
    Sleep(1000)
    TrayTip
}
; button remaps
XButton1::Browser_Back
XButton2::Media_Play_Pause
PrintScreen::^+s
+PrintScreen::^+Space
Home::Media_Play_Pause
F10::Volume_Down
F11::Volume_Up
F12::Volume_Mute
; horizontal scroll
scrolled := false
~RButton & WheelDown:: {
    Send("+{WheelDown 8}")
    global scrolled := true
}
~RButton & WheelUp:: {
    Send("+{WheelUp 8}")
    global scrolled := true
}
RButton Up:: {
    global scrolled
    Sleep(1)
    if (!suspended and scrolled) {
        Click
        scrolled := false
    }
}
; borderless window toggle
; Ctrl+Alt+F to toggle
windowStates := Map()
^!f:: {
    global windowStates
    activeID := WinGetID("A")  ; Get the active window's ID

    if (windowStates.Has(activeID) && windowStates[activeID].borderless) {
        ; Restore the window's original style and position.
        WinSetExStyle(windowStates[activeID].originalExStyle, "ahk_id " . activeID)
        WinSetStyle(windowStates[activeID].originalStyle, "ahk_id " . activeID)
        WinMove(windowStates[activeID].X, windowStates[activeID].Y, windowStates[activeID].Width, windowStates[activeID].Height, "ahk_id " . activeID)
        windowStates[activeID].borderless := false
    } else {
        originalExStyle := WinGetExStyle("ahk_id " . activeID)
        originalStyle := WinGetStyle("ahk_id " . activeID)
        ; Remove the window border and title bar.
        newExStyle := originalExStyle & ~0x800000
        WinSetExStyle(newExStyle, "ahk_id " . activeID)
        WinSetStyle(-0xC00000, "ahk_id " . activeID)
        ; Save the original style info for later restoration.
        locX := locY := locWidth := locHeight := 0
        WinGetPos(&locX, &locY, &locWidth, &locHeight, "ahk_id " . activeID)
        windowStates[activeID] := { 
            X: locX, Y: locY, Width: locWidth, Height: locHeight, 
            originalExStyle: originalExStyle, originalStyle: originalStyle, 
            borderless: true 
        }
        WinMaximize("ahk_id " . activeID)
    }
    return
}

^!+f:: ; Ctrl+Alt+Shift+F to toggle padding
{
    global PADDING
    if (PADDING = 30) {
        PADDING := 32
    } else {
        PADDING := 30
    }
    TrayTip( "Padding set to " . PADDING . ".", "Padding", 0x1)
    Sleep(3000)
    TrayTip
}

