#SingleInstance
A_HotkeyInterval := 0
; SetNumLockState "AlwaysOn"

; button remaps
XButton1::Browser_Back
XButton2::Media_Play_Pause
PrintScreen::^+s
+PrintScreen::^+Space
Home::Media_Play_Pause
; horizontal scroll
RButton & WheelDown::+WheelDown
RButton & WheelUp::+WheelUp
RButton::RButton
WheelDown::WheelDown
WheelUp::WheelUp

; borderless window toggle
; Declare windowStates at the top level to ensure it is recognized as a global variable
; Initialize windowStates as a Map for better structure
windowStates := Map()
PADDING := 30
^!f:: ; Ctrl+Alt+F to toggle
{
    global windowStates
    global PADDING
    active_id := WinGetID("A") ; Get the active window ID

    if (windowStates.Has(active_id) && windowStates[active_id]["borderless"]) {
        ; Restore the window's border and size
        currentExStyle := WinGetExStyle("ahk_id " . active_id)
        ; Restore the previous ExStyle
        WinSetExStyle(windowStates[active_id]["originalExStyle"], "ahk_id " . active_id)
        WinSetStyle(windowStates[active_id]["originalStyle"], "ahk_id " . active_id)
        ; Move and resize window to its original position and size
        WinMove(windowStates[active_id]["X"], windowStates[active_id]["Y"], windowStates[active_id]["Width"], windowStates[active_id]["Height"], "ahk_id " . active_id)
        windowStates[active_id]["borderless"] := false
    } else {
        ; Save the current window size, position, and ExStyle
        locX := locY := locWidth := locHeight := 0
        left := top := right := bottom := 0
        originalExStyle := WinGetExStyle("ahk_id " . active_id)
        originalStyle := WinGetStyle("ahk_id " . active_id)
        WinGetPos(&locX, &locY, &locWidth, &locHeight, "ahk_id " . active_id)
        MonitorGet(0, &left, &top, &right, &bottom)
        
        ; Calculate screen dimensions dynamically

        ; Remove the window border and title bar by changing ExStyle
        newExStyle := originalExStyle & ~0x800000 ; Attempt to remove WS_EX_WINDOWEDGE style
        WinSetExStyle(newExStyle, "ahk_id " . active_id)
        WinSetStyle(-0xC00000, "ahk_id " . active_id) ; WS_CAPTION | WS_THICKFRAME
        
        ; Move and resize window to fill the screen
        WinMove(left, top - PADDING/2, right - left + PADDING/2, bottom - top + PADDING, "ahk_id " . active_id)
        
        ; Store the state, original dimensions, and ExStyle of the window
        windowStates[active_id] := Map()
        windowStates[active_id]["X"] := locX
        windowStates[active_id]["Y"] := locY
        windowStates[active_id]["Width"] := locWidth
        windowStates[active_id]["Height"] := locHeight
        windowStates[active_id]["originalExStyle"] := originalExStyle
        windowStates[active_id]["originalStyle"] := originalStyle
        windowStates[active_id]["borderless"] := true
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

^!r::
{
    TrayTip( "Reloading script...", "Reloading", 0x1)
    Sleep(500)
    Reload
}
; 123456789034567890-32456 ; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456