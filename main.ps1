<#
AUTHOR: Aidan Brown
Windows Install script w/ bloat removal
#>

# Needs to be run as Admin
#requires -RunAsAdministrator

# Set the Execution policy
Set-ExecutionPolicy Unrestricted

function wslInstall {
# Check if the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as an administrator."
    Exit
}

# Enable Virtual Machine Platform and Hyper-V features required for WSL 2
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

# Download and install the WSL 2 Linux kernel update package
$wslUpdateUrl = "https://aka.ms/wsl2kernel"
$wslUpdatePackagePath = "$env:TEMP\wsl_update.msi"
Invoke-WebRequest -Uri $wslUpdateUrl -OutFile $wslUpdatePackagePath
Start-Process -Wait -FilePath msiexec.exe -ArgumentList "/i $wslUpdatePackagePath /quiet"
Remove-Item -Path $wslUpdatePackagePath

# Set WSL 2 as the default version
wsl --set-default-version 2

Write-Host "WSL 2 feature has been enabled and configured."
}

function appInstall {
# Install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install apps (Chocolatey won't install it if it's already on the system)
$apps = @('firefox', 'googlechrome', 'steam-client', 'discord',
'notepadplusplus', 'vscode', 'spotify', 'greenshot', 'powertoys',
'docker-desktop', '7zip', 'runelite', 'adobereader', 'qgis', 'screentogif',
'obsidian', 'nextcloud-client')

choco install $apps -fy
}

function removeBloat {
# Remove bloat
$bloat_apps = @(
    "*Microsoft.3DBuilder*"
    "*Microsoft.549981C3F5F10*"   #Cortana app
    "*Microsoft.Asphalt8Airborne*"
    "*Microsoft.BingFinance*"
    "*Microsoft.BingFoodAndDrink*"            
    "*Microsoft.BingHealthAndFitness*"         
    "*Microsoft.BingNews*"
    "*Microsoft.BingSports*"
    "*Microsoft.BingTranslator*"
    "*Microsoft.BingTravel* "
    "*Microsoft.BingWeather*"
    "*Microsoft.GetHelp*"
    "*Microsoft.Messaging*"
    "*Microsoft.Microsoft3DViewer*"
    "*Microsoft.MicrosoftOfficeHub*"
    "*Microsoft.MicrosoftSolitaireCollection*"
    "*Microsoft.MicrosoftStickyNotes*"
    "*Microsoft.MixedReality.Portal*"
    "*Microsoft.NetworkSpeedTest*"
    "*Microsoft.News*"
    "*Microsoft.Office.OneNote*"
    "*Microsoft.Office.Sway*"
    "*Microsoft.OneConnect*"
    "*Microsoft.Print3D*"
    "*Microsoft.SkypeApp*"
    "*Microsoft.Todos*"
    "*Microsoft.WindowsAlarms*"
    "*Microsoft.WindowsFeedbackHub*"
    "*Microsoft.WindowsMaps*"
    "*Microsoft.WindowsSoundRecorder*"
    "*Microsoft.ZuneVideo*"
    "*ACGMediaPlayer*"
    "*ActiproSoftwareLLC*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Amazon.com.Amazon*"
    "*Asphalt8Airborne*" 
    "*AutodeskSketchBook*"
    "*CaesarsSlotsFreeCasino*"
    "*Clipchamp.Clipchamp*"
    "*COOKINGFEVER*"
    "*CyberLinkMediaSuiteEssentials*"
    "*DisneyMagicKingdoms*"
    "*Dolby*"
    "*DrawboardPDF*"
    "*Duolingo-LearnLanguagesforFree*"
    "*EclipseManager*"
    "*Facebook*"
    "*FarmVille2CountryEscape*"
    "*fitbit*"
    "*Flipboard*"
    "*HiddenCity*"
    "*HULULLC.HULUPLUS*"
    "*iHeartRadio*"
    "*king.com.BubbleWitch3Saga*"
    "*king.com.CandyCrushSaga*"
    "*king.com.CandyCrushSodaSaga*"
    "*LinkedInforWindows*"
    "*MarchofEmpires*"
    "*Netflix*"
    "*NYTCrossword*"
    "*OneCalendar*"
    "*PandoraMediaInc*"
    "*PhototasticCollage*"
    "*PicsArt-PhotoStudio*"
    "*Plex*"
    "*PolarrPhotoEditorAcademicEdition*"
    "*Royal Revolt*"
    "*Shazam*"
    "*Sidia.LiveWallpaper*"
    "*SlingTV*"
    "*Speed Test*"
    "*TuneInRadio*"
    "*Twitter*"
    "*Viber*"
    "*WinZipUniversal*"
    "*Wunderlist*"
    "*XING*"
    "*tiktok*"
)

ForEach ($bloat in $bloat_apps){
    Write-Output "Attempting to remove $bloat"

    Get-AppxPackage -Name $bloat -AllUsers | Remove-AppxPackage

    Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -like $bloat } |
     ForEach-Object { Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $_.PackageName }
    }  
}

wslInstall
appInstall
removeBloat

