Write-Host "Creating AHK Startup shortcut..."

$WshShell = New-Object -ComObject WScript.Shell
$ShortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\mac-like-keyboard.lnk"
$Target = "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe"
$Args = "`"$env:USERPROFILE\.config\autohotkey\mac-like-keyboard.ahk`""

$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $Target
$Shortcut.Arguments = $Args
$Shortcut.WorkingDirectory = "$env:USERPROFILE\.config\autohotkey"
$Shortcut.WindowStyle = 7  # Minimized
$Shortcut.Save()

Write-Host "mac-like-keyboard AutoHotkey shortcut created."