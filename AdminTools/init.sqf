// Add UIDs and names of Admins and Mods Here. If an admin or mod wants to play with no admin tools, change name in profile.
#define SUPER_ADMIN_LIST ["76500000000000000","76500000000000000","76500000000000000"]
#define SUPER_ADMIN_NAMES ["SuperAdminName","SuperAdminName","SuperAdminName"]
#define ADMIN_LIST ["76500000000000000","76500000000000000","76500000000000000"]
#define ADMIN_NAMES ["AdminName","AdminName","AdminName"]
#define MOD_LIST ["76500000000000000","76500000000000000","76500000000000000"]
#define MOD_NAMES ["ModeratorName","ModeratorName","ModeratorName"]

// These variables are used in the AI spawner. You can adjust them.
EAT_HumanityGainLoss = 25;
EAT_aiDeleteTimer = 600;

// DO NOT EDIT BELOW THIS LINE

"EAT_clientToServer" addPublicVariableEventHandler {
	private ["_array","_type","_activatingPlayer","_playerUID"];
	_array = _this select 1;
	_type = _array select 0;
	_activatingPlayer = _array select 1;
	_playerUID = getPlayerUID _activatingPlayer;
	
	if ((count _array == 2) && (_type == "login")) then {
		{
			if (_playerUID == getPlayerUID _x) exitWith {
				call
				{
					if ((getPlayerUID _x) in SUPER_ADMIN_LIST && (name _x) in SUPER_ADMIN_NAMES) exitWith {
						EAT_login = {
							#include "\z\addons\dayz_server\AdminTools\SuperAdmin\activate.sqf"
						};
						(owner _x) publicVariableClient "EAT_login";
					};
					
					if ((getPlayerUID _x) in ADMIN_LIST && (name _x) in ADMIN_NAMES) exitWith {
						EAT_login = {
							#include "\z\addons\dayz_server\AdminTools\Admin\activate.sqf"
						};
						(owner _x) publicVariableClient "EAT_login";
					};
					
					if ((getPlayerUID _x) in MOD_LIST && (name _x) in MOD_NAMES) exitWith {
						EAT_login = {
							#include "\z\addons\dayz_server\AdminTools\Mod\activate.sqf"
						};
						(owner _x) publicVariableClient "EAT_login";
					};
					
					EAT_login = {
						#include "\z\addons\dayz_server\adminTools\AntiCheat\antiCheat.sqf"
					};
					(owner _x) publicVariableClient "EAT_login";
				};
			};
		} count playableUnits;
	};
	
	
	if (count _array > 2) then {
		
		_params = _array select 2;
		_clientKey = _array select 3;
		
		// First line of defense
		if (!((_playerUID) in SUPER_ADMIN_LIST) && !((_playerUID) in ADMIN_LIST) && !((_playerUID) in MOD_LIST)) exitWith {diag_log format["ADMIN TOOLS: unauthorized use by %1, %2",_playerUID, (name _activatingPlayer)];};
		
		if (_type == "tempVeh") exitWith {
			#include "\z\addons\dayz_server\adminTools\ServerFunctions\vehSpawn.sqf"
		};
		if (_type == "addAI") exitWith {
			#include "\z\addons\dayz_server\adminTools\ServerFunctions\aiSpawn.sqf"
		};
		if (_type == "crate") exitWith {
			#include "\z\addons\dayz_server\adminTools\ServerFunctions\crateSpawn.sqf"
		};
		if (_type == "invisibility") exitWith {
			private ["_hide","_position","_isActive"];
			_isActive = _params select 0;
			_position = _params select 1;
			
			_exitReason = [_this,"EAT_invisibility",_position,_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
			if (_exitReason != "") exitWith {diag_log _exitReason};
			
			_activatingPlayer setVehicleInit format["this hideObject %1;",_isActive];
			processInitCommands;
			clearVehicleInit _activatingPlayer;
		};
		// Have the server spawn the transparent red globes to avoid BattlEye kicks
		if (_type == "Base Manager") exitWith {
			local _radius = _params select 0;
			local _center = _params select 1;
			local _pos = _params select 2;
			
			_exitReason = [_this,"Base Manager",_pos,_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
			if (_exitReason != "") exitWith {diag_log _exitReason};
			
			[_radius,_center, _pos] spawn {
				private ["_obj","_center","_a","_b","_radius","_angle","_count","_objects","_isWater"];
				_radius = _this select 0;
				_center = _this select 1;
				_angle = 0;
				_count = round((2 * pi * _radius) / 2);
				_objects = [];
				_isWater = surfaceIsWater (_this select 2);
				for "_x" from 0 to _count do
				{
					_a = (_center select 0) + (sin(_angle)*_radius);
					_b = (_center select 1) + (cos(_angle)*_radius);
					_obj = "Sign_sphere100cm_EP1" createVehicle [0,0,0];
					if (_isWater) then {
						_obj setPosASL [_a, _b, _center select 2];
					} else {
						_obj setPosATL [_a, _b, _center select 2];
					};
					//_obj setPosASL [_a, _b, _center select 2];
					_objects set [count _objects, _obj];
					_angle = _angle + (360/_count);
				};
				
				for "_x" from 0 to _count do
				{
					_a = (_center select 0) + (sin(_angle)*_radius);
					_b = (_center select 2) + (cos(_angle)*_radius);
					_obj = "Sign_sphere100cm_EP1" createVehicle [0,0,0];
					//_obj setPosASL [_a, _center select 1, _b];
					if (_isWater) then {
						_obj setPosASL [_a, _center select 1, _b];
					} else {
						_obj setPosATL [_a, _center select 1, _b];
					};
					_objects set [count _objects, _obj];
					_angle = _angle + (360/_count);
				};
				
				for "_x" from 0 to _count do
				{
					_a = (_center select 1) + (sin(_angle)*_radius);
					_b = (_center select 2) + (cos(_angle)*_radius);
					_obj = "Sign_sphere100cm_EP1" createVehicle [0,0,0];
					//_obj setPosASL [_center select 0, _a, _b];
					if (_isWater) then {
						_obj setPosASL [_center select 0, _a, _b];
					} else {
						_obj setPosATL [_center select 0, _a, _b];
					};
					_objects set [count _objects, _obj];
					_angle = _angle + (360/_count);
				};

				uiSleep 30;
				{deleteVehicle _x; true } count _objects;
			};
		};
		if (_type == "ServerMessage") exitWith {
			private ["_message","_args"];
			_message = _params select 0;
			_message = format["ADMIN:%1",_message];
			
			_exitReason = [_this,"ServerMessage",getPos _activatingPlayer,_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
			if (_exitReason != "") exitWith {diag_log _exitReason};
			
			_args = ["0.40","#FFFFFF","0.70","#990000",0,-.3,10,0.5];
			RemoteMessage = ["dynamic_text",["",_message],_args];
			publicVariable "RemoteMessage";
		};
		if (_type == "Date") exitWith {
			private ["_moon","_time"];
			_moon = _params select 0;
			_time = _params select 1;
			_exitReason = [_this,"SetDate",getPos _activatingPlayer,_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
			if (_exitReason != "") exitWith {diag_log _exitReason};
			dayzSetDate = [2012,6,_moon,_time,1];
			publicVariable "dayzSetDate";
			setDate dayzSetDate;
		};
		if (_type == "Fog") exitWith {
			private ["_value","_time"];
			_value = _params select 0;
			_time = _params select 1;
			
			_exitReason = [_this,"SetFog",getPos _activatingPlayer,_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
			if (_exitReason != "") exitWith {diag_log _exitReason};
			
			drn_DynamicWeatherEventArgs = [overcast,fog,rain,"FOG",_value,_time,-1,-1];
			publicVariable "drn_DynamicWeatherEventArgs";
			drn_DynamicWeatherEventArgs call drn_fnc_DynamicWeather_SetWeatherLocal;
		};
		//[current overcast, current fog, current rain, current weather change ("OVERCAST", "FOG" or ""), target weather value, time until weather completion (in seconds), current wind x, current wind z]
		if (_type == "Cloud") exitWith {
			private ["_value","_time"];
			_value = _params select 0;
			_time = _params select 1;
			
			_exitReason = [_this,"SetWeather",getPos _activatingPlayer,_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
			if (_exitReason != "") exitWith {diag_log _exitReason};
			
			drn_DynamicWeatherEventArgs = [overcast,fog,rain,"OVERCAST",_value,_time,-1,-1];
			publicVariable "drn_DynamicWeatherEventArgs";
			drn_DynamicWeatherEventArgs call drn_fnc_DynamicWeather_SetWeatherLocal;
		};
	};
};

// This variable is used for crate spawning. DO NOT CHANGE IT.
EAT_isOverPoch = isClass (configFile >> "CfgWeapons" >> "USSR_cheytacM200");

// Log tool usage to .txt file
"EAT_PVEH_usageLogger" addPublicVariableEventHandler {
	"EATadminLogger" callExtension (_this select 1);
};

// Export base to .sqf
"EAT_PVEH_baseExporter" addPublicVariableEventHandler {
	"EATbaseExporter" callExtension (_this select 1);
};
