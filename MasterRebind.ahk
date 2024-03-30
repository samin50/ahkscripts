#SingleInstance
scrolled := False
SetNumLockState "AlwaysOn"

RButton::
{
    global scrolled
    Click "Right Down"
    KeyWait "RButton"
    Click "Right Up"
    if (scrolled)
    {   
        ; cancel context menu
        sleep 10
        Send "{Esc}"
        scrolled := False
        return
    }
    return
}

~RButton & WheelUp:: 
{
    global scrolled
    Send "{WheelLeft}"
    scrolled := True
    return
}

~RButton & WheelDown::
{
    global scrolled
    Send "{WheelRight}"
    scrolled := True
    return
}

; button remaps
XButton2::XButton1
XButton1::Media_Play_Pause
PrintScreen::^+s
+PrintScreen::^+Space
Home::Media_Play_Pause

; borderless window toggle
; Declare windowStates at the top level to ensure it is recognized as a global variable
; Initialize windowStates as a Map for better structure
windowStates := Map()

^!f:: ; Ctrl+Alt+F to toggle
{
    global windowStates
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
        locX := locY := locWidth := locHeight := ""
        originalExStyle := WinGetExStyle("ahk_id " . active_id)
        originalStyle := WinGetStyle("ahk_id " . active_id)
        WinGetPos(&locX, &locY, &locWidth, &locHeight, "ahk_id " . active_id)
        
        ; Calculate screen dimensions dynamically
        PADDING := 30
        screenW := A_ScreenWidth+PADDING
        screenH := A_ScreenHeight+PADDING

        ; Remove the window border and title bar by changing ExStyle
        newExStyle := originalExStyle & ~0x800000 ; Attempt to remove WS_EX_WINDOWEDGE style
        WinSetExStyle(newExStyle, "ahk_id " . active_id)
        WinSetStyle(-0xC00000, "ahk_id " . active_id) ; WS_CAPTION | WS_THICKFRAME
        
        ; Move and resize window to fill the screen
        WinMove(-PADDING/2, -PADDING/2, screenW, screenH, "ahk_id " . active_id)
        
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

; 123456789034567890-32456 ; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456; 123456789034567890-32456