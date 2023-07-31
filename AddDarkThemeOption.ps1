# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
 
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
 
   {
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "Black"
   clear-host
 
   }
else
   {
   # We are not running "as Administrator" - so relaunch as administrator
   
   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
 
   # Specify the current script path and name as a parameter
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
 
   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";
 
   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);
 
   # Exit from the current, unelevated, process
   exit
 
   }
# Indicate to user we are now running as administrator

Write-Host 'Administrator mode activated.'
#$SSMSVersion = 18 
$FileLocation = 'C:\Program Files (x86)\Microsoft SQL Server Management Studio ' + $SSMSVersion + '\Common7\IDE\ssms.pkgundef'
$DarkThemeRemovalKey = '\[\$RootKey\$\\Themes\\{1ded0138-47ce-435e-84ef-9ec1f439b749\}\]'
$VersionPath = Get-ChildItem -Path "C:\Program Files (x86)\Microsoft SQL Server Management Studio*" -Filter *.pkgundef -Recurse | %{$_.FullName}
$UserSSMSVersion = $VersionPath.Split('\', 4)[-2].Substring($VersionPath.Split('\', 4)[-2].length - 2, 2)
$VersionsMatch = $false
$CommentOutDarkThemeRemovalKey = '// [$RootKey$\Themes\{1ded0138-47ce-435e-84ef-9ec1f439b749}]' 

Write-Host 'Default SSMS Version: '$SSMSVersion
Write-Host 'Your current SSMS Version: '$UserSSMSVersion

# Check if versions match and update if they do not match 
while($VersionsMatch -eq $false -And $SSMSVersion -ne $UserSSMSVersion) {
	Write-Output "`nSSMS version numbers do not match."
	$SSMSVersion = Read-Host -Prompt 'Enter your version number'
	
	if ($SSMSVersion -eq $UserSSMSVersion) {
		$VersionsMatch = $true
		# Update filepath based on version number 
		$FileLocation = 'C:\Program Files (x86)\Microsoft SQL Server Management Studio ' + $SSMSVersion + '\Common7\IDE\ssms.pkgundef'
	}
}

# Check if file path exists 
if (Test-Path -Path $FileLocation) {
	# Enable dark theme 	
	((gc $FileLocation) -replace $DarkThemeRemovalKey, $CommentOutDarkThemeRemovalKey) | sc $FileLocation
	Write-Output "`nssms.pkgundef file successfully changed"
	Write-Output "SSMS Dark Theme Activated`n"
	Read-Host -Prompt 'Press Enter to exit'
	
} else {
	# Show user their SSMS path
	Write-Output "`nDark Theme Activation Failed!!!!"
	Read-Host -Prompt 'Press Enter to exit'
}
