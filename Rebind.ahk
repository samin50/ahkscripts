#SingleInstance
A_HotkeyInterval := 0
suspended := false
brightness := 1
brightnessIncrement := 1
; Buttons
XButton1::Browser_Back
XButton2::Media_Play_Pause
global enabled := false
F7::ChangeBrightness("down")
F8::ChangeBrightness("up")
F9::Toggle()
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

; Control macros
Toggle() {
    global enabled
    enabled := !enabled
    if (enabled) {
        TrayTip("Enabled", "Enabled", 0x1)
        Sleep(5000)
        TrayTip
    } else {
        TrayTip("Disabled", "Disabled", 0x1)
        Sleep(5000)
        TrayTip
    }
}
SendMode("Event")
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
global m := 90000
SetTimer(main, 1000)

main() {
    if (A_TimeIdlePhysical > m && enabled)
    {
        static c := 0
        if  Random(1, 15) == 10 {
            SendInput("!{Tab}")
        } 
        else {
             MouseMove((c++&1 ? -1 : 1)*Random(0, A_ScreenWidth//6), (c&2 ? -1 : 1)*Random(0, A_ScreenHeight//6), Random(10, 40), "R")
        }
        Sleep(Random(0, 20000))
    }
}
