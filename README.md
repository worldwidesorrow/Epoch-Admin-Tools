Epoch Admin Tools V-1.11.1
=================

![Admin Tools](http://i.imgur.com/j0bTHPB.png)

([Click here for more screenshots](http://imgur.com/a/RH4cx#0))

This is an admin menu with powerful tools for the purpose of testing and/or administrating a [DayZ Epoch Mod](http://epochmod.com/) server. Most tools will also be compatible with original DayZMod servers and other derivatives.

***You may use this script free of charge and modify for your own needs, however you MAY NOT distribute this code or any modified versions of it without my permission.*** If you have new features you think people may benefit from please open a pull request to have it added to this tool. The main reason for this is to be sure the tool is of the best possible quality and that harmful code is not distributed under the guise of my work. 
If you are worried about the integrity of the dll files look at the change log for MD5 hash values.

# Table of Contents:
* [Features](https://github.com/noxsicarius/Epoch-Admin-Tools#features)
* [Installing the tool](https://github.com/noxsicarius/Epoch-Admin-Tools#installation)
* [Updating the tool](https://github.com/noxsicarius/Epoch-Admin-Tools#updating)
* [FAQ](https://github.com/noxsicarius/Epoch-Admin-Tools#faq)
* [Error Reporting](https://github.com/noxsicarius/Epoch-Admin-Tools#error-reporting)
* [Credits](https://github.com/noxsicarius/Epoch-Admin-Tools#credits)

# Features:
#### For help with Administration:
* Multiple Admin levels
* Spectate players
* "Display code" for locked vaults/doors
* "Create key" for vehicles with lost keys
* Base management - Copy/Paste/Export/Import/Delete bases
* Spawn crates with weapons, items, and supplies
* Spawn vehicles via the menu or a custom-made graphical vehicle menu ([screenshot](https://f.cloud.github.com/assets/204934/2233637/43153c0a-9b2c-11e3-8a03-40d11239e1cb.png)) (Thanks @Sandbird!)
* Log admin tool use to combat possible abuse of the tool


#### Other features:
* Godmode
* Teleport
* Flying
* Invisibility
* Infinite Ammo / No recoil
* Change skins
* Delete, repair/refuel vehicle
* Heal players
* ESP - display players and objects on the map
* Spawn temporary buildings on the map
* ...and more!



# Installation


1. Click ***[Download Zip](https://github.com/gregariousjb/Epoch-Admin-Tools/archive/master.zip)*** on the right sidebar of this Github page.

	> Recommended PBO tool for all "pack", "repack", or "unpack" steps: ***[PBO Manager](http://www.armaholic.com/page.php?id=16369)***

1. Log into your server via FTP or your host's File Manager. Locate, download, and unpack (using PBO Manager or a similar PBO editor) your ***MPMissions/Your_Mission.pbo***, and open the resulting folder.
 
	> Note: "Your_Mission.pbo" is a placeholder name. Your mission might be called "DayZ_Epoch_11.Chernarus", "DayZ_Epoch_13.Tavi", or "dayz_mission" depending on hosting and chosen map.

1. If you are allowed to use custom dll's (some hosts forbid it)
	
	> Copy all files ***inside the DLL folder*** (not the folder itself) to your ROOT server folder (where arma2oaserver.exe and @DayZ_Epoch is located)

	>> IMPORTANT: You may need to allow the dll through your antivirus because some antivirus block unknown dll's.
	 			  Windows may also require you to unblock it by right clicking it, selecting properties, and selecting unblock
	
1. Open the ***init.sqf*** in the root of your mission folder.

	Find the following line:

	```sqf
	execFSM "\z\addons\dayz_code\system\player_monitor.fsm";
	```
	
	Add these lines ***above*** it:
	
	```sqf
	"EAT_login" addPublicVariableEventHandler {call (_this select 1)};
	EAT_clientToServer = ["login", player];
	publicVariableServer "EAT_clientToServer";
	```
	
	Find the following line:
	
	```sqf
	waitUntil {scriptDone progress_monitor};
	```
	
	Add this line ***above** it. NOTE: this line may already be there from a prior script install.
	
	```sqf
	[] execVM "dayz_code\compile\remote_message.sqf";
	```
	
1. Save init.sqf

1. Open file ***description.ext*** in the root of your mission folder.

	Add this line to the bottom of the file and save the file.
	
	```sqf
	#include "dialog.hpp"
	```
	
1. Copy file ***dialog.hpp*** over to the root of your mission folder.
	
1. If you do not have file ***dayz_code\compile\remote_message.sqf*** in your mission folder copy it over from the download.

1. Repack your mission PBO.

1. Unpack your server PBO. You should end up with a folder called dayz_server.

1. Copy the ***AdminTools*** folder over to the dayz_server folder.

1. Open file ***init\server_functions.sqf***

	Add this line to the very top:
	
	```sqf
	#include "\z\addons\dayz_server\adminTools\init.sqf"
	```
	
	Find the following block of code:
	
	```sqf
	//Buildings
	if (_object isKindOf "DZ_buildables") then {
		_saveObject = "DZ_buildables";
		_allowed = true;
	};
	```
	
	Add the following block of code ***below*** it:
	
	```sqf
	// EAT Buildings
	if (_object getVariable ["EAT_Building",0] == 1) then {
		_saveObject = "EAT_Building";
		_object setVariable ["EAT_Building",nil];
		_allowed = true;
	};
	```
	
1. Open file ***dayz_server\AdminTools\init.sqf***

	At the top of the file there is a section of code that looks like this:
	
	```sqf
	#define ADMIN_LIST ["76500000000000000","76500000000000000","76500000000000000"]
	#define ADMIN_NAMES ["AdminName,"AdminName","AdminName"]
	#define MOD_LIST ["76500000000000000","76500000000000000","76500000000000000"]
	#define MOD_NAMES ["ModeratorName","ModeratorName","ModeratorName"]
	```
	
	Add your player UID and name to the appropriate permissions. In order to get admin or moderator privileges
	on the server you must add your name and player UID to both (ADMIN_LIST - ADMIN_NAMES) or (MOD_LIST - MOD_NAMES).
	DO NOT ADD TO BOTH!
	Note: the SuperAdmin feature adds the base manager and the ability to spawn and save buildings to the map.
	It is currently still under development which is why it is commented out. Do not add your name and UID toggled
	SuperAdmin at this time.
	
1. Repack your server PBO.

1. Copy the 3 files contained in the downloaded Battleye folder into your Battleye folder to overwrite them.
	

Keybindings

NOTE: The keys other than F2 are disabled when admin mode is turned off.


	```sqf
	F2  	- Activate admin tools
	F4  	- Admin mode/mod mode options - when toggled on
	F6  	- Cancel spectate
	T  		- Admin teleport
	4		- FastWalk
	5		- FastUp
	7   	- Enhanced ESP options - when toggled on
	U   	- Unlock vehicle/safe/lockbox/door
	L   	- Lock vehicle/safe/lockbox/door
	J   	- Display object information in systemchat
	Del 	- Delete object
	Ins 	- Toggle Debug
	q,w,a,s,d, and space bar are used if flying is toggled on
	```

## Install finished

#### View the [Epoch Admin Tools Wiki](https://github.com/gregariousjb/Epoch-Admin-Tools/wiki) for additional configuration options and help.

# Updating

### Current version only works with epoch 1.0.6+ so no mod update is needed. Use a fresh install.
### If you want the 1.0.5 version go to the releases tab for this repo on github


## FAQ
* I'm getting kicked with "Script Restriction #X"!
 * Make sure you've installed the Battleye filters perfectly in the instructions. If it still fails, you can fix the error yourself with a little knowledge about [how the filters work](http://dayz.st/w/Battleye_Filters).
* The menu doesn't appear.
 * The most likely cause of this error is either a syntax error in your ***init.sqf*** (e.g. a missing semi-colon), a syntax error in your ***admintools\config.sqf*** (e.g. a comma after the last string in the array of Admins/Mods - see above optional instruction) or forgetting to add your Player ID (or typing it wrong) into the ***admintools\config.sqf***. Specific errors can be found by reading your server's [RPT file](https://community.bistudio.com/wiki/arma.RPT). Also see [Debugging Techniques](https://community.bistudio.com/wiki/Debugging_Techniques).
* I get stuck at the loading screen with the arma2oaserver.rpt error that I am missing files.
 * This is most often caused by a broken PBO packaging tool. Reinstall or use a different tool.
* How do I add something to my personal tools?
 * This is found in the [Epoch Admin Tools Wiki](https://github.com/gregariousjb/Epoch-Admin-Tools/wiki)
 
## Error Reporting
#### BEFORE posting an issue on Github or on [the main discussion forum](http://epochmod.com/forum/index.php?/topic/7501-release-epoch-admin-tools/):

* Review the installation instructions and be sure you've done every step EXACTLY as stated. They are not forgiving. If one step is done incorrectly, it won't work.
* If you think you might have installed it incorrectly, follow the [YouTube Video Install Tutorial](http://youtu.be/hV_vwvp_vFs)
* Check your server's RPT log for errors. This will identify 99% of problems with the menu. Be ready to copy/paste the RPT log into [Pastebin](http://pastebin.com/) or [Gist](https://gist.github.com/) in an issue or in the discussion forum for help with troubleshooting.
* If all else fails, install these tools onto a fresh, unedited mission.pbo and server.pbo to get it working, then start installing additional addons/mods one at a time until the admin tools break in order to identify the conflict.

#### If your problem persists after doing the above:
* Do a quick search on [the main discussion forum](http://epochmod.com/forum/index.php?/topic/7501-release-epoch-admin-tools/) for a fix to your problem.  
* If you do not find a fix to your problem: post your problem on [the main discussion forum](http://epochmod.com/forum/index.php?/topic/7501-release-epoch-admin-tools/)
* If the problem you are posting is a bug and not a general install problem then post it to [the main discussion forum](http://epochmod.com/forum/index.php?/topic/7501-release-epoch-admin-tools/) and to [the github issues page](https://github.com/gregariousjb/Epoch-Admin-Tools/issues?state=open).

## Credits
This project is based heavily on [Malory's Custom Epoch Admin Tools](https://github.com/iforgotmywhat/Dayz-Epoch-Admin-Tools/), which itself is based on [BluePhoenix Admin Tools](https://github.com/BluePhoenix175/DayZ-Admin-Tools-).

* Project Leader: NoxSicarius (Nox)
* A huge thanks goes out to Gregarious who began this project and did a huge amount of work on the tool. We were sad to see him go, but his generous contributions will be remembered.
