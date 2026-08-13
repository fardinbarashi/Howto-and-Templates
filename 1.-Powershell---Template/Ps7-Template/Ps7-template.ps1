<#

.DESCRIPTION
    SYSTEM REQUIREMENTS : This script requires PowerShell 7.1 or later and the following modules.

    This script is designed to XXXXXXXX

.EXAMPLE
    .\ScriptName.ps1 -Open

.NOTES
    Author : Fardin Barashi
    Title : ScriptName
    Version : 1.0
    Release day : 2026-06-22
    Github Link  : https://github.com/fardinbarashi
    
.NEWS
 
#>


#------------------------------- Settings -------------------------------

# Filename and Folderspath
 $scriptName   = $MyInvocation.MyCommand.Name # Scriptname
 $logFolder    = "$PSScriptRoot\Logs" # Log Path

# Transcript 
$logFileDate       = Get-Date -Format 'yyyy-MM-dd_HH.mm.ss'
$tranScriptLogFile = "$logFolder\$scriptName - $logFileDate.txt"

Start-Transcript -Path $tranScriptLogFile -Force | Out-Null
Get-Date -Format 'yyyy/MM/dd HH:mm:ss'
Write-Host '.. Starting TranScript'

# Error settings
$ErrorActionPreference = 'Continue'

#------------------------------- Functions List -------------------------------

Write-Host 'Checking required Functions...' -ForegroundColor Yellow

$functionFolder = "$PSScriptRoot\Settings\Functions\"
if (-not (Test-Path $functionFolder)) { throw "Function folder not found: $functionFolder"}
$functionFiles = Get-ChildItem -Path $functionFolder -Filter '*.ps1' -File
if (-not $functionFiles) { throw "No .ps1 files found in $functionFolder"}

foreach ($file in $functionFiles) 
{ 
 try {
        . $file.FullName
        Write-Host "- Loaded $($file.Name)" -ForegroundColor DarkGray
    }
catch { throw "Failed to load function file '$($file.Name)': $($_.Exception.Message)" }
}
Write-Host "All $($functionFiles.Count) function file(s) loaded." -ForegroundColor Green

Initialize-RequiredModules -Modules @('Microsoft.Graph.Authentication')

Write-host ""
#------------------------------- Section 1 -------------------------------
$Section = 'Section 1 :'
try {
    Get-Date -Format 'yyyy/MM/dd HH:mm:ss'
    Write-Host "Start $Section ... 0%" -ForegroundColor Yellow
    

    Write-Host "Start $Section ... 100%" -ForegroundColor Green
    Write-Host ''
}
catch {
    Get-Date -Format 'yyyy/MM/dd HH:mm:ss'
    Write-Host "ERROR on $Section" -ForegroundColor Red
    Write-Host 'ERROR:' $_.Exception.Message
    Write-Host 'Stopping Transcript and Script!' -ForegroundColor Red
    Stop-Transcript
    exit 1
}


#------------------------------- Section 2 -------------------------------
$Section = 'Section 2 :'
try {
    Get-Date -Format 'yyyy/MM/dd HH:mm:ss'
    Write-Host "Start $Section ... 0%" -ForegroundColor Yellow
    

    Write-Host "Start $Section ... 100%" -ForegroundColor Green
    Write-Host ''
}
catch {
    Get-Date -Format 'yyyy/MM/dd HH:mm:ss'
    Write-Host "ERROR on $Section" -ForegroundColor Red
    Write-Host 'ERROR:' $_.Exception.Message
    Write-Host 'Stopping Transcript and Script!' -ForegroundColor Red
    Stop-Transcript
    exit 1
}


#------------------------------- End -------------------------------

Get-Date -Format 'yyyy/MM/dd HH:mm:ss'
Write-Host 'Script finished.' -ForegroundColor Green
Stop-Transcript
