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
   
$FileLocation = 'C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.pkgundef'
$DarkThemeRemovalKey = '\[\$RootKey\$\\Themes\\{1ded0138-47ce-435e-84ef-9ec1f439b749\}\]'
$CommentOutDarkThemeRemovalKey = '// [$RootKey$\Themes\{1ded0138-47ce-435e-84ef-9ec1f439b749}]'
((gc $FileLocation) -replace $DarkThemeRemovalKey, $CommentOutDarkThemeRemovalKey) | sc $FileLocation
Write-Host 'ssms.pkgundef file successfully changed'
Write-Host 'SSMS Dark Theme Activated'
Read-Host -Prompt 'Press Enter to exit'