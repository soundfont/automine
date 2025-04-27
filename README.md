# AutoHotkey Coordinate Clicker with Anti-AFK

A simple AutoHotkey (v1.1) script designed to automate clicking and holding the left mouse button at specific screen coordinates, with built-in periodic repositioning and an anti-AFK mechanism.

## Features

* Clicks and holds the left mouse button at user-defined screen coordinates (`targetX`, `targetY`).
* Activated and deactivated using a hotkey (`F1`).
* Periodically releases and re-clicks at the target coordinates to maintain activity (default: every 5 minutes).
* Periodically performs an anti-AFK action: releases the mouse, presses 'A', presses 'D', then re-clicks the mouse (default: every 15 minutes).
* Includes an exit hotkey (`Esc`).
* Checks if the specified target window (`gameWindowTitle`) is active before performing mouse repositioning or anti-AFK actions.

## Requirements

* [AutoHotkey](https://www.autohotkey.com/) (v1.1 or later recommended) installed on your Windows machine.

## Setup

1.  **Install AutoHotkey:** If you haven't already, download and install it from the official website.
2.  **Download Script:** Download the `.ahk` script file from this repository.
3.  **Find Coordinates:**
    * Run AutoHotkey's "Window Spy" tool (usually accessible by right-clicking the AutoHotkey icon in the system tray).
    * Open the target game or application window.
    * Hover your mouse over the *exact* spot you want the script to click and hold.
    * Note the `Screen:` coordinates shown in Window Spy (e.g., `Screen: 1025, 650`).
4.  **Configure Script:**
    * Open the `.ahk` script file in a text editor (like Notepad).
    * Find the lines near the top starting with `global targetX :=` and `global targetY :=`. Replace the placeholder numbers (e.g., `1234`, `567`) with the **X** and **Y** coordinates you found.
    * Find the line `global gameWindowTitle :=`. Replace `"Roblox"` (or the default value) with the **exact window title** of the application you want the script to work in. This is important for the active window checks.
    * *(Optional)* Adjust `repositionInterval` (mouse re-click) and `antiAfkInterval` (A/D press) values if desired. These are in milliseconds.
5.  **Save:** Save the changes to the script file.

## Usage

1.  **Run Script:** Double-click the `.ahk` file. You may need to "Run as administrator" if the target application is running with elevated privileges. An 'H' icon should appear in your system tray.
2.  **Toggle On/Off:** Press `F1` to start the script. It will immediately move the mouse (if not already there) and hold the left button down at the specified coordinates. Press `F1` again to stop the script and release the mouse button.
3.  **Exit Script:** Press `Esc` to stop all actions and completely exit the script.

## Disclaimer

⚠️ **Use this script at your own risk.** Automating actions in games or other applications may violate their Terms of Service and could potentially lead to warnings or account bans.

⚠️ **Coordinate-based scripts are fragile.** If the target window is moved, resized, your screen resolution changes, or the application's UI is updated, the hardcoded coordinates will likely become incorrect. You will need to manually find the new coordinates and update the script if the click position changes.
