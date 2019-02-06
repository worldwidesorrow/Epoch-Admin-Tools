dayz_antihack = 0; // Disable vanilla antihack for admins

// Initialize Variables
#include "\z\addons\dayz_server\AdminTools\SuperAdmin\config.sqf"
#include "\z\addons\dayz_server\AdminTools\SuperAdmin\functions.sqf"
#include "\z\addons\dayz_server\AdminTools\SuperAdmin\main.sqf"


[] spawn {
	waitUntil {uiSleep 0.1;(!isNil "Dayz_loginCompleted" && !isNil "keyboard_keys")};
	
	EAT_Keybind = {
		private ["_option","_handled"];
		#include "\ca\editor\Data\Scripts\dikCodes.h"

		_option = _this select 0;
		_handled = false;

		call
		{
			if (_option == "AdminMenu") exitWith {keyboard_keys set [DIK_F2,{call EAT_ToolsMain;_handled = true;}];};
			if (_option == "AdminMode") exitWith {
				keyboard_keys set [DIK_F4,{call optionMenu;_handled = true;}];
				keyboard_keys set [DIK_DELETE,{[] spawn EAT_DeleteObj;_handled = true;}];
				keyboard_keys set [DIK_U,{[] spawn EAT_Unlock;_handled = true;}];
				keyboard_keys set [DIK_L,{[] spawn EAT_Lock;_handled = true;}];
				keyboard_keys set [DIK_J,{call EAT_GetObjDetails;_handled = true;}];
				keyboard_keys set [DIK_T,{[] spawn EAT_TeleportToggle;_handled = true;}];
			};
			if (_option == "EndAdminMode") exitWith {
				keyboard_keys set [DIK_F4,{_handled = true;}];
				keyboard_keys set [DIK_DELETE,{_handled = true;}];
				keyboard_keys set [DIK_U,{_handled = true;}];
				keyboard_keys set [DIK_L,{_handled = true;}];
				keyboard_keys set [DIK_J,{_handled = true;}];
				keyboard_keys set [DIK_T,{_handled = true;}];
				};
			if (_option == "ESP") exitWith {keyboard_keys set [DIK_7,{call F5Menu;_handled = true;}];};
			if (_option == "EndESP") exitWith {keyboard_keys set [DIK_7,{_handled = true;}];};
			if (_option == "Spectate") exitWith {keyboard_keys set [DIK_F6,{spectate = false;_handled = true;}];};
			if (_option == "EndSpectate") exitWith {keyboard_keys set [DIK_F6,{_handled = true;}];};
			if (_option == "FastWalk") exitWith {keyboard_keys set [DIK_4, {call EAT_FastForward;_handled = true;}];};
			if (_option == "EndFastWalk") exitWith {keyboard_keys set [DIK_4, {_handled = true;}];};
			if (_option == "FastUp") exitWith {keyboard_keys set [DIK_5, {call EAT_AdminFastUp;_handled = true;}];};
			if (_option == "EndFastUp") exitWith {keyboard_keys set [DIK_5, {_handled = true;}];};
		};
		_handled
	};

	["AdminMenu"] call EAT_Keybind;
	#include "\z\addons\dayz_server\adminTools\DebugMonitors\debugMonitor2.sqf"
	
	systemChat "Admin Tools Loaded...";
	systemChat "Press F2 to Open the Admin Menu";
	diag_log("Admin Tools: AdminActivate.sqf loaded");
};
