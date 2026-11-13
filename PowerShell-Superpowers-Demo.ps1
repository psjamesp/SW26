# ============================================================
#  Beyond Point-and-Click: Unlock PowerShell's Superpowers
#  Beginner demo commands - 2-3 examples per command
#
#  Tip: in VS Code or PowerShell ISE, click a line and press F8
#  to run just that line.
# ============================================================

# --- Setup: make a practice folder with a few files ---
New-Item -ItemType Directory -Path C:\scripts\SW26 -Force
Set-Location C:\scripts\SW26
"Hello from PowerShell"      | Out-File .\report.txt
"Delete me"                  | Out-File .\temp.txt
"Line 1", "Line 2", "Line 3" | Out-File .\notes.txt


# --- 1. Get-Help: the built-in manual ---
Get-Help Get-Process                  # what a command does
Get-Help Get-Process -Examples        # show examples
Get-Help Get-Process -Online          # open the help page in your browser


# --- 2. Get-Command: find commands ---
Get-Command *service*                 # every command with "service" in the name
Get-Command -Verb Get                 # every "Get" command
Get-Command -Noun Process             # every command that works on processes


# --- 3. Get-ChildItem: list files and folders (dir / ls) ---
Get-ChildItem                         # what's in this folder
Get-ChildItem C:\Windows -Filter *.exe    # only .exe files
Get-ChildItem C:\scripts\SW26 -Recurse      # include subfolders


# --- 4. Get-Content: read a file ---
Get-Content .\notes.txt               # show the whole file
Get-Content .\notes.txt -TotalCount 2 # first 2 lines
Get-Content .\notes.txt -Tail 1       # last line


# --- 5. Copy-Item / Move-Item / Remove-Item: manage files ---
Copy-Item .\report.txt .\report-copy.txt     # copy a file
Move-Item .\report-copy.txt .\report-old.txt # move or rename a file
Remove-Item .\temp.txt                       # delete a file


# --- 6. Test-Path: does it exist? ---
Test-Path C:\scripts\SW26                   # True
Test-Path C:\scripts\SW26\nothing.txt       # False
if (Test-Path .\notes.txt) { Get-Content .\notes.txt }   # only read it if it's there


# --- 7. Get-Date: dates and times ---
Get-Date                              # right now
Get-Date -Format "yyyy-MM-dd"         # just the date, formatted
(Get-Date).AddDays(7)                 # one week from today


# --- 8. Out-File: save output to a file ---
Get-Process | Out-File .\processes.txt          # save a list of processes
Get-Date | Out-File .\processes.txt -Append     # add to the end of the file
Get-Content .\processes.txt                     # look at what we saved


# --- 9. Get-Process / Stop-Process: running programs ---
Start-Process notepad                 # open Notepad so we have something to stop
Get-Process -Name notepad             # find it
Stop-Process -Name notepad            # close it


# --- 10. Get-Service: Windows services ---
Get-Service                           # all services
Get-Service -Name Spooler             # one service (the print spooler)
Get-Service | Where-Object Status -eq 'Running'   # only running services


# --- 11. Clear-Host: clean screen (cls) ---
Clear-Host
cls


# --- 12. Where-Object: filter results ---
Get-Service | Where-Object Status -eq 'Stopped'           # stopped services
Get-ChildItem C:\Windows | Where-Object Length -gt 1MB    # files bigger than 1 MB
Get-Process | Where-Object CPU -gt 10                     # busy programs


# --- Cleanup: remove the practice folder when you're done ---
Set-Location $HOME
Remove-Item C:\scripts\SW26 -Recurse