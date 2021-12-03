# Needs to be run as Admin

#requires -RunAsAdministrator

# Set the Execution policy
Set-ExecutionPolicy -Unrestricted

# Install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install apps (Chocolatey won't install it if it's already on the system)

choco install firefox -fy
choco install googlechrome -fy
choco install steam-client -fy
choco install discord -fy
choco install notepadplusplus -fy
choco install vscode -fy
choco install spotify -fy
choco install greenshot -fy
choco install powertoys -fy

