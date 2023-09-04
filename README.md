# Dot Files Readme

The dotfiles for both local and remote dev setup

## Update OhMyPosh using this command - 
winget upgrade JanDeDobbeleer.OhMyPosh -s winget
Reqs/commands
	PowerShellGet v1.6.0 or higher - can run "Get-Module" without quotes to check
	
    IF lower, run - Install-Module -Name PowerShellGet -Force

## PSReadLine
	Install-Module PSReadLine

(Optional - but recommended) Consider installing CompletionPredictor alongside PSReadLine also
	Install-Module -Name CompletionPredictor -Repository PSGallery


## Importing: PSReadLine
	Import-Module PSReadLine

	Or add it to the top of your $PROFILE, 
	the default location for this is: 

	%%%Documents\PowerShell\Microsoft.PowerShell_profile.ps1

 	If you don't have one this file already, you may need to create one.
	This can be done with the following command: 
	New-Item -Path $profile -Type File -Force

	Add it by opening the file or by running "notepad $PROFILE" (or some text editor/tool to open the $PROFILE [ise $PROFILE, code $PROFILE, etc.]

## Importing: CompletionPredictor 
	Import-Module -Name CompletionPredictor
	Importing this can also be done the same as above, by adding to $PROFILE.

(Optional) Consider moving/redirecting your profile loading to somewhere on local storage for loading speeds
if currently loading from One - Drive or another online source.
	If at ANY STAGE after redirecting your $PROFILE call you happen to run:
	notepad $PROFILE

	You will be opening the END-POINT file, not the re-direct, be aware of this and decide if you wish to move ALL your code to the new file (Recommended)

	To do this, open the base version of $PROFILE from the above step, and use the following command to move the $PROFILE it's loading to location of your choice.
	(Be aware of the tabs, they aren't required in the actual file, just here for readability. Though they make no difference in the function of running in $PROFILE instance.)

	$profile = "C:\Location\Of\Your\Choosing\ProfileHoldingFolder\Microsoft.PowerShell_profile.ps1"
	. $profile


## Oh-My-Posh for prompt styling control etc.
	https://ohmyposh.dev/


For any of the PSReadLine commands that you may find online for custimization from other Uers, ensure you add this to the VERY top of your $PROFILE

### Importing deps
 using namespace System.Management.Automation
 using namespace System.Management.Automation.Language

	These are similar to import statements within Python or JavaScript and allow ease of use on longer commands.


## Oh-My-Posh Config call
 oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\1Custom_Work_powerlevel10k_rainbow.omp.json| Invoke-Expression


## PSReadLine (Imports)
 Import-Module PSReadLine
 Import-Module -Name CompletionPredictor

## PSReadLine Options set
 Set-PSReadlineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView -HistorySearchCursorMovesToEnd
 Set-PSReadLineOption -PredictionViewStyle ListView

## Misc available options: 
-CompletionQueryItems