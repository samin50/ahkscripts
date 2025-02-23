#SingleInstance
A_HotkeyInterval := 0
suspended := false
brightness := 1
brightnessIncrement := 1
; Control macros
F9::
{
    global suspended
    TrayTip( "Horizontal Scroll", (suspended ? "Auto Click After Enabled" : "Auto Click After Disabled"), 0x1)
    suspended := !suspended
    Sleep(5000)
    TrayTip
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
    Sleep(5000)
    TrayTip
}
; SDR brightness control
; Using https://github.com/BoatStuck/SDRBrightness
ChangeBrightness(direction) {
    global brightness
    if (direction = "up") {
        if (brightness < 6) {
            brightness += brightnessIncrement
        }
        Run(".\brightnessControl.exe " . brightness, ,"min")
    } else {
        if (brightness > 1) {
            brightness -= brightnessIncrement
        }
        Run(".\brightnessControl.exe " . brightness, ,"min")
    }
}
Run(".\brightnessControl.exe 1", ,"min")
; Button remaps
XButton1::Browser_Back
XButton2::Media_Play_Pause
PrintScreen::^+s
+PrintScreen::^+Space
F1::Volume_Mute
^F2::F2
F2::Volume_Down
F3::Volume_Up
F7::ChangeBrightness("down")
F8::ChangeBrightness("up")
; Horizontal scroll
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
; Borderless window toggle
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
