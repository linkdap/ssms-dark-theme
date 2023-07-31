# ssms-dark-theme
Powershell script to enable the dark color theme in Microsoft SQL Server Management Studio

## Updates
| Date | Change Made |
| --- | --- |
| 07.31.2023 | <ul><li>Removed hard coded SSMS version in file directory path</li><li>script checks which version of SSMS is installed on user's machine</li><li>script does not allow user to proceed until they enter their current version of SSMS</li><li>script updates the directory path and checks the file location of the ssms.pkgundef file exists before activating the Dark theme</li> |

## Current Issues
None

## Past Issues
* [Cannot find path 'C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.pkgundef' because it does not exist](https://github.com/linkdap/ssms-dark-theme/issues/1)

![image](https://github.com/linkdap/ssms-dark-theme/assets/63880835/fd92f80a-bd05-45cd-8288-8513024beda0)
