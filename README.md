# K2Field.PreReq #

### Summary ###
PowerShell script to install & configure basic prerequisites for K2 (Windows roles &amp; features).

### Applies to ###
- Windows Server 2012
- Windows Server 2012 R2
- Windows Server 2014

### Windows Roles & Features Installed ###
##### .NET Framework 3.5 Features #####
Role/Feature |
---------|
NET-Framework-Core |
NET-Framework-Features |
NET-NET-HTTP-Activation |
NET-Framework-45-Features |

##### Application Server Features #####
Role/Feature |
---------|
AS-NET-Framework |
AS-Dist-Transaction |
AS-Incoming-Trans |
AS-Outgoing-Trans |
AS-HTTP-Activation |
AS-MSMQ-Activation |
AS-Named-Pipes |
AS-TCP-Activation |

##### Web Server (IIS) Features #####
Role/Feature |
---------|
Web-Server |
Web-WebServer |

##### Common HTTP Features #####
Role/Feature |
---------|
Web-Common-Http |
Web-Default-Doc |
Web-Dir-Browsing |
Web-Http-Errors |
Web-Static-Content |
Web-Http-Redirect |

##### Health and Diagnostics #####
Role/Feature |
---------|
Web-Health |
Web-Http-Logging |
Web-Log-Libraries |
Web-Request-Monitor |
Web-Http-Tracing |

##### Performance #####
Role/Feature |
---------|
Web-Performance |
Web-Stat-Compression |
Web-Dyn-Compression |

##### Security #####
Role/Feature |
---------|
Web-Security |
Web-Filtering |
Web-Basic-Auth |
Web-Client-Auth |
Web-Digest-Auth |
Web-Cert-Auth |
Web-IP-Security |
Web-Url-Auth |
Web-Windows-Auth |

##### Application Development #####
Role/Feature |
---------|
Web-App-Dev |
Web-Net-Ext |
Web-Net-Ext45 |
Web-AppInit |
Web-ASP |
Web-Asp-Net |
Web-ASP-Net45 |
Web-ISAPI-Ext |
Web-ISAPI-Filter |

##### Management Tools #####
Role/Feature |
---------|
Web-Mgmt-Tools |
Web-Mgmt-Console |
Web-Mgmt-Compat |
Web-Scripting-Tools |
Web-Mgmt-Service |

##### Message Queuing #####
Role/Feature |
---------|
MSMQ |
MSMQ-Services |
MSMQ-Directory |

##### Telnet #####
Role/Feature |
---------|
Telnet-Client |

##### Windows Identity Foundation 3.5 #####
Role/Feature |
---------|
Windows-Identity-Foundation |

### Disclaimer ###
**THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF ANY KIND. IT'S NOT AN OFFICIALL REPOSITORY FROM K2 AND THEREFORE NOT SUPPORTED BY K2.**

----------

# INSTALLATION #
1. Download the "K2Field.PreReq.Script.ps1" PowerShell file
2. Open the PowerShell console in Admin Mode
3. Navigate to the script folder and run the script

# Contributing #
If you want to contribute to this	 project, simply clone the repository and send a pull request with your changes.

----------

# License #
See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).