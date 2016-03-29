    # Script:	K2Field.PreReq.Script.ps1
# Author: 	Tim Huttemeister, K2
# Website: 	http://www.timhuttemeister.com
# Purpose: 	Install & configure the basic K2 prerequisites properly
# Version:  1.2
# Date:     2016-03-29
#

#
# Module needed to install Windows roles & features
#
Import-Module ServerManager

#
# K2 logo ASCII art & intro message
#
Function Intro {
$logo = @"                       
  ++++  ++++             
  ++++  ++++             
  ++++  ++++             
  ++++                  
                     
  ++++ ++++  +; +'  ;+++,, 
  ++++ ++++  +;+'   ;  ;+  
  ++++ ++++  +++      +.  
  ++++ ++++  +;+'    +,   
             +; +;  +',,  
             +;  + :+++++
"@

Write-Host $logo -ForegroundColor DarkGreen
Write-Host "`n Welcome to the basic (unofficial) K2 prerequisite installer!" -ForegroundColor DarkGreen -BackgroundColor White
}

#
# Confirmation message
#
Function Confirmation {
    $title = "K2 Prerequisites"
    $message = "Do you want to install & configure the basic K2 prerequisites?"

    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Runs the script."
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Stops the script."

    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

    switch ($result)
    {
        0{ InstallAndConfigurePrereqs }
        1{ Write-Host "You manually aborted the script. No changes will be made." -ForegroundColor Yellow }
    }
}

#
# Installation & configuration of the Windows roles & features
#
Function InstallAndConfigurePrereqs {
    Write-Host "Installing & configuring Windows roles & features. This can take some minutes..." -ForegroundColor Yellow

    Write-Host ".NET Framework 3.5 Features (1/13)" -ForegroundColor Yellow
    Add-WindowsFeature NET-Framework-Core
    Add-WindowsFeature NET-Framework-Features
    Add-WindowsFeature NET-HTTP-Activation

    Write-Host ".NET Framework 4.5 Features (2/13)" -ForegroundColor Yellow
    Add-WindowsFeature NET-Framework-45-Features

    Write-Host "Application Server Features (3/13)" -ForegroundColor Yellow
    Add-WindowsFeature AS-NET-Framework
    Add-WindowsFeature AS-Dist-Transaction
    Add-WindowsFeature AS-Incoming-Trans
    Add-WindowsFeature AS-Outgoing-Trans
    Add-WindowsFeature AS-HTTP-Activation
    Add-WindowsFeature AS-MSMQ-Activation
    Add-WindowsFeature AS-Named-Pipes
    Add-WindowsFeature AS-TCP-Activation

    Write-Host "Web Server (IIS) Features (4/13)" -ForegroundColor Yellow
    Add-WindowsFeature Web-Server
    Add-WindowsFeature Web-WebServer

    Write-Host "Common HTTP Features (5/13)" -ForegroundColor Yellow
    Add-WindowsFeature Web-Common-Http
    Add-WindowsFeature Web-Default-Doc
    Add-WindowsFeature Web-Dir-Browsing
    Add-WindowsFeature Web-Http-Errors
    Add-WindowsFeature Web-Static-Content
    Add-WindowsFeature Web-Http-Redirect

    Write-Host "Health and Diagnostics (6/13)" -ForegroundColor Yellow
    Add-WindowsFeature Web-Health
    Add-WindowsFeature Web-Http-Logging
    Add-WindowsFeature Web-Log-Libraries
    Add-WindowsFeature Web-Request-Monitor
    Add-WindowsFeature Web-Http-Tracing

    Write-Host "Performance (7/13)" -ForegroundColor Yellow
    Add-WindowsFeature Web-Performance
    Add-WindowsFeature Web-Stat-Compression
    Add-WindowsFeature Web-Dyn-Compression

    Write-Host "Security (8/13)" -ForegroundColor Yellow
    Add-WindowsFeature Web-Security
    Add-WindowsFeature Web-Filtering
    Add-WindowsFeature Web-Basic-Auth
    Add-WindowsFeature Web-Client-Auth
    Add-WindowsFeature Web-Digest-Auth
    Add-WindowsFeature Web-Cert-Auth
    Add-WindowsFeature Web-IP-Security
    Add-WindowsFeature Web-Url-Auth
    Add-WindowsFeature Web-Windows-Auth

    Write-Host "Application Development (9/13)" -ForegroundColor Yellow
    Add-WindowsFeature Web-App-Dev
    Add-WindowsFeature Web-Net-Ext
    Add-WindowsFeature Web-Net-Ext45
    Add-WindowsFeature Web-AppInit
    Add-WindowsFeature Web-ASP
    Add-WindowsFeature Web-Asp-Net
    Add-WindowsFeature Web-ASP-Net45
    Add-WindowsFeature Web-ISAPI-Ext
    Add-WindowsFeature Web-ISAPI-Filter

    Write-Host "Management Tools (10/13)" -ForegroundColor Yellow
    Add-WindowsFeature Web-Mgmt-Tools
    Add-WindowsFeature Web-Mgmt-Console
    Add-WindowsFeature Web-Mgmt-Compat
    Add-WindowsFeature Web-Scripting-Tools
    Add-WindowsFeature Web-Mgmt-Service

    Write-Host "Message Queuing (11/13)" -ForegroundColor Yellow
    Add-WindowsFeature MSMQ
    Add-WindowsFeature MSMQ-Services
    Add-WindowsFeature MSMQ-Directory

    Write-Host "Telnet (12/13)" -ForegroundColor Yellow
    Add-WindowsFeature Telnet-Client

    Write-Host "Windows Identity Foundation 3.5 (13/13)" -ForegroundColor Yellow
    Add-WindowsFeature Windows-Identity-Foundation

    Write-Host "Windows roles & features changes completed." -ForegroundColor Green

    Write-Host "Configuring Distributed Transaction Coordinator (DTC)..." -ForegroundColor Yellow
    Set-DtcNetworkSetting -DtcName Local -AuthenticationLevel Incoming -InboundTransactionsEnabled $True -OutboundTransactionsEnabled $True -RemoteClientAccessEnabled $True
    Write-Host "DTC changes completed." -ForegroundColor Green

    Write-Host "Configuring Microsoft Message Queue Server (MSMQ)..." -ForegroundColor Yellow
    $MSMQRegKey = "HKLM:\Software\Microsoft\MSMQ\Parameters"
    $MSMQRegKeyParamWorkgroupMode = Get-ItemProperty -Path $MSMQRegKey -Name Workgroup
    if ($MSMQRegKeyParamWorkgroupMode -eq 1)
    {
        Write-Host "No changes to the MSMQ needed." -ForegroundColor Green
    }
    else
    {
        Write-Host "Changing MSMQ workgroup to 0 (Domain mode)..." -ForegroundColor Yellow
        Set-ItemProperty -Path $MSMQRegKey -Name Workgroup -Value 0
    
        Write-Host "Restarting the MSMQ service..." -ForegroundColor Yellow
        Restart-Service -Name MSMQ -Force

        Write-Host "MSMQ changes completed." -ForegroundColor Green
    }

    Write-Host "Basic K2 prerequisite installation & configuration finished. Please check manually to confirm the changes." -ForegroundColor Green
}

#
# Script execution starts here
#
Intro

Confirmation