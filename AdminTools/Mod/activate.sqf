dayz_antihack = 0; // Disable vanilla antihack for admins and mods

// Load Configs and Functions
#include "\z\addons\dayz_server\AdminTools\Mod\config.sqf"
#include "\z\addons\dayz_server\AdminTools\Mod\functions.sqf"
#include "\z\addons\dayz_server\AdminTools\Mod\main.sqf"




[] spawn {
	waitUntil {uiSleep 0.1;(!isNil "Dayz_loginCompleted" && !isNil "keyboard_keys")};
	
	EAT_Keybind = {
		private ["_option","_handled"];
		#include "\ca\editor\Data\Scripts\dikCodes.h"

		_option = _this select 0;
		_handled = false;

		call
		{
			if (_option == "ModMenu") exitWith {keyboard_keys set [DIK_F2,{call EAT_ToolsMain;_handled = true;}];};
			if (_option == "ModMode") exitWith {
				keyboard_keys set [DIK_F4,{call optionMenu;_handled = true;}];
				keyboard_keys set [DIK_DELETE,{[] spawn EAT_DeleteObj;_handled = true;}];
				keyboard_keys set [DIK_U,{[] spawn EAT_Unlock;_handled = true;}];
				keyboard_keys set [DIK_L,{[] spawn EAT_Lock;_handled = true;}];
				keyboard_keys set [DIK_T,{[] spawn EAT_TeleportToggle;_handled = true;}];
			};
			if (_option == "EndModMode") exitWith {
				keyboard_keys set [DIK_F4,{_handled = true;}];
				keyboard_keys set [DIK_DELETE,{_handled = true;}];
				keyboard_keys set [DIK_U,{_handled = true;}];
				keyboard_keys set [DIK_L,{_handled = true;}];
				keyboard_keys set [DIK_T,{_handled = true;}];
				};
			if (_option == "Spectate") exitWith {keyboard_keys set [DIK_F6,{spectate = false;_handled = true;}];};
			if (_option == "EndSpectate") exitWith {keyboard_keys set [DIK_F6,{_handled = true;}];};
			if (_option == "FastWalk") exitWith {keyboard_keys set [DIK_4, {call EAT_FastForward;_handled = true;}];};
			if (_option == "EndFastWalk") exitWith {keyboard_keys set [DIK_4, {_handled = true;}];};
			if (_option == "FastUp") exitWith {keyboard_keys set [DIK_5, {call EAT_AdminFastUp;_handled = true;}];};
			if (_option == "EndFastUp") exitWith {keyboard_keys set [DIK_5, {_handled = true;}];};
		};
		_handled
	};
	
	// Bind F2 key for mod menu
	["ModMenu"] call EAT_Keybind;
	
	// Start Debug Monitor
	#include "\z\addons\dayz_server\adminTools\DebugMonitors\debugMonitor2.sqf"
	
	systemChat "Moderator Tools Loaded...";
	systemChat "Press F2 to Open the Moderator Menu";
	diag_log("Moderator Tools: ModActivate.sqf loaded");
};
