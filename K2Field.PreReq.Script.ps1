# Script:	K2Field.PreReq.Script.ps1
# Author: 	Tim Huttemeister, K2
# Website: 	http://www.timhuttemeister.com
# Purpose: 	Check if all K2 prerequisites are installed & install and configure the basic K2 prerequisites properly.
# Version:  1.5
# Date:     2016-07-14
# Changes:  New function for checking which features are (not) installed.
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
    $message = "Do you want to install the basic K2 prerequisites?"

    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Runs the script."
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Stops the script."
    $checkPrereqisites = New-Object System.Management.Automation.Host.ChoiceDescription "&CheckFeatures", "Checks if all K2 prerequisites are installed."

    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $checkPrereqisites)
    $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

    switch ($result)
    {
        0{ InstallAndConfigurePrereqs }
        1{ Write-Host "You manually aborted the script. No changes will be made." -ForegroundColor Yellow }
        2{ CheckPrerequisites }
    }
}

#
# Check all prerequisites
#
Function CheckPrerequisites {    
    ForEach ($item In $csv)
    {
        $windowsFeature=Get-WindowsFeature | Where-Object {$_.Name -eq $item.FeatureName}
        If($windowsFeature.Installed -ne "True")
        {
            Write-Host "Feature $($item.FeatureName) IS NOT installed." -ForegroundColor Red
            $missingFeaturesList += $item.FeatureName
        }
        Else
        {
            Write-Host "Feature $($item.FeatureName) is installed." -ForegroundColor Green
        }
    }

    # Get user input for next steps
    If($missingFeaturesList.Count -gt 0)
    {
        $title = "Missing K2 Prerequisites"
        $message = "Do you directly want to install the missing K2 prerequisites?"

        $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Installs the missing prerequisites."
        $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Stops the script."

        $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
        $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

        switch ($result)
        {
            0{ InstallAndConfigurePrereqs $true }
            1{ Write-Host "You manually aborted the script. No changes will be made." -ForegroundColor Yellow }
        }
    }
}

#
# Installation & configuration of the Windows roles & features
#
Function InstallAndConfigurePrereqs([bool]$installMissing = $false)
{
    Write-Host "Installing & configuring Windows roles & features. This can take some minutes..." -ForegroundColor Yellow
    If($installMissing -ne "True")
    {
        ForEach ($item In $csv)
        {
            # Output feature category
            IF($item.FeatureCategory -ne $lastFeatureCategory)
            {
                Write-Host "Feature category: $($item.FeatureCategory)" -ForegroundColor Yellow
                $lastFeatureCategory = $item.FeatureCategory
            }
            Add-WindowsFeature $item.FeatureName
        }
    }
    Else
    {
        ForEach ($feature in $missingFeaturesList)
        {
            Add-WindowsFeature $feature
        }
    }

    Write-Host "Windows roles & features changes completed." -ForegroundColor Green
    Write-Host "Basic K2 prerequisite installation & configuration finished. Please check manually to confirm the changes." -ForegroundColor Green
}

# Script execution starts here
# Get CSV file path for later use & create empty array for missing features
$path                   = Split-Path -parent $MyInvocation.MyCommand.Definition 
$newPath                = $path + "\prerequisites.csv"
$csv                    = @()
$csv                    = Import-Csv -Path $newPath
# Initiate the hash table for our missing features list
$missingFeaturesList    = @()

# Show intro screen and get user input
Intro
Confirmation