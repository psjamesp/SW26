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
get-help get-process -Full
get-help get-process -ShowWindow


# --- 2. Get-Command: find commands ---
Get-Command *service*                 # every command with "service" in the name
Get-Command -Verb Get                 # every "Get" command
Get-Command -Noun Process             # every command that works on processes
get-command -module Microsoft.PowerShell.Management
get-command -module azure
get-command *teams* 


get-service | Get-Member
get-service | select-object Name

# --- 3. Get-ChildItem: list files and folders (dir / ls) ---
Get-ChildItem                         # what's in this folder
Get-ChildItem C:\scripts -Recurse -Filter *.ps1    # only .ps1 files
Get-ChildItem C:\scripts\SW26 -Recurse  
get-childitem -    # include subfolders


# --- 4. Get-Content: read a file ---
Get-Content .\notes.txt  clear           # show the whole file
Get-Content .\notes.txt -TotalCount 2 # first 2 lines
Get-Content .\notes.txt -Tail 1     
get-content .\notes.txt -tail 2 -Wait  # last line


# --- 5. Copy-Item / Move-Item / Remove-Item: manage files ---
Copy-Item .\report.txt .\report-copy.txt     # copy a file
Move-Item .\report-copy.txt .\report-old.txt # move or rename a file
Remove-Item .\temp.txt           -whatif            # delete a file


# --- 6. Test-Path: does it exist? ---
Test-Path C:\scripts\SW26                   # True
Test-Path C:\scripts\SW26\nothing.txt       # False
if (Test-Path .\notes.txt) { Get-Content .\notes.txt } 
if (!(test-path .\notes23.txt)) { write-host "File does not exist" }  
if ((test-path .\notes23.txt) -eq $false) { write-host "File does not exist" }
# only read it if it's there


# --- 7. Get-Date: dates and times ---
Get-Date                              # right now
Get-Date -Format "yyyy-MM-dd"         # just the date, formatted
(Get-Date).AddDays(-7) 
(get-date).AddYears(7)                # one week from today

(get-date "December 25 2026")
$daysUntilChristmas = (get-date 2026-12-25) - (get-date)
write-host "there are $($daysUntilChristmas.days) days until Christmas"
$logfilename = "log_$(get-date -format yyyy-MM-dd_HH-mm-ss).txt"
new-item -path .\ -Name $logfilename -ItemType File

# --- 8. Out-File: save output to a file ---
Get-Process | Out-File .\processes.txt          # save a list of processes
Get-Date | Out-File .\processes.txt -Append     # add to the end of the file
Get-Content .\processes.txt                     # look at what we saved

get-service | export-csv .\services.csv
$service = import-csv .\services.csv

new-item -path .\ -name "index.html" -ItemType File
get-content .\index.html
get-service | ConvertTo-Json | out-file .\service.json

$jsonservice = get-content .\service.json | convertfrom-json
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