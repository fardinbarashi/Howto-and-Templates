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

# Transcript
$scriptName = $MyInvocation.MyCommand.Name
$logFileDate = (Get-Date -Format yyyy/MM/dd/HH.mm.ss)
$fileDate = (Get-Date -Format yyyy/MM/dd/)
$tranScriptLogFile = "$PSScriptRoot\Logs\$ScriptName - $LogFileDate.Txt"
$startTranscript = Start-Transcript -Path $TranScriptLogFile -Force

Get-Date -Format "yyyy/MM/dd HH:mm:ss"
Write-Host ".. Starting TranScript"

# Tenet-Settings
$settings = Get-Content "$PSScriptRoot\Settings\MsGraphSettings.json" | ConvertFrom-Json
$appId = $Settings.AppId
$tenantId = $Settings.TenantId
$certificateThumbprint = $Settings.CertificateThumbprint
$certificate = Get-ChildItem Cert:\LocalMachine\My\$CertificateThumbprint

# Error-Settings
$errorActionPreference = 'Continue'

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



#------------------------------- Start Script -------------------------------

$Section = "Section 1 : Connect to mgGraph"
Try 
 { # Start Try
    Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Host "Start" $Section -ForegroundColor Yellow

    # Run Query
    Write-Host "Trying to connect to the mgGraph... 0%" -ForegroundColor Yellow
    $connectToMgGraph = Connect-MgGraph -TenantId $tenantId -Certificate $certificate -ClientId $appId

    if ($connectToMgGraph -eq $null) 
     { # Start if ($connectToMgGraph -eq $null) 
        Get-Date -Format "yyyy/MM/dd HH:mm:ss"
        Write-Host "ERROR on $section" -ForegroundColor Red
        Write-Warning $Error[0]
        Write-Host "The connection to MgGraph FAILED, check your certificateThumbprint" -ForegroundColor Yellow
        Write-Host "STOPPING transcript and script!" -ForegroundColor Red
        Stop-Transcript
        Exit
     } # End if ($connectToMgGraph -eq $null) 
    else 
     { # Start Else, if ($connectToMgGraph -eq $null) 
        Write-Host "Trying to connect to the MgGraph... 100%" -ForegroundColor Green
        Write-Host "The connection to MgGraph is SUCCESSFUL, continue the script " -ForegroundColor Green
      } # End Else, if ($connectToMgGraph -eq $null) 

    Write-Host ""
 } # End Try
Catch 
{ # Start Catch
    Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Host "ERROR on $Section" -ForegroundColor Red
    Write-Host "ERROR:" $_.Exception.Message
    Write-Host $Error[0]  
    Write-Host "Stopping Transcript and Script!" -ForegroundColor Red
    Stop-Transcript
} # End Catch

Stop-Transcript
