#SingleInstance force
#Persistent
SetBatchLines -1
CoordMode, Mouse, Screen ; Make sure Click command uses Screen coordinates

; --- !!! USER INPUT REQUIRED !!! ---
; --- Replace 1234 and 567 with the coordinates you found using Window Spy ---
global targetX := 1234 ; <--- PUT YOUR X COORDINATE HERE
global targetY := 567  ; <--- PUT YOUR Y COORDINATE HERE
global gameWindowTitle := "Roblox" ; <-- SET YOUR GAME WINDOW TITLE HERE (used for focus check)
; --- !!! USER INPUT REQUIRED !!! ---

global miningActive := false         ; Is mining toggled on?
global isMouseDown := false          ; Is the mouse button currently held down by the script?

; --- Timer Intervals (in milliseconds) ---
global repositionInterval := 300000  ; 5 minutes for mouse reposition
global antiAfkInterval := 900000     ; 15 minutes for A/D press (15 * 60 * 1000)

; --- Hotkey to Toggle Mining On/Off ---
F1::
    miningActive := !miningActive ; Toggle the state
    if (miningActive) {
        ; --- Mining ON ---
        ToolTip, Mining: ON (Press F1 to stop)`nTarget: %targetX%, %targetY%
        Sleep, 200 ; Small delay before clicking down

        Click, %targetX%, %targetY%, Down ; Click and hold mouse down at the specified coordinates
        isMouseDown := true

        ; Start the timers
        SetTimer, RepositionMouse, %repositionInterval%
        SetTimer, AntiAfkAction, %antiAfkInterval%

    } else {
        ; --- Turning Mining OFF ---
        ; Stop the timers
        SetTimer, RepositionMouse, Off
        SetTimer, AntiAfkAction, Off

        ; Release mouse if it was held down
        if (isMouseDown) {
            Click, Up
            isMouseDown := false
        }
        ToolTip ; Turn off the tooltip
    }
return

; --- Timer subroutine to reposition the mouse periodically ---
RepositionMouse:
    ; Only run if mining is still active and mouse should be down
    if (!miningActive || !isMouseDown) {
        Return
    }

    ; Check if game window is active before repositioning
    IfWinNotActive, %gameWindowTitle%
    {
        Return ; Don't reposition if game isn't active
    }

    ; Briefly release and press down again at the target location
    Click, Up
    isMouseDown := false ; Update state
    Sleep, 100          ; Short pause
    ; Only press down again if mining is STILL active
    if (miningActive) {
        Click, %targetX%, %targetY%, Down
        isMouseDown := true ; Update state
    }
return

; --- Timer subroutine for Anti-AFK action ---
AntiAfkAction:
    ; Only run if mining is still active
    if (!miningActive) {
        Return
    }

    ; Check if the game window is active before sending keys/clicking
    IfWinNotActive, %gameWindowTitle%
    {
        Return ; Don't do anything if game isn't the active window
    }

    ; --- Action Start ---
    Click, Up           ; <<< Release the mouse click
    isMouseDown := false ; Update state variable
    Sleep, 100          ; Small delay

    SendInput, a        ; Press A
    Sleep, 150          ; Wait a bit between presses
    SendInput, d        ; Press D
    Sleep, 100          ; Small delay before clicking again

    ; Press mouse down again at target coordinates,
    ; but only if mining is STILL active (in case F1 was pressed during sleeps)
    if (miningActive) {
        Click, %targetX%, %targetY%, Down  ; <<< Press mouse down again
        isMouseDown := true              ; Update state variable
    }
return

; --- Hotkey to Exit the Script ---
Esc::
    ; Stop timers
    SetTimer, RepositionMouse, Off
    SetTimer, AntiAfkAction, Off

    ; Release the mouse button if it's down before exiting
    if (isMouseDown) {
        Click, Up
    }
    ExitApp
return
