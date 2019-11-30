// This file is the work of ebayShopper. Modified for use with Epoch Admin Tools by JasonTM.

#define KICK_VARIABLES []
#define KICK_DISPLAYS [30,                     32,              45,                     125,                       140,                    155,                   156,                    1001,               2929,               3030,					13000,		14000]
//                    [RscDisplayTemplateLoad, RscDisplayIntel, RscDisplayArcadeMarker, RscDisplayEditDiaryRecord, RscDisplaySingleplayer, RscDisplayDSinterface, RscDisplayAddonActions, RscDisplayWFVoting, RscFunctionsViewer, RscConfigEditor_Main, EATDialog,  BaseManager]
#define CONVERT(s) format["%1",s]

PVDZ_fail = nil; // Make logging by client slightly harder (recommend minimizing this file to reduce network send size)
dayz_antihack = 1; // Enable vanilla AC on this client, regardless of init.sqf setting. Changing value after scheduler start has no effect.

if (!isNil "tk_ac") then {diag_log "ERROR: AC reinitialized"};
tk_ac = "started";

[
	getPlayerUID player,
	CONVERT(fnc_usec_damageHandler),
	CONVERT(player_fired),
	CONVERT(player_death),
	getMarkerPos "respawn_west",
	CONVERT(fnc_usec_unconscious),
	CONVERT(fnc_veh_handleDam),
	CONVERT(fnc_veh_handleKilled),
	CONVERT(player_zombieAttack),
	CONVERT(player_zombieCheck),
	CONVERT(DZ_KeyDown_EH)
] spawn {
	private ["_charID","_damageHandler","_firedHandler","_isPZombie","_keyDown","_killedHandler","_name",
	"_reason","_respawn","_type","_uid","_unconscious","_vehicleDamage","_vehicleKilled","_zFind","_zTarget","_startTime","_done"];
	
	_uid = _this select 0;
	_damageHandler = _this select 1;
	_firedHandler = _this select 2;
	_killedHandler = _this select 3;
	_respawn = _this select 4;
	_unconscious = _this select 5;
	_vehicleDamage = _this select 6;
	_vehicleKilled = _this select 7;
	_zTarget = _this select 8;
	_zFind = _this select 9;
	_keyDown = _this select 10;
	
	waitUntil {!isNil "Dayz_loginCompleted"};
	
	_charID = CONVERT(dayz_characterID);
	_name = if (alive player) then {name player} else {"DeadPlayer"};
	_isPZombie = player isKindOf "PZombie_VB";

	while {true} do {
		
		_type = typeOf player;
		_reason = switch true do {
			case (_charID != CONVERT(dayz_characterID)): {"Dayz_characterID modified"};
			case (_uid != CONVERT(dayz_playerUID)): {"Dayz_playerUID modified"};
			//case (_damageHandler != CONVERT(fnc_usec_damageHandler)): {"DamageHandler modified"}; // disabled this line for safezones.
			case (_firedHandler != CONVERT(player_fired)): {"FiredHandler modified"};
			case (_killedHandler != CONVERT(player_death)): {"KilledHandler modified"};
			case (_unconscious != CONVERT(fnc_usec_unconscious)): {"Unconscious modified"};
			case (_vehicleDamage != CONVERT(fnc_veh_handleDam)): {"VehicleDamage modified"};
			case (_vehicleKilled != CONVERT(fnc_veh_handleKilled)): {"VehicleKilled modified"};
			case (_zTarget != CONVERT(player_zombieAttack)  && !_isPZombie): {"ZombieTarget modified"};
			case (_zFind != CONVERT(player_zombieCheck) && !_isPZombie): {"ZombieFind modified"};
			case (_keyDown != CONVERT(DZ_KeyDown_EH)): {"KeyDown modified"};
			case (_type == "Survivor1_DZ"): {"Survivor1_DZ morph"};
			case (_type isKindOf "Animal"): {"Animal morph"};
			case (getMarkerPos "respawn_west" distance _respawn > 0): {"Respawn moved"};
			default {"none"};
		};
		{
			if (!isNull findDisplay _x) then {
				_reason = format["Display%1",_x];
			};
		} count KICK_DISPLAYS;
		{
			if (!isNil _x) then {
				_reason = format["Variable %1",_x];
			};
		} count KICK_VARIABLES;
		
		if !(commandingMenu == "") then {
			_reason = format["CommandingMenu %1",commandingMenu];
		};
		
		if (_reason != "none") exitWith {
			PVDZ_sec_atp = format["TK_AC_KICK - %1(%2) %3",_name,_uid,_reason];
			publicVariableServer "PVDZ_sec_atp"; //Log to server RPT
			uiSleep 1; // Wait for PV to send
			call compile format["TK_AC_KICK%1'%2(%3) %4'","=",_name,_uid,_reason]; //Recommend adding "TK_AC_KICK=" to scripts.txt and BEC ScriptBan
			uiSleep 1; // Wait for scripts.txt trigger
			TK_AC_KICK = ";";
			publicVariableServer "TK_AC_KICK"; // Trigger PV kick
			uiSleep 1;
			{(findDisplay _x) closeDisplay 2;} count [0,8,12,18,46,70]; // Last resort if no BE
		};
		
		uiSleep 4;
	};
};

#include "\z\addons\dayz_server\adminTools\DebugMonitors\debugMonitor2.sqf"
