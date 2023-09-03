# Windows-Install-Script/Bloat Remover

- Installs Virtual Machine Platform and WSL Windows Features
- Sets WSL2 to the default version of WSL
- Uses [Chocolatey](https://community.chocolatey.org/) to install applications
- Removes common bloatware shipped with Windows 10/11

## How to run

> open Powershell as <b>Administrator<b>

Copy and paste the following:

`irm https://raw.githubusercontent.com/h4wk590/Windows-Install-Script/main/main.ps1 | iex`

- You may need to `Set-ExecutionPolicy Unrestricted`. The script should do this for you.

For TLS related errors run this:

`[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/h4wk590/Windows-Install-Script/main/main.ps1')`

## Add or change applications to install

Modify the following line:

```
$apps = @('firefox', 'googlechrome', 'steam-client', 'discord',
'notepadplusplus', 'vscode', 'spotify', 'greenshot', 'powertoys',
'docker-desktop', '7zip', 'runelite', 'adobereader', 'qgis', 'screentogif',
'obsidian', 'nextcloud-client')
```

- Add or remove any programs you want. 
- Chocolatey has an extensive list of packages [here](https://community.chocolatey.org/packages).



 
 
