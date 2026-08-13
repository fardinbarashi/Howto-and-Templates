<#
.DESCRIPTION
    SYSTEM REQUIREMENTS : This script requires PowerShell 5.1 or later and the following modules.

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

#----------------------------------- Settings ------------------------------------------
# Transcript
$ScriptName = $MyInvocation.MyCommand.Name
$LogFileDate = (Get-Date -Format yyyy/MM/dd/HH.mm.ss)
$TranScriptLogFile = "$PSScriptRoot\Logs\$ScriptName - $LogFileDate.Txt" 
$StartTranscript = Start-Transcript -Path $TranScriptLogFile -Force
Get-Date -Format "yyyy/MM/dd HH:mm:ss"
Write-Host ".. Starting TranScript"

# Modules to import
Write-Host "Checking required modules..." -ForegroundColor Yellow

$requiredModules = @(
    "Microsoft.Graph.Identity.DirectoryManagement",
    "Microsoft.Graph.Groups"
)

foreach ($module in $requiredModules) {
    Write-Host "`nChecking module: $module" -ForegroundColor Cyan
    
    if (Get-Module -ListAvailable -Name $module) {
        Write-Host "- Module found - Importing..." -ForegroundColor Green
        Import-Module $module -ErrorAction SilentlyContinue
    }
    else {
        Write-Host "- Module not found! - Installing..." -ForegroundColor Yellow
        Install-Module -Name $module -Scope CurrentUser -Force -AllowClobber
        Import-Module $module -Verbose
    }
}

Write-Host "`nAll modules are ready!" -ForegroundColor Green

# Error-Settings
$ErrorActionPreference = 'Continue'
#----------------------------------- Start Script ------------------------------------------
# Section 1 : xx
$Section = "Section 1 : XX"
Try
{ # Start Try, $Section
 Get-Date -Format "yyyy/MM/dd HH:mm:ss"
 Write-Host $Section... "0%" -ForegroundColor Yellow

 # Run Query

 Write-Host ""
} # End Try

Catch
{ # Start Catch
 Get-Date -Format "yyyy/MM/dd HH:mm:ss"
 Write-Host "ERROR on $Section" -ForegroundColor Red
 Write-Warning $Error[0]
 Write-Host "Stopping Transcript and Script!" -ForegroundColor Red
 Stop-Transcript
 Exit
} # End Catch

#----------------------------------- End Script ------------------------------------------
Stop-Transcript
