Import-Module ServerManager

Write-Host "Installing Windows roles & features. This can take some minutes ..." -ForegroundColor Green

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

Write-Host "Web Server (IIS) features (4/13)" -ForegroundColor Yellow
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


Write-Host " Installation done (7/7)" -ForegroundColor Green