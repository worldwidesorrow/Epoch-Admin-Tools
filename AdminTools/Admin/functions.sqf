// This is a centralized function for checking if an action is allowed to take place.
// This is basically the "_canDo" found in player actions.
EAT_fnc_actionAllowed = {
	private["_player","_vehicle","_inVehicle","_onLadder","_canDo"];
	_player = player; //Setting a local variable as player saves resources
	_vehicle = vehicle _player;
	_inVehicle = (_vehicle != _player);
	_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState _player) >> "onLadder")) == 1;
	_canDo = (!r_drag_sqf && !r_player_unconscious && !_onLadder && !_inVehicle);

_canDo
};

// Generates a selectable list of players for teleports and spectate
// Title is set by setting EAT_pMenuTitle = "TITLE HERE" before calling the function
EAT_pMenuTitle = "";
EAT_fnc_playerSelect =
{
	private["_pmenu","_arr"];
	_pmenu = [["",true],[EAT_pMenuTitle, [-1], "", -5, [["expression", ""]], "1", "0"]];
	for "_i" from (_this select 0) to (_this select 1) do
	{_arr = [format['%1', plist select (_i)], [12],  "", -5, [["expression", format ["pselect5 = plist select %1;", _i]]], "1", "1"]; _pmenu set [_i + 2, _arr];};
	if (count plist > (_this select 1)) then {_pmenu set [(_this select 1) + 2, ["Next", [13], "", -5, [["expression", "snext = true;"]], "1", "1"]];}
	else {_pmenu set [(_this select 1) + 2, ["", [-1], "", -5, [["expression", ""]], "1", "0"]];};
	_pmenu set [(_this select 1) + 3, ["Exit", [13], "", -5, [["expression", "pselect5 = 'exit';"]], "1", "1"]];
	showCommandingMenu "#USER:_pmenu";
};

// Convert multidimensional array to single dimensional
// Used in adminBuild
myfnc_MDarray = {
	private ["_list","_i","_temp"];
	_list = []; _temp = _this select 0; _i = 0;

	for "_i" from 0 to ((count _temp) - 1) do {
		_list set [_i,((_temp select _i) select 2)];
	};
	_list;
};

// Prints the position of the admin or a cursorTarget to the RPT
EAT_GetPosition = {
	private "_text";
	_obj = _this select 0;
	if(isNull _obj) exitWith {"No target" call dayz_rollingMessages;};
	_pos = getPos _obj;
	_dir = getDir _obj;
	
	if (isPlayer _obj) then {
		_text = format["Position of %1 is: %3%2",name _obj,_pos,_dir];
	} else {
		_text = format["Position of %1 is: %3%2",typeOf _obj,_pos,_dir];
	};
	
	if(EAT_logMinorTool) then {
		"Saved to client RPT and EAT logs" call dayz_rollingMessages;
		diag_log _text;
		_text call EAT_Logger;
	} else {
		"Saved to client RPT" call dayz_rollingMessages;
		diag_log _text;
	};
};

// Posts object information to system chat
EAT_GetObjDetails = {
	_obj = cursorTarget;
	if(isNull _obj) exitWith {"No target" call dayz_rollingMessages;};
	_charID = _obj getVariable ["CharacterID","0"];
	_objID 	= _obj getVariable["ObjectID","0"];
	_objUID	= _obj getVariable["ObjectUID","0"];
	_lastUpdate = _obj getVariable ["lastUpdate",time];
	_owner = _obj getVariable["ownerPUID","0"];
		
	systemChat format["%1: charID: %2, objID: %3, objUID: %4, Owner %5, lastUpdate: %6",typeOF _obj,_charID,_objID,_objUID,_owner,_lastUpdate];
};

// Flips the nearest land vehicle
EAT_FlipVeh = {
	private "_vehicle";
	_vehicle = getPos player nearestObject "LandVehicle";
	if (isNull _vehicle) exitWith {"There are no vehicles near to flip" call dayz_rollingMessages;};
	_vehicle setVectorUp [0, 0, 1];
	_vehicleType = typeOf _vehicle;
	format["Your %1 is now right-side up",_vehicleType] call dayz_rollingMessages;
};

// Ejects players from a vehicle
EAT_Eject = {
_ct = cursorTarget;
_ctType = typeOf _ct;
if(isNull _ct) exitWith {"No target" call dayz_rollingMessages;};
if(!(_ct isKindOf "LandVehicle") && !(_ct isKindOf "Air") && !(_ct isKindOf "Ship")) exitWith {cutText ["Target not a vehicle", "PLAIN DOWN"];};
if ((count crew _ct) < 1) exitWith {format["There are no players in the %1", _ctType] call dayz_rollingMessages;};
_ct forceSpeed 0;
{_x action ["Eject", _ct];} forEach crew _ct;
uiSleep 5;
_ct forceSpeed -1;
};

// Allows the player to glide forward quickly across the map. It is called from key bind.
EAT_FastForward = {
	_player = vehicle player;
	_dis = 5;
	_dir = getdir _player;
	_pos = getPosATL _player;
	_pos2 = getPos _player;
	_z2 = _pos2 select 2;
	_z = 0;

	if(_player isKindOf "Air" && _z2 < 20 && isEngineOn _player) then {_z = _z2 + 30;} else {if(_z2 > 3) then {_z = _z2;}else{if(surfaceIsWater _pos) then {_z = 2;} else {_z=0;};};};
	_pos = [(_pos select 0)+_dis*sin(_dir),(_pos select 1)+_dis*cos(_dir),_z];
	if (surfaceIsWater _pos) then {_player setPosASL _pos;} else {_player setPosATL _pos;};
};

// Toggles fast forward key bind on and off
EAT_FastForwardToggle = {
	private "_isActive";
	_isActive = _this select 0;
	if(_isActive) then {
		["FastWalk"] call EAT_Keybind;
	} else {
		["EndFastWalk"] call EAT_Keybind;
	};
};

// Allows the admin to leap vertically or directionally
EAT_AdminFastUp = {
	private "_velocity";
	_velocity = velocity player;
	player setVelocity [_velocity select 0,_velocity select 1,5];
};

// This function toggles the jump key bind on and off
EAT_FastUpToggle = {
	private "_isActive";
	_isActive = _this select 0;
	if (_isActive) then {
		["FastUp"] call EAT_Keybind;
	} else {
		["EndFastUp"] call EAT_Keybind;
	};
};

// Lowers the terrain
EAT_GrassOffToggle = {
	private ["_isActive","_toggle"];
	_isActive = _this select 0;

	if (_isActive) then {
		_toggle = "on";
		setTerrainGrid 50;
	}else{
		_toggle = "off";
		setTerrainGrid 25;
	};

	// Tool use logger
	if(EAT_logMinorTool) then {format["%1 %2 -- has turned grass %3",name player,getPlayerUID player,_toggle] call EAT_Logger;};
};

// Allows admin to be invisible to other players
EAT_AdminInvisible = {
	private ["_isActive","_position"];
	_isActive = _this select 0;
	_position = getPos player;
	
	EAT_clientToServer = ["invisibility",player,[_isActive,_position],dayz_authKey];
	publicVariableServer "EAT_clientToServer";
};

// Turns the build count to one and removes the requirement for a plot pole to build
EAT_adminBuildCount = {
	private "_isActive";
	_isActive = _this select 0;
	if(_isActive) then {
		DZE_StaticConstructionCount = 1;
		DZE_requireplot = 0;
	} else {
		DZE_StaticConstructionCount = 0;
		DZE_requireplot = 1;
	};
};

EAT_AddWeapon = {
	private ["_handGuns","_gun","_ammo","_HEammo","_player"];

	#define IS_HANDGUN(wpn) (getNumber (configFile >> "CfgWeapons" >> wpn >> "type") == 2)

	_gun = _this select 0;
	_ammo = _this select 1;
	if ((count _this) > 2) then {
		_HEammo = _this select 2;
	} else {
		_HEammo = nil;
	};
	_player = player;

	if (IS_HANDGUN(_gun)) then {
		{
			if (IS_HANDGUN(_x)) exitWith {
				_player removeWeapon _x;
			}
		} count (weapons _player);
	} else {
		_player removeWeapon (primaryWeapon _player);
	};

	// Add magazines before gun so the gun loads ammo on spawn
	_player addMagazine _ammo;
	_player addMagazine _ammo;
	_player addWeapon _gun;
	_player selectWeapon _gun;
	if(!(isNil _HEammo)) then {
		_player addMagazine _HEammo;
	};
};

EAT_Loadouts = {
	private ["_primaryWeapon","_secondaryWeapon","_primaryAmmo","_secondaryAmmo","_player","_bloodbag","_mags","_weps","_rifleMag","_pistolMag"];

	_player = player;
	_primaryWeapon = _this select 0;
	_secondaryWeapon = _this select 1;
	_primaryAmmo = getArray (configFile >> "cfgWeapons" >> _primaryWeapon >> "magazines");
	_secondaryAmmo = getArray (configFile >> "cfgWeapons" >> _secondaryWeapon >> "magazines");
	_rifleMag = _primaryAmmo select 0;
	_pistolMag = _secondaryAmmo select 0;
	_weps = ["ItemRadio","NVGoggles_DZE","Binocular_Vector","ItemGPS","ItemHatchet","ItemKnife","ItemMatchbox","ItemEtool","ItemToolbox","ItemCrowbar",_primaryWeapon,_secondaryWeapon];
	if(dayz_classicBloodBagSystem) then {_bloodbag = "ItemBloodbag";} else {_bloodbag = "bloodBagONEG";};
	_mags = ["ItemMorphine","ItemEpinephrine","ItemAntibiotic","ItemPainkiller","ItemWaterBottleBoiled","FoodBeefCooked","ItemBandage","ItemBandage",_bloodbag,_rifleMag,_rifleMag,_rifleMag,_pistolMag,_pistolMag,_pistolMag];

	removeAllWeapons _player;
	removeAllItems _player;
	removeBackpack _player;

	_player addBackpack "DZ_Backpack_EP1";

	{
		_player addMagazine _x;
	} count _mags;

	{
		_player addWeapon _x;
	} count _weps;

	_player selectWeapon _primaryWeapon;
};

EAT_AddBackPack = {
	private["_bag","_player"];
	_bag = _this select 0;
	_player = player;
	removeBackpack _player;
	_player addBackpack _bag;
};

EAT_AddMeds = {
	private "_bloodbag";

	if(dayz_classicBloodBagSystem) then {_bloodbag = "ItemBloodbag";}else{_bloodbag = "bloodBagONEG";};

	{
		player addMagazine _x;
	} count ["ItemMorphine","ItemEpinephrine","ItemAntibiotic","ItemPainkiller","ItemSodaPepsi","FoodBeefCooked","ItemBandage","ItemBandage",_bloodbag];
};

EAT_RemoveGear = {
	removeAllWeapons player;
	removeAllItems player;
	removeBackpack player;
	"Gear deleted!" call dayz_rollingMessages;
};

EAT_AddTools = {
	private "_tools";
	_tools = ["ItemRadio","ItemHatchet","ItemKnife","ItemMatchbox","ItemEtool","ItemToolbox","ItemCrowbar"];
	
	{
		if (_x in weapons player) then {
			player removeWeapon _x;
		};
	} count _tools;
	
	{
		player addWeapon _x;
	} count _tools;
};

EAT_AddTempVeh = {

	_vehtospawn = _this select 0; 
	_dist = 9;
	_player = player;
	_dir = getDir vehicle _player;
	_pos = getPosATL vehicle _player;
	_pos = [(_pos select 0)+_dist*sin(_dir),(_pos select 1)+_dist*cos(_dir),0];
	_vehName = getText(configFile >> "cfgVehicles" >> _vehtospawn >> "displayName");

	EAT_clientToServer = ["tempVeh",_player,[_vehtospawn,_dir,_pos],dayz_authKey];
		publicVariableServer "EAT_clientToServer";

	format["Spawned a %1",_vehName] call dayz_rollingMessages;

	// Tool use logger
	if(EAT_logMinorTool) then {format["%1 %2 -- has added a temporary vehicle: %3",name _player,getPlayerUID _player,_vehtospawn] call EAT_Logger;};
};

EAT_AddVeh = {
	private ["_vehName","_veh","_isOk","_vehtospawn","_dir","_pos","_keyColor","_keyNumber","_keySelected","_isKeyOK","_config","_player"];
	_vehtospawn = _this select 0; // Vehicle string
	_player = player;
	_dir = getDir vehicle _player;
	_pos = getPos vehicle _player;
	_pos = [(_pos select 0)+9*sin(_dir),(_pos select 1)+9*cos(_dir),0];
	_vehName = getText(configFile >> "cfgVehicles" >> _vehtospawn >> "displayName");
	_keyColor = ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;
	_keyNumber = (floor(random 2500)) + 1;
	_keySelected = format[("ItemKey%1%2"),_keyColor,_keyNumber]; 
	_isKeyOK =  isClass(configFile >> "CfgWeapons" >> _keySelected); 
	_config = _keySelected;
	_isOk = [_player,_config] call BIS_fnc_invAdd;

	if (_isOk and _isKeyOK) then {

		PVDZE_veh_Publish2 = [[_dir,_pos],_vehtospawn,false,_keySelected,_player,dayz_authKey];
		publicVariableServer  "PVDZE_veh_Publish2";
		
		format["%1 spawned, key added to toolbelt.",_vehName] call dayz_rollingMessages;

		if(EAT_logMajorTool) then {format["%1 %2 -- has added a permanent vehicle: %3",name _player,getPlayerUID _player,_vehtospawn] call EAT_Logger;};
	} else {
		"Your toolbelt is full." call dayz_rollingMessages;
	};
};

EAT_AddVehDialog = {
	private ["_kindOf", "_filter", "_cfgvehicles","_dialog","_vehicle","_adminList"];

	PermDialogSelected = -1;
	TempDialogSelected = -1;
	AdminDialogList = 13000;
	if (isNil "EAT_EpochOnlyVehicles") then {EAT_EpochOnlyVehicles = false;};
	if (isNil "vhnlist") then {vhnlist = [];};

	LoadAllVehiclesList = {
		lbClear AdminDialogList;
		vhnlist = EAT_allVehList;

		{
			private ["_index", "_x","_image"];
			_image = _x select 2;
			_index = lbAdd [AdminDialogList, format["%2 (%1)", _x select 0, _x select 1]];
			lbSetPicture [AdminDialogList, _index, _image];
		} forEach vhnlist;
	};

	LoadEpochOnlyList = {
		private ["_cfgvehicles","_dialog","_vehicle","_allepochvehicles"];
		lbClear AdminDialogList;
		vhnlist = EAT_allEpochVehList;
			
		{
			private ["_index", "_x","_image"];
			_image = _x select 2;
			_index = lbAdd [AdminDialogList, format["%2 (%1)", _x select 0, _x select 1]];
			lbSetPicture [AdminDialogList, _index, _image];
		} forEach vhnlist;
	};

	_dialog = createDialog "EAT_Veh_AdminDialog";
	call LoadAllVehiclesList;

	LoadSpecificList = {
		private ["_kindOf", "_filter", "_cfgvehicles","_dialog","_vehicle","_veharray"];
		lbClear AdminDialogList;
		vhnlist = [];
		if (EAT_EpochOnlyVehicles) then {
			//_kindOf = ["LandVehicle","Air","Ship"];
			_kindOf = _this select 0;
			{
				if (typeName _x == "ARRAY") then {
					_vehicle = _x select 0;
					if (_vehicle isKindOf _kindOf) then 
					{
						vhnlist set [count vhnlist, _x]
					} count _x;
				};
			} forEach EAT_allEpochVehList;
		} else {
			//_kindOf = ["LandVehicle","Air","Ship"];
			_kindOf = _this select 0;
			{
				if (typeName _x == "ARRAY") then {
					_vehicle = _x select 0;
					if (_vehicle isKindOf _kindOf) then 
					{
						vhnlist set [count vhnlist, _x]
					} count _x;
				};
			} forEach EAT_allVehList;
		};
		{
			private ["_index", "_x","_image"];
			_image = _x select 2;
			_index = lbAdd [AdminDialogList, format["%2 (%1)", _x select 0, _x select 1]];
		  lbSetPicture [AdminDialogList, _index, _image];
		} forEach vhnlist;
	};

	waitUntil { !dialog };
	if ((PermDialogSelected < 0) && (TempDialogSelected < 0)) exitWith {};

	if (PermDialogSelected > -1) then {
		_vehicle = ((vhnlist select PermDialogSelected) select 0);
		[_vehicle] call EAT_AddVeh;
	};

	if (TempDialogSelected > -1) then {
		_vehicle = ((vhnlist select TempDialogSelected) select 0);
		[_vehicle] call EAT_AddTempVeh;
	};
};

EAT_AISpawn = {
	private ["_player","_done"];
	if (!("ItemGPS" in items player)) then {player addWeapon "ItemGPS";};
	EAT_aiArea = 0;
	EAT_aiCount = 0;
	_done = false;
	EAT_aiSpawnType = "";

	EAT_aiTypeMenu =
	[
	["",true],
		["Select AI Type:", [-1], "", -5, [["expression", ""]], "1", "0"],
		["Hero",[],"", -5,[["expression","EAT_aiSpawnType = ""Hero"";"]],"1","1"],
		["Bandit",[],"", -5,[["expression","EAT_aiSpawnType = ""Bandit"";"]],"1","1"],
		["", [], "", -5,[["expression", ""]], "1", "0"],
			["Exit", [20], "", -5, [["expression", "EAT_aiArea = -1;"]], "1", "1"]
	];

	EAT_aiAreaMenu =
	[
	["",true],
		["Set AI Movement Radius:", [-1], "", -5, [["expression", ""]], "1", "0"],
		["40m",[],"", -5,[["expression","EAT_aiArea = 40;"]],"1","1"],
		["50m",[],"", -5,[["expression","EAT_aiArea = 50;"]],"1","1"],
		["75m",[],"", -5,[["expression","EAT_aiArea = 75;"]],"1","1"],
		["100m",[],"", -5,[["expression","EAT_aiArea = 100;"]],"1","1"],
		["150m",[],"", -5,[["expression","EAT_aiArea = 150;"]],"1","1"],
		["200m",[],"", -5,[["expression","EAT_aiArea = 200;"]],"1","1"],
		["300m",[],"", -5,[["expression","EAT_aiArea = 200;"]],"1","1"],
		["", [], "", -5,[["expression", ""]], "1", "0"],
			["Exit", [20], "", -5, [["expression", "EAT_aiArea = -1;"]], "1", "1"]
	];

	EAT_amountMenu =
	[
	["",true],
		["Select AI count:", [-1], "", -5, [["expression", ""]], "1", "0"],
		["1",[],"", -5,[["expression","EAT_aiCount = 1;"]],"1","1"],
		["2",[],"", -5,[["expression","EAT_aiCount = 2;"]],"1","1"],
		["4",[],"", -5,[["expression","EAT_aiCount = 4;"]],"1","1"],
		["6",[],"", -5,[["expression","EAT_aiCount = 6;"]],"1","1"],
		["8",[],"", -5,[["expression","EAT_aiCount = 8;"]],"1","1"],
		["10",[],"", -5,[["expression","EAT_aiCount = 10;"]],"1","1"],
		["20",[],"", -5,[["expression","EAT_aiCount = 20;"]],"1","1"],
		["30",[],"", -5,[["expression","EAT_aiCount = 30;"]],"1","1"],
		["40",[],"", -5,[["expression","EAT_aiCount = 40;"]],"1","1"],
		["50",[],"", -5,[["expression","EAT_aiCount = 50;"]],"1","1"],
		["", [], "", -5,[["expression", ""]], "1", "0"],
			["Exit", [20], "", -5, [["expression", "EAT_aiCount = -1;"]], "1", "1"]
	];

	showCommandingMenu "#USER:EAT_aiTypeMenu";
	waitUntil{(EAT_aiSpawnType != "") || (commandingMenu == "")};
	if(EAT_aiSpawnType == "") exitWith{};

	showCommandingMenu "#USER:EAT_aiAreaMenu";
	waitUntil{(EAT_aiArea != 0) || (commandingMenu == "")};
	if(EAT_aiArea == 0) exitWith{};

	showCommandingMenu "#USER:EAT_amountMenu";
	waitUntil{(EAT_aiCount != 0) || (commandingMenu == "")};
	if(EAT_aiCount == 0) exitWith{};


	_player = player;

	if(EAT_logMajorTool) then {format["%1 %2 -- has added %3 AI units",name _player,getPlayerUID _player,EAT_aiCount] call EAT_Logger;};

	EAT_SpawnAI = {
		private ["_divisor","_aiPosition"];
		_divisor = _this select 0;
		_aiPosition = [_this select 1, _this select 2,_this select 3];

		EAT_clientToServer = ["addAI",player,[EAT_aiSpawnType,EAT_aiArea,EAT_aiCount,_divisor,_aiPosition,(getPos player)],dayz_authKey];
		publicVariableServer "EAT_clientToServer";

	};

	EAT_aiSpawnSelection = {
		private ["_pos1","_pos2","_pos3"];
		_pos1 = _this select 0;
		_pos2 = _this select 1;
		_pos3 = _this select 2;
		if(EAT_aiCount %5 == 0) then {
			[5,_pos1,_pos2,_pos3] call EAT_SpawnAI;
			[5,_pos1,_pos2,_pos3] call EAT_SpawnAI;
			[5,_pos1,_pos2,_pos3] call EAT_SpawnAI;
			[5,_pos1,_pos2,_pos3] call EAT_SpawnAI;
			[5,_pos1,_pos2,_pos3] call EAT_SpawnAI;
		} else {
			if(EAT_aiCount %4 == 0) then {
				[4,_pos1,_pos2,_pos3] call EAT_SpawnAI;
				[4,_pos1,_pos2,_pos3] call EAT_SpawnAI;
				[4,_pos1,_pos2,_pos3] call EAT_SpawnAI;
				[4,_pos1,_pos2,_pos3] call EAT_SpawnAI;
			} else {
				if(EAT_aiCount %2 == 0) then {
					[2,_pos1,_pos2,_pos3] call EAT_SpawnAI;
					[2,_pos1,_pos2,_pos3] call EAT_SpawnAI;
				} else {
					[1,_pos1,_pos2,_pos3] call EAT_SpawnAI;
				};
			};
		};
		openMap [false, false];
		TitleText [format[""], "PLAIN DOWN"];
		_done = true;
	};

	closeDialog 0;
	uiSleep 0.5;
	"Click on the map to spawn AI" call dayz_rollingMessages;

	if(!(visibleMap)) then {
		openMap [true, false];
	};

	onMapSingleClick '[_pos select 0, _pos select 1, _pos select 2] call EAT_aiSpawnSelection';
	waitUntil{_done || !(visibleMap)};
	onMapSingleClick "";
};

EAT_DeleteObj = {
	private ["_obj","_objectID","_objectUID","_player"];

	_obj = cursorTarget;
	if(isNull _obj) exitWith{"No object selected" call dayz_rollingMessages;};
	_player = player;
	EAT_DeleteObjText = getText (configFile >> "CfgVehicles" >> typeOf _obj >> "displayName");
	EAT_databaseRemove = 0;

	_objectID = _obj getVariable["ObjectID","0"];
	_objectUID = _obj getVariable["ObjectUID","0"];

	_deleteMenu =
	[
	["",true],
		[format["Delete this %1?:",EAT_DeleteObjText], [-1], "", -5, [["expression", ""]], "1", "0"],
		["Yes",[0],"", -5,[["expression","EAT_databaseRemove = 1;"]],"1","1"],
		["No", [0], "", -5, [["expression", "EAT_databaseRemove = -1"]], "1", "1"]
	];
	showCommandingMenu "#USER:_deleteMenu";
	waitUntil{(EAT_databaseRemove != 0) || (commandingMenu == "")};
	if(EAT_databaseRemove <= 0) exitWith{};


	// Tool use logger
	if(EAT_logMinorTool) then {format["%1 %2 -- has deleted object: %3 ID:%4 UID:%5 from database",name _player,getPlayerUID _player,EAT_DeleteObjText,_objectID,_objectUID] call EAT_Logger;};

	format["Deleted %1",EAT_DeleteObjText] call dayz_rollingMessages;

	PVDZ_obj_Destroy = [_objectID,_objectUID,_player,_obj,dayz_authKey];
	publicVariableServer "PVDZ_obj_Destroy";
};

EAT_DisplayCode = {
	private ["_combo","_ct","_player"];
	_ct = cursorTarget;
	_player = player;
	_combo = _ct getVariable ["CharacterID","0"];

	if(isNull _ct) exitWith{"No target" call dayz_rollingMessages;};

	if(_combo != "0") then {
		if (_ct isKindOf "LandVehicle" OR _ct isKindOf "Helicopter" OR _ct isKindOf "Plane" OR _ct isKindOf "Ship") then {
			if ((_combo > 0) && (_combo <= 2500)) then {_result = format["Green%1",_combo];}else{
			if ((_combo > 2500) && (_combo <= 5000)) then {_result = format["Red%1",_combo-2500];}else{
			if ((_combo > 5000) && (_combo <= 7500)) then {_result = format["Blue%1",_combo-5000];}else{
			if ((_combo > 7500) && (_combo <= 10000)) then {_result = format["Yellow%1",_combo-7500];}else{
			if ((_combo > 10000) && (_combo <= 12500)) then {_result = format["Black%1",_combo-10000];};};};};};
			format["Vehicle Key: %1", _result] call dayz_rollingMessages;
		}else{
			format["Item Code: %1", _combo] call dayz_rollingMessages;
		};
		
		// Tool use logger
		if(EAT_logMajorTool) then {format["%1 %2 -- has viewed a locked item: %3",name _player,getPlayerUID _player,_combo] call EAT_Logger;};
	} else {
		format["Not a valid target.",_combo] call dayz_rollingMessages;
	};
};

EAT_HealPlayer = {
	private ["_player","_unit","_UIfix","_UIfix2"];

	EAT_healDistance = -1;
	_player = player;

	EAT_distanceMenu = 
	[
		["",true],
		["Select distance:", [-1], "", -5, [["expression", ""]], "1", "0"],
		["5", [2], "", -5, [["expression", "EAT_healDistance=5;"]], "1", "1"],
		["10", [3], "", -5, [["expression", "EAT_healDistance=10;"]], "1", "1"],
		["25", [4], "", -5, [["expression", "EAT_healDistance=25;"]], "1", "1"],
		["50", [5], "", -5, [["expression", "EAT_healDistance=50;"]], "1", "1"],
		["100", [6], "", -5, [["expression", "EAT_healDistance=100;"]], "1", "1"],
		["500", [7], "", -5, [["expression", "EAT_healDistance=500;"]], "1", "1"],
		["1000", [8], "", -5, [["expression", "EAT_healDistance=1000;"]], "1", "1"],
		["10000", [9], "", -5, [["expression", "EAT_healDistance=10000;"]], "1", "1"],
		["Self", [10], "", -5, [["expression", "EAT_healDistance=0;"]], "1", "1"],
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]	
	];

	showCommandingMenu "#USER:EAT_distanceMenu";

	WaitUntil{commandingMenu == ""};

	if(EAT_healDistance == -1) exitWith {};

	r_player_blood = r_player_bloodTotal;
	r_player_inpain = false;
	r_player_infected = false;
	r_player_injured = false;
	dayz_hunger	= 0;
	dayz_thirst = 0;
	dayz_temperatur = 100;

	r_fracture_legs = false;
	r_fracture_arms = false;
	r_player_dead = false;
	r_player_unconscious = false;
	r_player_loaded = false;
	r_player_cardiac = false;
	r_player_lowblood = false;
	r_doLoop = false;
	r_action = false;
	r_player_timeout = 0;
	r_handlerCount = 0;
	r_interrupt = false;

	disableUserInput false;
	dayz_sourceBleeding = objNull;
	_player setVariable ["USEC_injured",false,true];
	_player setVariable['USEC_inPain',false,true];
	_player setVariable['USEC_infected',false,true];
	_player setVariable['USEC_lowBlood',false,true];
	_player setVariable['USEC_BloodQty',12000,true];
	_player setVariable['USEC_isCardiac',false,true];
	{_player setVariable[_x,false,true];} forEach USEC_woundHit;
	_player setVariable ["unconsciousTime", r_player_timeout, true];
	_player setVariable['NORRN_unconscious',false,true];
	_player setVariable ['messing',[dayz_hunger,dayz_thirst],true];
	_player setHit ['legs',0];
	_player setVariable ['hit_legs',0,true];
	_player setVariable ['hit_hands',0,true];
	_player setVariable['medForceUpdate',true,true];
	_player setVariable["inCombat",false, true];

	disableSerialization;
	_UIfix = (uiNameSpace getVariable 'DAYZ_GUI_display') displayCtrl 1303;
	_UIfix2 = (uiNameSpace getVariable 'DAYZ_GUI_display') displayCtrl 1203;
	_UIfix ctrlShow false;
	_UIfix2 ctrlShow false;

	if(EAT_healDistance == 0) exitWith {};

	xyzaa = _player nearEntities ["Man", EAT_healDistance];

	{
		if (!(_x isKindOf "zZombie_Base") && !(_x isKindOf "Animal")) then {
			_unit = _x;

			PVDZ_send = [_unit,"Bandage",[_unit,player]];
			publicVariableServer "PVDZ_send";
			
			PVDZ_send = [_unit, "Transfuse", [_unit, player, 12000]];
			publicVariableServer "PVDZ_send";
			
			PVDZ_send = [_unit,"Morphine",[_unit,player]];
			publicVariableServer "PVDZ_send";
			
			PVDZ_send = [_unit,"Epinephrine",[_unit,player,"ItemEpinephrine"]];
			publicVariableServer "PVDZ_send";
			
			PVDZ_send = [_unit,"Painkiller",[_unit,player]];
			publicVariableServer "PVDZ_send";
			
			PVDZ_send = [_unit,"Antibiotics",[_unit,player]];
			publicVariableServer "PVDZ_send";
		};
	} forEach xyzaa;

	format["%1 healed",xyzaa] call dayz_rollingMessages;
};

EAT_Humanity = {
	/*
		Add or remove the selected humanity amount from player.
	*/

	private ["_target","_player","_humanity","_addOrRemove"];
	_addOrRemove = _this select 0;
	_target = cursorTarget;
	_player = player;

	if(!isPlayer _target) then {_target = _player;};

	EAT_humanityGain = -1;
	_humanity = _target getVariable["humanity", 0];

	if(_addOrRemove != "reset") then {
		EAT_humanityChange = [
			["",true],
			["Select humanity amount:", [-1], "", 0, [["expression", ""]], "1", "0"],
			["100", [2], "", -5, [["expression", "EAT_humanityGain=100;"]], "1", "1"],
			["500", [3], "", -5, [["expression", "EAT_humanityGain=500;"]], "1", "1"],
			["1000", [4], "", -5, [["expression", "EAT_humanityGain=1000;"]], "1", "1"],
			["2500", [5], "", -5, [["expression", "EAT_humanityGain=2500;"]], "1", "1"],
			["5000", [6], "", -5, [["expression", "EAT_humanityGain=5000;"]], "1", "1"],
			["Exit", [8], "", 0, [["expression", ""]], "1", "1"]
		];

		showCommandingMenu "#USER:EAT_humanityChange";
		waitUntil{(commandingMenu == "")};
		if((EAT_humanityGain == -1)) exitWith {};

		if(_addOrRemove == "remove") then {
			EAT_humanityGain = EAT_humanityGain - (EAT_humanityGain * 2);
		};

		_target setVariable["humanity", _humanity + EAT_humanityGain, true];
		format["%1 humanity has been added (total: %2) for player %3", EAT_humanityGain, _humanity + EAT_humanityGain, name _target] call dayz_rollingMessages;

		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has added %3 to %4 humanity (total %5)",name _player,getPlayerUID _player,EAT_humanityGain,name _target,_humanity + EAT_humanityGain] call EAT_Logger;};
	}else{
		EAT_humanityGain = _humanity - (_humanity * 2);
		_target setVariable["humanity", 2500, true];
		format["Humanity reset to 2500 for player %1", name _target] call dayz_rollingMessages;

		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has adjusted %3 humanity to 2500",name _player,getPlayerUID _player,name _target] call EAT_Logger;};
	};
};

EAT_SendMessage = {
	private "_dialog";
	EAT_SendDialogText = "";

	// Sleep to make sure scroll menu is cleared
	uiSleep 0.2;

	_dialog = createDialog "EAT_messageBox_Dialog";

	ctrlSetText [1001,"Send a server message"];

	waitUntil {!dialog};
	if(EAT_SendDialogText == "") exitWith {};

	EAT_clientToServer = ["ServerMessage",player,[EAT_SendDialogText],dayz_authKey];
	publicVariableServer "EAT_clientToServer";
};

EAT_AddMoney = {
	// Add money to cursor target or self

	private ["_amount","_wealth","_addMoney"];
		
	_target = cursorTarget;
	_player = player;
	//_amount = _this select 0; //this value will be either a coin amount or a briefcase amount depending on if ZSC is installed.

	if(!isPlayer _target) then {_target = _player;};
	EAT_moneyAmount = 0;

	if(Z_SingleCurrency) then {
		_addMoney = 
		[
			["",true],
			["Add Money to Player or Self:", [-1], "", -5, [["expression", ""]], "1", "0"], 	
			["1,000", [2], "", -5, [["expression", "EAT_moneyAmount=1000;"]], "1", "1"],
			["5,000", [3], "", -5, [["expression", "EAT_moneyAmount=5000;"]], "1", "1"],
			["10,000", [4], "", -5, [["expression", "EAT_moneyAmount=10000;"]], "1", "1"],
			["25,000", [5], "", -5, [["expression", "EAT_moneyAmount=25000;"]], "1", "1"],
			["50,000", [6], "", -5, [["expression", "EAT_moneyAmount=50000;"]], "1", "1"],
			["100,000", [7], "", -5, [["expression", "EAT_moneyAmount=100000;"]], "1", "1"],
			["250,000", [8], "", -5, [["expression", "EAT_moneyAmount=250000;"]], "1", "1"],	
			["Exit", [13], "", -3, [["expression", "EAT_moneyAmount = -1;"]], "1", "1"]	
		];
		showCommandingMenu "#USER:_addMoney";
		WaitUntil{(EAT_moneyAmount !=0) || (commandingMenu == "")};
		if(EAT_moneyAmount <= 0) exitWith{};
		
		_wealth = _target getVariable[Z_MoneyVariable,0];
		_target setVariable[Z_MoneyVariable,_wealth + EAT_moneyAmount,true];

	} else {
		_addMoney = 
		[
			["",true],
			["Add Money to Player or Self:", [-1], "", -5, [["expression", ""]], "1", "0"], 	
			["1 Briefcase", [2], "", -5, [["expression", "EAT_moneyAmount=1;"]], "1", "1"],
			["2 Briefcases", [3], "", -5, [["expression", "EAT_moneyAmount=2;"]], "1", "1"],
			["3 Briefcases", [4], "", -5, [["expression", "EAT_moneyAmount=3;"]], "1", "1"],
			["4 Briefcases", [5], "", -5, [["expression", "EAT_moneyAmount=4;"]], "1", "1"],
			["5 Briefcases", [6], "", -5, [["expression", "EAT_moneyAmount=5;"]], "1", "1"],
			["Exit", [13], "", -3, [["expression", "EAT_moneyAmount = -1;"]], "1", "1"]	
		];
		showCommandingMenu "#USER:_addMoney";
		WaitUntil{(EAT_moneyAmount !=0) || (commandingMenu == "")};
		if(EAT_moneyAmount <= 0) exitWith{};

		_target addMagazine ["ItemBriefcase100oz",EAT_moneyAmount];
		/*
		{
			[_target,"ItemBriefcase100oz"] call BIS_fnc_invAdd 
		} count _amount;
		*/

	};
};

EAT_Lock = {
	private ["_objectID","_objectUID","_obj","_ownerID","_dir","_pos","_holder","_weapons","_magazines","_backpacks","_lockedClass","_player"];

	_obj = cursorTarget;
	if(isNull _obj) exitWith {};

	_objType = typeOf _obj;
	_ownerID = _obj getVariable["ObjectID","0"];
	_objectID = _obj getVariable["ObjectID","0"];
	_player = player;

	// Lock car
	if (_obj isKindOf "LandVehicle" || _obj isKindOf "Air" || _obj isKindOf "Ship") then {
		{player removeAction _x} forEach s_player_lockunlock;s_player_lockunlock = [];
		s_player_lockUnlock_crtl = 1;

		PVDZE_veh_Lock = [_obj,true];

		if (local _obj) then {
			PVDZE_veh_Lock spawn local_lockUnlock
		} else {
			publicVariable "PVDZE_veh_Lock";
		};
		
		s_player_lockUnlock_crtl = -1;

		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has locked a vehicle: %3",name _player,getPlayerUID _player,_obj] call EAT_Logger;};
	} else {
		//Lock Safe/Lock_box
		if(_objType in DZE_UnLockedStorage) then {
			_lockedClass = getText (configFile >> "CfgVehicles" >> _objType >> "lockedClass");
			_text = getText (configFile >> "CfgVehicles" >> _objType >> "displayName");
			
			disableUserInput true; // Make sure player can not modify gear while it is being saved
			(findDisplay 106) closeDisplay 0; // Close gear
			dze_waiting = nil;
		
			[_lockedClass,objNull] call fn_waitForObject;
		
			PVDZE_handleSafeGear = [_player,_obj,1];
			publicVariableServer "PVDZE_handleSafeGear";	
			//wait for response from server to verify safe was logged and saved before proceeding
			waitUntil {!isNil "dze_waiting"};
			disableUserInput false; // Safe is done saving now

			format[localize "str_epoch_player_117",_text] call dayz_rollingMessages;
			
			// Tool use logger
			if(EAT_logMajorTool) then {format["%1 %2 -- has locked a safe - ID:%3 UID:%4",name _player,getPlayerUID _player,_objectID,_ownerID] call EAT_Logger;};

		} else {
			//Lock Door
			
			_objectCharacterID = _obj getVariable ["CharacterID","0"];
			
			if(_obj animationPhase "Open_hinge" == 1) then {_obj animate ["Open_hinge", 0];};
			if(_obj animationPhase "Open_latch" == 1) then {_obj animate ["Open_latch", 0];};
			if(_obj animationPhase "Open_door" == 1) then {_obj animate ["Open_door", 0];};
			if(_obj animationPhase "DoorR" == 1) then {_obj animate ["DoorR", 0];};
			if(_obj animationPhase "LeftShutter" == 1) then {_obj animate ["LeftShutter", 0];};
			if(_obj animationPhase "RightShutter" == 1) then {_obj animate ["RightShutter", 0];};
			
			// Tool use logger
			if(EAT_logMajorTool) then {format["%1 %2 -- has locked a door - ID:%3 Combo:%4",name _player,getPlayerUID _player,_objectID,_objectCharacterID] call EAT_Logger;};
		};
	};
};

EAT_Repair = {
	private ["_configVeh","_capacity","_vehicle","_type","_name","_hitpoints","_player","_strH"];

	_vehicle = cursorTarget;
	_type = typeOf _vehicle;
	_configVeh = configFile >> "cfgVehicles" >> _type;
	_capacity = getNumber(_configVeh >> "fuelCapacity");
	_name = getText(configFile >> "cfgVehicles" >> _type >> "displayName");
	_player = player;

	if (isNull _vehicle) exitWith {"No target" call dayz_rollingMessages;};

	_hitpoints = _vehicle call vehicle_getHitpoints;
	{
		private ["_damage","_selection"];
		_damage = [_vehicle,_x] call object_getHit;

		if (_damage > 0) then {
			_vehicle setVariable[_strH,0,true];
		};
	} forEach _hitpoints;

	if (local _vehicle) then {
		[_vehicle,_capacity] call local_setFuel;
	} else {
		PVDZ_send = [_vehicle,"SetFuel",[_vehicle,_capacity]];
		publicVariableServer "PVDZ_send";
	};

	PVDZ_veh_Save = [_vehicle,"repair"];
	publicVariableServer "PVDZ_veh_Save";

	format["%1 Repaired and Refueled", _name] call dayz_rollingMessages;

	// Tool use logger
	if(EAT_logMinorTool) then {format["%1 %2 -- has repaired %3",name _player,getPlayerUID _player,_vehicle] call EAT_Logger;};
};

EAT_Unlock = {
	private ["_objectID","_objectUID","_obj","_ownerID","_dir","_pos","_holder","_weapons","_magazines","_backpacks","_objWpnTypes","_objWpnQty","_countr","_unlockedClass","_objType","_objectCharacterID","_player"];

	_obj = cursorTarget;
	if(isNull _obj) exitWith {};
	_objectID = _obj getVariable["ObjectID","0"];
	_ownerID = _obj getVariable["ObjectID","0"];
	_objType = typeOf _obj;
	_player = player;

	// Unlock car
	if (_obj isKindOf "LandVehicle" || _obj isKindOf "Air" || _obj isKindOf "Ship") then {

		{player removeAction _x} forEach s_player_lockunlock;s_player_lockunlock = [];
		s_player_lockUnlock_crtl = 1;

		PVDZE_veh_Lock = [_obj,false];
					
		if (local _obj) then {
			PVDZE_veh_Lock spawn local_lockUnlock
		} else {
			publicVariable "PVDZE_veh_Lock";
		};

		s_player_lockUnlock_crtl = -1;

		// Tool use logger
		if(EAT_logMajorTool) then {format["%1 %2 -- has unlocked vehicle: %3 with ID:%4",name _player,getPlayerUID _player,_obj,_objectID] call EAT_Logger;};
	} else {
		// Unlock Safe/Lock_Box
		if(_objType in DZE_LockedStorage) then {
			// Get all required variables
			_unlockedClass = getText (configFile >> "CfgVehicles" >> _objType >> "unlockedClass");
			_text =	getText (configFile >> "CfgVehicles" >> _objType >> "displayName");
			//_obj setVariable["packing",1];
			
			disableUserInput true; // Make sure player can not modify gear while it is filling
			(findDisplay 106) closeDisplay 0; // Close gear
			dze_waiting = nil;
			
			[_unlockedClass,objNull] call fn_waitForObject;
			
			PVDZE_handleSafeGear = [_player,_obj,0];
			publicVariableServer "PVDZE_handleSafeGear";
			//wait for response from server to verify safe was logged before proceeding
			waitUntil {!isNil "dze_waiting"};
			disableUserInput false; // Safe is done filling now
			
			format[localize "STR_BLD_UNLOCKED",_text] call dayz_rollingMessages;
			
			// Tool use logger
			if(EAT_logMajorTool) then {format["%1 %2 -- has unlocked a safe - ID:%3 UID:%4",name _player,getPlayerUID _player,_objectID,_ownerID] call EAT_Logger;};	
		} else {

			_objectCharacterID = _obj getVariable ["CharacterID","0"];
			
			//Unlock Doors
			if(_obj animationPhase "Open_hinge" == 0) then {_obj animate ["Open_hinge", 1];};
			if(_obj animationPhase "Open_latch" == 0) then {_obj animate ["Open_latch", 1];};
			if(_obj animationPhase "Open_door" == 0) then {_obj animate ["Open_door", 1];};
			if(_obj animationPhase "DoorR" == 0) then {_obj animate ["DoorR", 1];};
			if(_obj animationPhase "LeftShutter" == 0) then {_obj animate ["LeftShutter", 1];};
			if(_obj animationPhase "RightShutter" == 0) then {_obj animate ["RightShutter", 1];};
			
			// Tool use logger
			if(EAT_logMajorTool) then {format["%1 %2 -- has unlocked a door - ID:%3 Combo:%4",name _player,getPlayerUID _player,_objectID,_objectCharacterID] call EAT_Logger;};
		};
	};
};

EAT_RecoverKey = {
	private ["_ct","_id","_result","_player"];
	_ct = cursorTarget;
	_player = player;

	if (isNull _ct) exitWith {"No target" call dayz_rollingMessages;};

	if (_ct isKindOf "LandVehicle" OR _ct isKindOf "Air" OR _ct isKindOf "Ship") then
	{
		_id = _ct getVariable ["CharacterID","0"];
		_id = parseNumber _id;
		_result = "ItemKey";
		if (_id == 0) exitWith {cutText [format["%1 has ID 0 - No Key possible.",typeOf _ct], "PLAIN"];};
		if ((_id > 0) && (_id <= 2500)) then {_result = format["ItemKeyGreen%1",_id];}else{
		if ((_id > 2500) && (_id <= 5000)) then {_result = format["ItemKeyRed%1",_id-2500];}else{
		if ((_id > 5000) && (_id <= 7500)) then {_result = format["ItemKeyBlue%1",_id-5000];}else{
		if ((_id > 7500) && (_id <= 10000)) then {_result = format["ItemKeyYellow%1",_id-7500];}else{
		if ((_id > 10000) && (_id <= 12500)) then {_result = format["ItemKeyBlack%1",_id-10000];};};};};};

		_player addWeapon _result;
		format["Key [%1] added to inventory!",_result] call dayz_rollingMessages;
		
		if(EAT_logMajorTool) then {format["%1 %2 -- has generated %3 for a %4",name _player,getPlayerUID _player,_result,_ct] call EAT_Logger;};
	};
};

EAT_SkinChanger = {
	private ["_skin","_unitBag","_bagType","_bagMagazines","_bagWeapons","_array1","_array2","_player"];
	_skin = _this select 0;
	_player = player;
	_unitBag = unitBackpack _player;
	_bagType = (typeOf _unitBag);

	// Tool use logger
	if(EAT_logMinorTool) then {format["%1 %2 -- has changed skins to %3",name _player,getPlayerUID _player,_skin] call EAT_Logger;};

	if(_bagType !="") then {
		_bagWeapons = getWeaponCargo _unitBag;
		_bagMagazines = getMagazineCargo _unitBag;
		removeBackpack (vehicle _player);
		[dayz_playerUID,dayz_characterID,_skin] spawn player_humanityMorph;
		uiSleep 0.3;
		
		if(_bagType in DayZ_Backpacks) then
		{
			(vehicle _player) addBackpack _bagType;
			uiSleep 0.1;
		
			_array1 = _bagWeapons select 0;
			_array2 = _bagWeapons select 1;
		
			{
				(unitBackpack _player) addWeaponCargo [(_array1 select _forEachIndex),(_array2 select _forEachIndex)];
			}forEach _array1;
				
			_array1 = _bagMagazines select 0;
			_array2 = _bagMagazines select 1;
		
			{
				(unitBackpack _player) addMagazineCargo [(_array1 select _forEachIndex),(_array2 select _forEachIndex)];
			}forEach _array1;
		};
	} else {
		[dayz_playerUID,dayz_characterID,_skin] spawn player_humanityMorph;
	};
};

EAT_SpawnCrate = {
	private ["_crate","_player","_dir","_pos"];

	_crate = _this select 0;
	_player = player;

	// Location of player and crate
	_dir = getDir _player;
	_pos = getposATL _player;
	_pos = [(_pos select 0)+3*sin(_dir),(_pos select 1)+3*cos(_dir), (_pos select 2)];

	EAT_selectDelay = 0;

	// Run delaymenu
	EAT_delaymenu = 
	[
		["",true],
		["Select delay", [-1], "", -5, [["expression", ""]], "1", "0"],
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
		["30 seconds", [], "", -5, [["expression", "EAT_selectDelay=30;"]], "1", "1"],
		["1 min", [], "", -5, [["expression", "EAT_selectDelay=60;"]], "1", "1"],
		["3 min", [], "", -5, [["expression", "EAT_selectDelay=180;"]], "1", "1"],
		["5 min", [], "", -5, [["expression", "EAT_selectDelay=300;"]], "1", "1"],
		["10 min", [], "", -5, [["expression", "EAT_selectDelay=600;"]], "1", "1"],
		["30 min", [], "", -5, [["expression", "EAT_selectDelay=1800;"]], "1", "1"],
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
		["No timer", [], "", -5, [["expression", "EAT_selectDelay=0;"]], "1", "1"],
		["", [-1], "", -5, [["expression", ""]], "1", "0"]
	];
	showCommandingMenu "#USER:EAT_delaymenu";

	WaitUntil{commandingMenu == ""};

	EAT_clientToServer = ["crate",player,[EAT_selectDelay,_crate,_dir,_pos],dayz_authKey];
	publicVariableServer "EAT_clientToServer";
	
	if(EAT_logMajorTool) then {format["%1 %2 -- has added a %3 crate",name _player,getPlayerUID _player,_crate] call EAT_Logger;};

	if(EAT_selectDelay != 0) then {
		format[_crate + " crate will disappear in %1 seconds.",EAT_selectDelay] call dayz_rollingMessages;
	} else {
		format[_crate + " has no timer. Shoot it to destroy."] call dayz_rollingMessages;
	};
};

EAT_Spectate = {
	private ["_mycv","_max","_j","_name","_player","_menuCheckOk"];

	_mycv = cameraView;
	_player = player;
	_menuCheckOk = false;
	_max = 10;
	_j = 0;
	_name = "";


	EAT_pMenuTitle = "Spectate Player:";
	snext = false;
	plist = [];  
	pselect5 = "";
	spectate = true;

	{if (_x != _player) then {plist set [count plist, name _x];};} forEach playableUnits;

	while {pselect5 == "" && !_menuCheckOk} do
	{
		[_j, (_j + _max) min (count plist)] call EAT_fnc_playerSelect; _j = _j + _max;
		WaitUntil {pselect5 != "" || snext || commandingMenu == ""};
		_menuCheckOk = (commandingMenu == "");
		snext = false;
	};

	if (pselect5!= "exit" && pselect5!="") then
	{
		_name = pselect5;
		{
			if(format[name _x] == _name) then 
			{	
				["Spectate"] call EAT_Keybind;
				(vehicle _x) switchCamera "EXTERNAL";
				"F6 to return" call dayz_rollingMessages;
				waitUntil {uiSleep 1; !(alive _x) or !(alive player) or !(spectate)};
				["EndSpectate"] call EAT_Keybind;
				player switchCamera _mycv;	

				// Tool use logger
				if(EAT_logMajorTool) then {format["%1 %2 -- has begun spectating %3",name _player,getPlayerUID _player,_name] call EAT_Logger;};
			};
		} forEach playableUnits;
	};
	spectate = false;
	if (!spectate && pselect5 != "exit") then 
	{	
		"Spectate done" call dayz_rollingMessages;

		// Tool use logger
		if(EAT_logMajorTool) then {format["%1 %2 -- has stopped spectating %3",name _player,getPlayerUID _player,_name] call EAT_Logger;};
	};
};

EAT_LocateVeh = {
	private ["_inv","_searchString","_ID","_found","_targetColor","_finalID","_targetPosition","_targetVehicle","_count","_key","_keyName","_showMapMarker","_markerColour","_locatorMarker"];

	/****************************************| Config |**************************************************************************************/

	_showMapMarker = True;            // True = display the map markers, False = just identify the keys
	_markerColour = "ColorOrange";    // Alternatives = "ColorBlack", "ColorRed", "ColorGreen", "ColorBlue", "ColorYellow", "ColorWhite"

	/****************************************| Config |**************************************************************************************/

	if( isNil "locateVehicle") then {locateVehicle = true;} else {locateVehicle = !locateVehicle};

	if(locateVehicle) then {

		_inv = [player] call BIS_fnc_invString;
		_keyColor = [];
		_keyID = [];
		_removedID = [];
		_count = 0;

		if (!("ItemGPS" in _inv)) then {player addWeapon "ItemGPS";};

		{
			for "_i" from 1 to 2500 do {
				_searchString = format ["ItemKey%1%2",_x,str(_i)];
				if ((_searchString in _inv)) then {
					_count = _count + 1;
					_targetColor = _x;
					_keyColor = _keyColor + [_targetColor];
					_ID = str(_i);
					_ID = parseNumber _ID;
					if (_targetColor == "Green") then { _finalID = _ID; };
					if (_targetColor == "Red") then { _finalID = _ID + 2500; };
					if (_targetColor == "Blue") then { _finalID = _ID + 5000; };
					if (_targetColor == "Yellow") then { _finalID = _ID + 7500; };
					if (_targetColor == "Black") then { _finalID = _ID + 10000; };
					_keyID = _keyID + [_finalID];
					_removedID = _removedID + [_ID];
				};
			};
		} forEach ["Black","Yellow","Blue","Green","Red"];

		_i = 0;
		for "_i" from 0 to 10 do {deleteMarkerLocal ("locatorMarker"+ (str _i));};

		if (_count == 0) exitWith {"Place a key in your inventory to find that vehicle." call dayz_rollingMessages; locateVehicle = false;};
		format["Found: %1 vehicle key",_count] call dayz_rollingMessages;

		_count = _count - 1;

		_i = 0;
		for "_i" from 0 to _count do {
			_finalID = _keyID select _i;
			_ID = _removedID select _i;
			_targetColor = _keyColor select _i;
			_key = format["ItemKey%1%2",_targetColor,_ID];
			_keyName = getText (configFile >> "CfgWeapons" >> _key >> "displayName");
			_found = 0;
			
			{
				private ["_tID","_vehicle_type"];
				_vehicle_type = typeOf _x;
				_tID = parseNumber (_x getVariable ["CharacterID","0"]);
				if ((_tID == _finalID) && ((_vehicle_type isKindOf "Air") || (_vehicle_type isKindOf "LandVehicle") || (_vehicle_type isKindOf "Ship"))) then {
					_targetPosition = getPosATL _x;
					_targetVehicle = _x;
					_found = 1;
				};
			} forEach vehicles;

			if (_found != 0) then {
				_vehicleName = gettext (configFile >> "CfgVehicles" >> (typeof _targetVehicle) >> "displayName");
				if (_showMapMarker) then {
					_Marker = "locatorMarker" + (str _i);
					_locatorMarker = createMarkerLocal [_Marker,[(_targetPosition select 0),(_targetPosition select 1)]];
					_locatorMarker setMarkerShapeLocal "ICON";
					_locatorMarker setMarkerTypeLocal "DOT";
					_locatorMarker setMarkerColorLocal _markerColour;
					_locatorMarker setMarkerSizeLocal [1.0, 1.0];
					_locatorMarker setMarkerTextLocal format ["locator: %1",_vehicleName];
				} else { 
					format["%1 belongs to %2 - %3",_keyName,_vehicleName,_finalID] call dayz_rollingMessages;
				};
			} else {
				format["%1 - Vehicle ID: %2 - (This vehicle no longer exists in the database)",_keyName,_finalID] call dayz_rollingMessages;
			};
		};

		if (_showMapMarker) then {
			"Map markers added. Run this again to remove them." call dayz_rollingMessages;
		};
	} else {
		_i=0;
		for "_i" from 0 to 10 do {deleteMarkerLocal ("locatorMarker"+ (str _i));};
		"Map markers removed" call dayz_rollingMessages;
	};
};

EAT_SpawnZombie = {
	private["_zCreate","_zPos","_setZedType","_zSpawnFnc","_zSpawnFnc","_player"];
	zTypes = ["zZombie_Base","z_villager1","z_villager2","z_villager3","z_suit1","z_suit2","z_worker1","z_worker2","z_worker3","z_soldier","z_soldier_heavy","z_soldier_pilot","z_policeman","z_teacher","z_doctor","z_hunter","z_priest"];

	EAT_area = 0;
	zCount = 0;
	_player = player;

	_areaMenu =
	[
	["",true],
		["Set Radius:", [-1], "", -5, [["expression", ""]], "1", "0"],
		["5m",[],"", -5,[["expression","EAT_area = 5;"]],"1","1"],
		["10m",[],"", -5,[["expression","EAT_area = 10;"]],"1","1"],
		["20m",[],"", -5,[["expression","EAT_area = 20;"]],"1","1"],
		["30m",[],"", -5,[["expression","EAT_area = 30;"]],"1","1"],
		["40m",[],"", -5,[["expression","EAT_area = 40;"]],"1","1"],
		["50m",[],"", -5,[["expression","EAT_area = 50;"]],"1","1"],
		["75m",[],"", -5,[["expression","EAT_area = 75;"]],"1","1"],
		["100m",[],"", -5,[["expression","EAT_area = 100;"]],"1","1"],
		["125m",[],"", -5,[["expression","EAT_area = 125;"]],"1","1"],
		["150m",[],"", -5,[["expression","EAT_area = 150;"]],"1","1"],
		["200m",[],"", -5,[["expression","EAT_area = 200;"]],"1","1"],
		["", [], "", -5,[["expression", ""]], "1", "0"],
			["Exit", [20], "", -5, [["expression", "EAT_area = -1;"]], "1", "1"]
	];

	_amountMenu =
	[
	["",true],
		["Select zombie count:", [-1], "", -5, [["expression", ""]], "1", "0"],
		["1",[],"", -5,[["expression","zCount = 1;"]],"1","1"],
		["2",[],"", -5,[["expression","zCount = 2;"]],"1","1"],
		["3",[],"", -5,[["expression","zCount = 3;"]],"1","1"],
		["4",[],"", -5,[["expression","zCount = 4;"]],"1","1"],
		["5",[],"", -5,[["expression","zCount = 5;"]],"1","1"],
		["10",[],"", -5,[["expression","zCount = 10;"]],"1","1"],
		["20",[],"", -5,[["expression","zCount = 20;"]],"1","1"],
		["30",[],"", -5,[["expression","zCount = 30;"]],"1","1"],
		["40",[],"", -5,[["expression","zCount = 40;"]],"1","1"],
		["50",[],"", -5,[["expression","zCount = 50;"]],"1","1"],
		["100",[],"", -5,[["expression","zCount = 100;"]],"1","1"],
		["", [], "", -5,[["expression", ""]], "1", "0"],
			["Exit", [20], "", -5, [["expression", "zCount = -1;"]], "1", "1"]
	];

	showCommandingMenu "#USER:_areaMenu";
	waitUntil{(EAT_area != 0) || (commandingMenu == "")};
	if(EAT_area <= 0) exitWith{};

	showCommandingMenu "#USER:_amountMenu";
	waitUntil{(zCount != 0) || (commandingMenu == "")};
	if(zCount <= 0) exitWith{};

	if(EAT_logMajorTool) then {format["%1 %2 -- has added %3 zombies",name _player,getPlayerUID _player,zCount] call EAT_Logger;};

	_i = 1;
	for "_i" from 1 to zCount do {
		[zTypes] spawn {
			zTypes = _this select 0;
			_setZedType = zTypes call BIS_fnc_selectRandom;
			_zCreate = createAgent [_setZedType, position player, [], EAT_area, "NONE"];
			_zPos = getPosATL _zCreate;
			[_zPos,_zCreate] execFSM "\z\addons\dayz_code\system\zombie_agent.fsm";
		};
	};
};

EAT_AdminBuild = {
	private ["_abort","_reason","_distance","_isNear","_lockable","_isAllowedUnderGround","_offset","_classname",
	"_zheightdirection","_zheightchanged","_rotate","_objectHelperPos","_objectHelperDir","_objHDiff","_position",
	"_isOk","_dir","_vector","_cancel","_location2","_buildOffset","_location",
	"_counter","_dis","_sfx","_combination_1_Display","_combination_1",
	"_combination_2","_combination_3","_combination","_combinationDisplay","_combination_4","_num_removed",
	"_tmpbuilt","_vUp","_classnametmp","_text","_ghost","_objectHelper","_location1","_object","_helperColor",
	"_canDo","_pos","_onLadder","_vehicle","_inVehicle","_isPole","_isPerm","_moveDistanceOriginal"];

	//Check if building already in progress, exit if so.
	if (dayz_actionInProgress) exitWith {localize "str_epoch_player_40" call dayz_rollingMessages;};
	dayz_actionInProgress = true;

	_pos = [player] call FNC_GetPos;

	_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;

	_vehicle = vehicle player;
	_inVehicle = (_vehicle != player);
	_isPerm = false;

	DZE_Q = false;
	DZE_Z = false;

	DZE_Q_alt = false;
	DZE_Z_alt = false;

	DZE_Q_ctrl = false;
	DZE_Z_ctrl = false;

	DZE_5 = false;
	DZE_4 = false;
	DZE_6 = false;

	DZE_F = false;

	DZE_cancelBuilding = false;

	DZE_updateVec = false;
	DZE_memDir = 0;
	DZE_memForBack = 0;
	DZE_memLeftRight = 0;

	call gear_ui_init;
	closeDialog 1;

	if (dayz_isSwimming) exitWith {dayz_actionInProgress = false; localize "str_player_26" call dayz_rollingMessages;};
	if (_inVehicle) exitWith {dayz_actionInProgress = false; localize "str_epoch_player_42" call dayz_rollingMessages;};
	if (_onLadder) exitWith {dayz_actionInProgress = false; localize "str_player_21" call dayz_rollingMessages;};

	DZE_buildItem =	_this select 0;
	if(isNil "adminRebuildItem" && DZE_buildItem == "rebuild") exitWith {dayz_actionInProgress = false; systemChat "You have not selected a buildable item yet"};
	if(DZE_buildItem == "rebuild") then {
		DZE_buildItem =	adminRebuildItem;
		_isPerm = adminRebuildPerm;
	} else {
		adminRebuildItem = DZE_buildItem;
		adminRebuildPerm = _this select 1;
		_isPerm = adminRebuildPerm;
	};

	_classname = DZE_buildItem;
	_classnametmp = _classname;

	_text = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
	if(isNil "_text") then {
		_text = _classname;
	};
	_ghost = getText (configFile >> "CfgVehicles" >> _classname >> "ghostpreview");

	_lockable = 0; //default define if lockable not found in config file below
	if(isNumber (configFile >> "CfgVehicles" >> _classname >> "lockable")) then { //find out if item is lockable object
		_lockable = getNumber(configFile >> "CfgVehicles" >> _classname >> "lockable"); // 2=lockbox, 3=combolock, 4=safe
	};

	_isAllowedUnderGround = 1; //check if allowed to build under terrain
	if(isNumber (configFile >> "CfgVehicles" >> _classname >> "nounderground")) then {
		_isAllowedUnderGround = getNumber(configFile >> "CfgVehicles" >> _classname >> "nounderground");
	};

	_offset = 	getArray (configFile >> "CfgVehicles" >> _classname >> "offset"); //check default distance offset, define if does not exist

	if((count _offset) <= 0) then {
		_offset = [0,2,0];
	};

	_isPole = (_classname == "Plastic_Pole_EP1_DZ");

	_distance = DZE_PlotPole select 0;
	_needText = localize "str_epoch_player_246";

	if(_isPole) then {
		_distance = DZE_PlotPole select 1;
	};

	// check for near plot
	_findNearestPoles = nearestObjects [(vehicle player), ["Plastic_Pole_EP1_DZ"], _distance];
	_findNearestPole = [];

	{
		if (alive _x) then {
			_findNearestPole set [(count _findNearestPole),_x];
		};
	} count _findNearestPoles;

	_IsNearPlot = count (_findNearestPole);

	// If item is plot pole && another one exists within 45m
	if(_isPole && _IsNearPlot > 0) exitWith {dayz_actionInProgress = false; cutText ["You are too close to another plot pole" , "PLAIN DOWN"]; };

	_objectHelper = objNull;
	_isOk = true;
	_location1 = [player] call FNC_GetPos; // get inital players position
	_dir = getDir player; //required to pass direction when building

	// if ghost preview available use that instead
	if (_ghost != "") then {
		_classname = _ghost;
	};

	_object = createVehicle [_classname, [0,0,0], [], 0, "CAN_COLLIDE"]; //object preview, not an actual object that will be built

	if((count _offset) <= 0) then {
		_offset = [0,(abs(((boundingBox _object)select 0) select 1)),0];
	};

	_objectHelper = "Sign_sphere10cm_EP1" createVehicle [0,0,0];
	_helperColor = "#(argb,8,8,3)color(0,0,0,0,ca)";
	_objectHelper setObjectTexture [0,_helperColor];
	_objectHelper attachTo [player,_offset];
	_object attachTo [_objectHelper,[0,0,0]];

	if (isClass (configFile >> "SnapBuilding" >> _classname)) then {	
		["","","",["Init",_object,_classname,_objectHelper]] spawn snap_build;
	};

	// Do not turn on vectors for GUI spawned buildings
	if !(DZE_buildItem in DZE_noRotate) then{
		["","","",["Init","Init",0]] spawn build_vectors;
	};

	_objHDiff = 0;	
	_cancel = false;
	_reason = "";

	helperDetach = false;
	_canDo = (!r_drag_sqf and !r_player_unconscious);
	_position = [_objectHelper] call FNC_GetPos;

	while {_isOk} do {
		_zheightchanged = false;
		_zheightdirection = "";
		_rotate = false;

		if (DZE_Q) then {
			DZE_Q = false;
			_zheightdirection = "up";
			_zheightchanged = true;
		};
		if (DZE_Z) then {
			DZE_Z = false;
			_zheightdirection = "down";
			_zheightchanged = true;
		};
		if (DZE_Q_alt) then {
			DZE_Q_alt = false;
			_zheightdirection = "up_alt";
			_zheightchanged = true;
		};
		if (DZE_Z_alt) then {
			DZE_Z_alt = false;
			_zheightdirection = "down_alt";
			_zheightchanged = true;
		};
		if (DZE_Q_ctrl) then {
			DZE_Q_ctrl = false;
			_zheightdirection = "up_ctrl";
			_zheightchanged = true;
		};
		if (DZE_Z_ctrl) then {
			DZE_Z_ctrl = false;
			_zheightdirection = "down_ctrl";
			_zheightchanged = true;
		};
		if (DZE_4) then {
			_rotate = true;
			DZE_4 = false;
			if(DZE_dirWithDegrees) then{
				DZE_memDir = DZE_memDir - DZE_curDegree;
			}else{
				DZE_memDir = DZE_memDir - 45;
			};
		};
		if (DZE_6) then {
			_rotate = true;
			DZE_6 = false;
			if(DZE_dirWithDegrees) then{
				DZE_memDir = DZE_memDir + DZE_curDegree;
			}else{
				DZE_memDir = DZE_memDir + 45;
			};
		};
			
		if(DZE_updateVec) then{
			[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
			DZE_updateVec = false;
		};
		
		if (DZE_F and _canDo) then {
			if (helperDetach) then {
				_objectHelper attachTo [player];
				DZE_memDir = DZE_memDir-(getDir player);
				helperDetach = false;
				[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
			} else {		
				_objectHelperPos = getPosATL _objectHelper;
				detach _objectHelper;			
				DZE_memDir = getDir _objectHelper;
				[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
				_objectHelper setPosATL _objectHelperPos;
				_objectHelper setVelocity [0,0,0]; //fix sliding glitch
				helperDetach = true;
			};
			DZE_F = false;
		};
		
		if(_rotate) then {
			[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
		};

		if(_zheightchanged) then {
			if (!helperDetach) then {
			detach _objectHelper;
			_objectHelperDir = getDir _objectHelper;
			};

			_position = [_objectHelper] call FNC_GetPos;

			if(_zheightdirection == "up") then {
				_position set [2,((_position select 2)+0.1)];
				_objHDiff = _objHDiff + 0.1;
			};
			if(_zheightdirection == "down") then {
				_position set [2,((_position select 2)-0.1)];
				_objHDiff = _objHDiff - 0.1;
			};

			if(_zheightdirection == "up_alt") then {
				_position set [2,((_position select 2)+1)];
				_objHDiff = _objHDiff + 1;
			};
			if(_zheightdirection == "down_alt") then {
				_position set [2,((_position select 2)-1)];
				_objHDiff = _objHDiff - 1;
			};

			if(_zheightdirection == "up_ctrl") then {
				_position set [2,((_position select 2)+0.01)];
				_objHDiff = _objHDiff + 0.01;
			};
			if(_zheightdirection == "down_ctrl") then {
				_position set [2,((_position select 2)-0.01)];
				_objHDiff = _objHDiff - 0.01;
			};

			if((_isAllowedUnderGround == 0) && ((_position select 2) < 0)) then {
				_position set [2,0];
			};

			if (surfaceIsWater _position) then {
				_objectHelper setPosASL _position;
			} else {
				_objectHelper setPosATL _position;
			};

			if (!helperDetach) then {
			_objectHelper attachTo [player];
			};
			[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
		};

		uiSleep 0.5;

		_location2 = [player] call FNC_GetPos;
		_objectHelperPos = [_objectHelper] call FNC_GetPos;
			
		if(DZE_5) exitWith {
			_position = [_object] call FNC_GetPos;
			detach _object;
			_dir = getDir _object;
			_vector = [(vectorDir _object),(vectorUp _object)];	
			deleteVehicle _object;
			detach _objectHelper;
			deleteVehicle _objectHelper;
		};

		if(_location1 distance _location2 > DZE_buildMaxMoveDistance) exitWith {
			_cancel = true;
			_reason = format[localize "STR_EPOCH_BUILD_FAIL_MOVED",DZE_buildMaxMoveDistance];
			detach _object;
			deleteVehicle _object;
			detach _objectHelper;
			deleteVehicle _objectHelper;
		};
			
		if(_location1 distance _objectHelperPos > DZE_buildMaxMoveDistance) exitWith {
			_cancel = true;
			_reason = format[localize "STR_EPOCH_BUILD_FAIL_TOO_FAR",DZE_buildMaxMoveDistance];
			detach _object;
			deleteVehicle _object;
			detach _objectHelper;
			deleteVehicle _objectHelper;
		};

		if (DZE_cancelBuilding) exitWith {
			_cancel = true;
			_reason = localize "STR_EPOCH_PLAYER_46";
			detach _object;
			deleteVehicle _object;
			detach _objectHelper;
			deleteVehicle _objectHelper;
		};
	};
	_proceed = false;
	_counter = 0;
	_location = [0,0,0];

	if(!_cancel) then {

		_classname = _classnametmp;

		// Start Build
		_tmpbuilt = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"]; //create actual object that will be published to database

		_tmpbuilt setdir _dir; //set direction inherited from passed args from control
		_tmpbuilt setVariable["memDir",_dir,true];
		//if (isBuilding) then {_tmpbuilt setVariable["EAT_Building",1,true];};

		// Get position based on object
		_location = _position;

		if((_isAllowedUnderGround == 0) && ((_location select 2) < 0)) then { //check Z axis if not allowed to build underground
			_location set [2,0]; //reset Z axis to zero (above terrain)
		};
			
		_tmpbuilt setVectorDirAndUp _vector;
			
		_buildOffset = [0,0,0];
		_vUp = _vector select 1;
		switch (_classname) do {
			case "MetalFloor_DZ": { _buildOffset = [(_vUp select 0) * .148, (_vUp select 1) * .148,0]; };
			//case "CinderWall_DZ": { _buildOffset = [(_vUp select 0) * 1.686, (_vUp select 1) * 1.686,0]; };
		};
			
		_location = [
			(_location select 0) - (_buildOffset select 0),
			(_location select 1) - (_buildOffset select 1),
			(_location select 2) - (_buildOffset select 2)
		];
		
		if (surfaceIsWater _location) then {
			_tmpbuilt setPosASL _location;
			_location = ASLtoATL _location; //Database uses ATL
		} else {
			_tmpbuilt setPosATL _location;
		};

		//format[localize "str_epoch_player_138",_text] call dayz_rollingMessages;

		call player_forceSave;
			
		format[localize "str_build_01",_text] call dayz_rollingMessages;

		_tmpbuilt setVariable ["OEMPos",_location,true]; //store original location as a variable
		
		if(_isPerm) then {
			_tmpbuilt setVariable ["CharacterID",dayz_characterID,true];
			// fire?
			if(_tmpbuilt isKindOf "Land_Fire_DZ") then { //if campfire, then spawn, but do not publish to database
				_tmpbuilt spawn player_fireMonitor;
			} else {
				if (DZE_permanentPlot) then {
					_tmpbuilt setVariable ["ownerPUID",dayz_playerUID,true];
					if (_isPole) then {
						_friendsArr = [[dayz_playerUID,toArray (name player)]];
						_tmpbuilt setVariable ["plotfriends", _friendsArr, true];
						PVDZ_obj_Publish = [dayz_characterID,_tmpbuilt,[_dir,_location,dayz_playerUID,_vector],_friendsArr,player,dayz_authKey];
					} else {
						PVDZ_obj_Publish = [dayz_characterID,_tmpbuilt,[_dir,_location,dayz_playerUID,_vector],[],player,dayz_authKey];
					};
				} else {
					PVDZ_obj_Publish = [dayz_characterID,_tmpbuilt,[_dir,_location, _vector],[]];
				};
				publicVariableServer "PVDZ_obj_Publish";
			};
		};

		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has used admin build to place: %3",name player,getPlayerUID player,_tmpbuilt] call EAT_Logger;};
		
	} else { //cancel build if passed _cancel arg was true or building on roads/trader city
		format[localize "str_epoch_player_47",_text,_reason] call dayz_rollingMessages;
	};

	dayz_actionInProgress = false;
};

EAT_BuildingDialog = {
	private ["_dialog","_building"];
	PermDialogSelected = -1;
	TempDialogSelected = -1;
	AdminDialogList = 13000;
	buildingList = EAT_allBuildingList;

	_dialog = createDialog "EAT_build_AdminDialog";
	lbClear AdminDialogList;

	{
		private ["_index"];
		_index = lbAdd [AdminDialogList, format["%1 - %2 (%3)", _x select 0, _x select 1, _x select 2]];
		lbSetPicture [AdminDialogList, _index];
	} forEach buildingList;

	LoadSpecificList = {
		lbClear AdminDialogList;
		buildingList = _this select 0;
		
		switch(buildingList) do
		{
			case "Cinder":
			{
				buildingList = EAT_buildCinder;
			};
			case "Wood":
			{
				buildingList = EAT_buildWood;
			};
			case "Metal":
			{
				buildingList = EAT_buildMetal;
			};
			case "Nets":
			{
				buildingList = EAT_buildNets;
			};
			case "Storage":
			{
				buildingList = EAT_buildStorage;
			};
			case "Sandbags":
			{
				buildingList = EAT_buildSandbags;
			};
			case "Misc":
			{
				buildingList = EAT_buildMisc;
			};
		};
		
		lbClear AdminDialogList;

		{
			private ["_index", "_x"];
			_index = lbAdd [AdminDialogList, format["%1 - %2 (%3)", _x select 0, _x select 1, _x select 2]];
			lbSetPicture [AdminDialogList, _index];
		} forEach buildingList;
	};

	waitUntil { !dialog };
	if ((PermDialogSelected < 0) && (TempDialogSelected < 0)) exitWith {};

	if (PermDialogSelected > -1) then {
		_building = ((buildingList select PermDialogSelected) select 2);
		[_building,true] spawn EAT_AdminBuild;
	};

	if (TempDialogSelected > -1) then {
		_building = ((buildingList select TempDialogSelected) select 2);
		[_building,false] spawn EAT_AdminBuild;
	};
};

EAT_MaintainArea = {
	private ["_target","_objectClasses","_range","_objects","_count","_findNearestPole","_IsNearPlot","_objects_filtered"];

	player removeAction s_player_maintain_area;
	s_player_maintain_area = 1;
	player removeAction s_player_maintain_area_preview;
	s_player_maintain_area_preview = 1;

	// check for near plot
	_target = nearestObjects [(vehicle player), ["Plastic_Pole_EP1_DZ"], 20];
	_findNearestPole = [];

	{
		if (alive _x) then {
			_findNearestPole set [(count _findNearestPole),_x];
		};
	} count _target;

	_IsNearPlot = count (_findNearestPole);
	if(_IsNearPlot < 1) exitWith {s_player_maintain_area_preview = -1;s_player_maintain_area = -1; "No plot pole found in 20 meters" call dayz_rollingMessages;};
	_target = _target select 0;
	_objectClasses = DZE_maintainClasses;
	_range = DZE_maintainRange; // set the max range for the maintain area
	_objects = nearestObjects [_target, _objectClasses, _range];

	//filter to only those that have 10% damage
	_objects_filtered = [];
	{
		if (damage _x >= DZE_DamageBeforeMaint) then {
			_objects_filtered set [count _objects_filtered, _x];
	   };
	} count _objects;
	_objects = _objects_filtered;

	// TODO dynamic requirements based on used building parts?
	_count = count _objects;

	if (_count == 0) exitWith {
		cutText [format[(localize "STR_EPOCH_ACTIONS_22"), _count], "PLAIN DOWN"];
		s_player_maintain_area = -1;
		s_player_maintain_area_preview = -1;
	};

	// all required items removed from player gear
	cutText [format[(localize "STR_EPOCH_ACTIONS_4"), _count], "PLAIN DOWN", 5];
	PVDZE_maintainArea = [player,1,_target];
	publicVariableServer "PVDZE_maintainArea";	

	// Tool use logger
	if(EAT_logMinorTool) then {format["%1 %2 -- has used admin build to maintain an area",name player,getPlayerUID player] call EAT_Logger;};

	s_player_maintain_area = -1;
	s_player_maintain_area_preview = -1;
};

EAT_DownGrade = {
	private ["_location","_dir","_classname","_text","_object","_objectID","_objectUID","_newclassname","_obj","_downgrade","_objectCharacterID"];

	player removeAction s_player_downgrade_build;
	s_player_downgrade_build = 1;

	// get cursor target
	_obj = cursorTarget;
	if(isNull _obj) exitWith {s_player_downgrade_build = -1; "No Object Selected" call dayz_rollingMessages};

	_objectCharacterID 	= _obj getVariable ["CharacterID","0"];// Current charID

	if (DZE_Lock_Door != _objectCharacterID) exitWith {s_player_downgrade_build = -1; localize "str_epoch_player_49" call dayz_rollingMessages;};

	_objectID 	= _obj getVariable ["ObjectID","0"];// Find objectID
	_objectUID	= _obj getVariable ["ObjectUID","0"];// Find objectUID

	if(_objectID == "0" && _objectUID == "0") exitWith {s_player_downgrade_build = -1; localize "str_epoch_player_50" call dayz_rollingMessages;};

	// Get classname
	_classname = typeOf _obj;

	// Find display name
	_text = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");

	// Find next downgrade
	_downgrade = getArray (configFile >> "CfgVehicles" >> _classname >> "downgradeBuilding");

	if ((count _downgrade) > 0) then {

		_newclassname = _downgrade select 0;

		// Get position
		_location	= _obj getVariable["OEMPos",(getposATL _obj)];

		// Get direction
		_dir = getDir _obj;
		_vector = [(vectorDir _obj),(vectorUp _obj)];

		// Reset the character ID on locked doors before they inherit the newclassname
		if (_classname in DZE_DoorsLocked) then {
			_obj setVariable ["CharacterID",dayz_characterID,true];
			_objectCharacterID = dayz_characterID;
		};

		_classname = _newclassname;
		_object = createVehicle [_classname, [0,0,0], [], 0, "CAN_COLLIDE"];
		_object setDir _dir;
		_object setVariable["memDir",_dir,true];
		_object setVectorDirAndUp _vector;
		_object setPosATL _location;

		format[localize "str_epoch_player_142",_text] call dayz_rollingMessages;
		
		if (DZE_GodModeBase && {!(_classname in DZE_GodModeBaseExclude)}) then {
				_object addEventHandler ["HandleDamage",{false}];
			};

		if (DZE_permanentPlot) then {
				_ownerID = _obj getVariable["ownerPUID","0"];
				_object setVariable ["ownerPUID",_ownerID,true];
				PVDZE_obj_Swap = [_objectCharacterID,_object,[_dir,_location,dayz_playerUID,_vector],_classname,_obj,player,[],dayz_authKey];
			} else {
				PVDZE_obj_Swap = [_objectCharacterID,_object,[_dir,_location, _vector],_classname,_obj,player,[],dayz_authKey];
			};
			publicVariableServer "PVDZE_obj_Swap";

		player reveal _object;

		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has used admin build to downgrade: %3",name player,getPlayerUID player,_obj] call EAT_Logger;};

	} else {
		localize "str_epoch_player_51" call dayz_rollingMessages;
	};

	s_player_downgrade_build = -1;
};

EAT_Upgrade = {
	private ["_location","_dir","_classname","_text","_object","_objectID","_objectUID","_newclassname","_obj","_upgrade","_lockable",
	"_combination_1","_combination_2","_combination_3","_combination","_objectCharacterID"];

	player removeAction s_player_upgrade_build;
	s_player_upgrade_build = 1;

	_obj = cursorTarget;
	if(isNull _obj) exitWith {s_player_upgrade_build = -1; "No Object Selected" call dayz_rollingMessages;};

	_objectID 	= _obj getVariable ["ObjectID","0"]; // Find objectID
	_objectUID	= _obj getVariable ["ObjectUID","0"];// Find objectUID

	if (_objectID == "0" && _objectUID == "0") exitWith {s_player_upgrade_build = -1; localize "str_epoch_player_50" call dayz_rollingMessages;};

	_classname = typeOf _obj;
	_text = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
	_upgrade = getArray (configFile >> "CfgVehicles" >> _classname >> "upgradeBuilding");

	if ((count _upgrade) > 0) then {
		_newclassname = _upgrade select 0;
		_lockable = 0;
		if(isNumber (configFile >> "CfgVehicles" >> _newclassname >> "lockable")) then {
			_lockable = getNumber(configFile >> "CfgVehicles" >> _newclassname >> "lockable");
		};

		_location	= _obj getVariable["OEMPos",(getposATL _obj)];
		_dir = getDir _obj;
		_vector = [(vectorDir _obj),(vectorUp _obj)];
		_objectCharacterID 	= _obj getVariable ["CharacterID","0"];
		_classname = _newclassname;
		_object = createVehicle [_classname, [0,0,0], [], 0, "CAN_COLLIDE"];
		_object setDir _dir;
		_object setVariable["memDir",_dir,true];
		_object setVectorDirAndUp _vector;
		_object setPosATL _location;

		if (_lockable == 3) then {
			_combination_1 = floor(random 10);
			_combination_2 = floor(random 10);
			_combination_3 = floor(random 10);
			_combination = format["%1%2%3",_combination_1,_combination_2,_combination_3];
					
			_objectCharacterID = _combination;
			DZE_Lock_Door = _combination;
					
			format[localize "str_epoch_player_158",_combination,_text] call dayz_rollingMessages;
					systemChat format[localize "str_epoch_player_158",_combination,_text];
		} else {	
			format[localize "str_epoch_player_159",_text] call dayz_rollingMessages;
		};
		if (DZE_GodModeBase && {!(_classname in DZE_GodModeBaseExclude)}) then {
			_object addEventHandler ["HandleDamage",{false}];
		};
		if (DZE_permanentPlot) then {
			_ownerID = _obj getVariable["ownerPUID","0"];
			_object setVariable ["ownerPUID",_ownerID,true];
			PVDZE_obj_Swap = [_objectCharacterID,_object,[_dir,_location,_ownerID,_vector],_classname,_obj,player,[],dayz_authKey];
		} else {
			PVDZE_obj_Swap = [_objectCharacterID,_object,[_dir,_location,_vector],_classname,_obj,player,[],dayz_authKey];
		};
		publicVariableServer "PVDZE_obj_Swap";

		player reveal _object;

		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has used admin build to upgrade: %3",name player,getPlayerUID player,_obj] call EAT_Logger;};

	} else {
		localize "str_epoch_player_82" call dayz_rollingMessages;
	};

	s_player_upgrade_build = -1;
};

EAT_AdminModeToggle = {
	/*
		Below are the default ON/OFF toggles. Anything marked 
		true will turn on when you turn on AdminMode.
		To make an option default ON change = false to = true.
		To make an option default OFF change = true to = false.
		To disable an option entirely, go down to toggleMenu = 
	*/

	if (isNil "EAT_AdminMode") then {EAT_AdminMode = true;} else {EAT_AdminMode = !EAT_AdminMode;};

	optionMenu = 
	{
		toggleMenu = 
		[
			// To disable an option for admins place a // in the front of the line below
			// and change the initialization to false in the config at the top of this file
			["",true],
			["Toggle options:(current state)", [-1], "", -5, [["expression", ""]], "1", "0"],
			[format["Vehicle Speed Boost: %1",EAT_speedBoost],[0],"", -5, [["expression", 'EAT_speedBoost = [EAT_speedBoost,EAT_VehSpeedBoost] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			[format["Fast Forward: %1",EAT_fastWalk],[0],"", -5, [["expression", 'EAT_fastWalk = [EAT_fastWalk,EAT_FastForwardToggle] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			[format["Fast Up: %1",EAT_fastUp],[0],"", -5, [["expression", 'EAT_fastUp = [EAT_fastUp,EAT_fastUpToggle] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			[format["Enhanced ESP: %1",EAT_enhancedESPMode], [0], "", -5, [["expression", 'if (EAT_enhancedESPMode) then {EAT_enhancedESPMode = false; EATenhancedESP = false;} else {call EAT_enhancedESPToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Player ESP: %1",EAT_playerESPMode], [0], "", -5, [["expression", 'if (EAT_playerESPMode) then {EAT_playerESPMode = false; EATplayerESP = false;} else {call EAT_playerESPToggle}; [] spawn optionMenu']], "1", "1"],
			[format["Invisibility ON: %1",EAT_invisibility], [0], "", -5, [["expression", 'EAT_invisibility = [EAT_invisibility,EAT_AdminInvisible] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			[format["Flying ON: %1",EAT_flyingMode], [0], "", -5, [["expression", 'if (EAT_flyingMode) then {EAT_flyingMode = false; EATflying = false;} else {EAT_flyingMode = [EAT_flyingMode,EAT_flying] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Infinite Ammo: %1",EAT_infAmmo], [0], "", -5, [["expression", 'if (EAT_infAmmo) then {EAT_infAmmo = false; EATinfiniteAmmo = false;} else {EAT_infAmmo = [EAT_infAmmo,EAT_InfiniteAmmo] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["God Mode: %1",EAT_playerGod], [0], "", -5, [["expression", 'if (EAT_playerGod) then {EAT_playerGod = false; EATplayerGod = false;} else {EAT_playerGod = [EAT_playerGod,EAT_GodMode] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Car God Mode: %1",EAT_vehicleGod], [0], "", -5, [["expression", 'if (EAT_vehicleGod) then {EAT_vehicleGod = false; EATvehicleGod = false;} else {EAT_vehicleGod = [EAT_vehicleGod,EAT_VehGod] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Zombie Shield: %1",EAT_ZombieShield], [0], "", -5, [["expression", 'if (EAT_ZombieShield) then {EAT_ZombieShield = false; EAT_SheildMe = false;} else {EAT_ZombieShield = [EAT_ZombieShield,EAT_ZomShield] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Grass Off: %1",EAT_grassOff], [0], "", -5, [["expression", 'EAT_grassOff = [EAT_grassOff,EAT_GrassOffToggle] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			[format["Admin Fast Build (No Plot Req): %1",EAT_adminBuildMode], [0], "", -5, [["expression", 'EAT_adminBuildMode = [EAT_adminBuildMode,EAT_adminBuildCount] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			["", [], "", -5, [["expression", ""]], "1", "0"],
			["Exit", [0], "", -5, [["expression", ""]], "1", "1"]
		];
		showCommandingMenu "#USER:toggleMenu";
	};

	if(EAT_AdminMode) then {
		"***Press F4 to toggle AdminMode options***" call dayz_rollingMessages;
		["AdminMode"] call EAT_Keybind;
		call EAT_AdminToggleOn;
	} else{
		"Admin Mode - DISABLED" call dayz_rollingMessages;
		["EndAdminMode"] call EAT_Keybind;
		call EAT_AdminToggleOff;
	};
};

EAT_flying = {
	EATflying = _this select 0;
	 
	hovering = nil;
	hoverPos = nil;

	move_forward =
	{
		if ((getPosATL (vehicle player) select 2) > 1) then
		{
			_vehicle = (vehicle player);
			_vel = velocity _vehicle;
			_dir = direction _vehicle;
			_speed = 0.4; comment "Added speed";
			_vehicle setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+
			(cos _dir*_speed),0.4];
		};
	};

	move_left =
	{
		if ((getPosATL (vehicle player) select 2) > 1) then
		{
			_leftDirection = getdir (vehicle player);
			(vehicle player) setdir (_leftDirection) - 2;
		};
	};

	move_backward =
	{
		if ((getPosATL (vehicle player) select 2) > 1) then
		{
			_vehicle = (vehicle player);
			_vel = velocity _vehicle;
			_dir = direction _vehicle;
			_speed = -0.4; comment "Added speed";
			_vehicle setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+
			(cos _dir*_speed),0.4];
		};
	};

	move_right =
	{
		if ((getPosATL (vehicle player) select 2) > 1) then
		{
			_rightDirection = getdir (vehicle player);
			(vehicle player) setdir (_rightDirection) + 2;
			player setVariable["lastPos",1];player setVariable["lastPos",[]];
		};
	};

	move_up =
	{    
		_vehicle = (vehicle player);
		_vel = velocity _vehicle;
		_dir = direction _vehicle;
		_speed = 6; comment "Added speed";
		_vehicle setVelocity [(_vel select 0),(_vel select 1),8];
	};

	move_down =
	{
		if ((getPosATL (vehicle player) select 2) > 1) then
		{
			_vehicle = (vehicle player);
			_forwardCurrentDirection = getdir (vehicle player);
			_forwardCurrentPosition = getPosATL (vehicle player);
			(vehicle player) setdir _forwardCurrentDirection;
			_vehicle setVelocity [0,0,-4];
		};
	};

	toggle_hover =
	{
		if (isnil "hovering") then
		{
			hovering = true;
			"Hovering ON" call dayz_rollingMessages;
			hoverPos = getPosATL (vehicle player);
		}
		else
		{
			hovering = nil;
			"Hovering OFF" call dayz_rollingMessages;
			hoverPos = nil;
		};
	};

	// Tool use logger
	if(EAT_logMinorTool) then {format["%1 %2 -- has added flying",name player,getPlayerUID player]call EAT_Logger;};

	keyForward = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 17) then {call move_forward;}"];//W - Forward
	keyLeft = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 30) then {call move_left;}"];//A - Left
	keyBackward = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 31) then {call move_backward;}"];//S - Backward
	keyRight = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 32) then {call move_right;}"];//D - Right
	keyUp = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 16) then {call move_up;}"];//Q - Up
	keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 44) then {call move_down;}"];//Z - Down
	keyHover = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 57) then {call toggle_hover;}"];//SpaceBar - Toggle Hover


	[] spawn {
		while {EATflying} do
		{
			if (!isNil "hovering") then
			{
				(vehicle player) setVelocity [0,0,0.2];
			};
			uiSleep 0.01;
		};

		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has DISABLED flying",name player,getPlayerUID player] call EAT_Logger;};

		(findDisplay 46) displayRemoveEventHandler ["KeyDown", keyForward];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", keyLeft];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", keyBackward];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", keyRight];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", keyUp];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", keyDown];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", keyHover];

		hovering = nil;
		hoverPos = nil;
	};
};

EAT_EnhancedESP = {
	if(isNil "markers") then { markers = []};
	if(isNil "vehList") then { vehList = []};
	if(isNil "unlockedVehList") then { unlockedVehList = []};
	if(isNil "lockedVehList") then { lockedVehList = []};
	if(isNil "changed") then {changed = false};
	if(isNil "toggleCheck") then {toggleCheck = 0};
	if(isNil "delayTime") then {delayTime = 0};
	if(isNil "poleList") then {poleList = [];};
	if(isNil "storageList") then {storageList = [];};
	if(isNil "buildableObjectsList") then {buildableObjectsList = [];};
	if(isNil "crashList") then {crashList = [];};
	if(isNil "storageObjects") then {storageObjects = ["TentStorage","TentStorageDomed","TentStorageDomed2","VaultStorageLocked","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","StorageShed_DZ","LockboxStorageLocked","GunRack_DZ","WoodCrate_DZ"];};
	if(isNil "buildableObjects") then {buildableObjects = ["WoodFloor_DZ","WoodLargeWall_DZ","WoodLargeWallDoor_DZ","WoodLargeWallWin_DZ","WoodSmallWall_DZ","WoodSmallWallWin_DZ","WoodSmallWallDoor_DZ","WoodFloorHalf_DZ","WoodFloorQuarter_DZ","WoodStairs_DZ","WoodStairsSans_DZ","WoodStairsRails_DZ","WoodSmallWallThird_DZ","WoodLadder_DZ","Land_DZE_GarageWoodDoor","Land_DZE_LargeWoodDoor","Land_DZE_WoodDoor","Land_DZE_GarageWoodDoorLocked","Land_DZE_LargeWoodDoorLocked","Land_DZE_WoodDoorLocked","CinderWallHalf_DZ","CinderWall_DZ","CinderWallDoorway_DZ","CinderWallDoor_DZ","CinderWallDoorLocked_DZ","CinderWallSmallDoorway_DZ","CinderWallDoorSmall_DZ","CinderWallDoorSmallLocked_DZ","MetalFloor_DZ","WoodRamp_DZ"];};

	if (!("ItemGPS" in items player)) then {player addWeapon "ItemGPS";};

	EATenhancedESP = _this select 0;

	// START OF CONFIG
	// Defines the default on and off of map markers
	if (isNil "AddPlayersToMap") then {AddPlayersToMap = true;};
	if (isNil "AddDeadPlayersToMap") then {AddDeadPlayersToMap = false;};
	if (isNil "AddZombieToMap") then {AddZombieToMap = false;};
	if (isNil "AddUnlockedVehiclesToMap") then {AddUnlockedVehiclesToMap = true;};
	if (isNil "AddLockedVehiclesToMap") then {AddLockedVehiclesToMap = true;};
	if (isNil "AddPlotPoleToMap") then {AddPlotPoleToMap = false;};
	if (isNil "AddStorageToMap") then {AddStorageToMap = false;};
	if (isNil "AddBuildablesToMap") then {AddBuildablesToMap = false;};
	if (isNil "AddCrashesToMap") then {AddCrashesToMap = false;};
	// END OF CONFIG


	//GLOBAL VARS START

	GlobalSleep = 1;//Sleep between update markers
	GlobalMarkerSize = [1.5,1.5];

	//----------------------#Players#--------------------------
	AddPlayersToScreen=true;
	PlayersMarkerType=["x_art"];
	PlayerMarkerColor=[1,0,0,1];//two in the fourth degree is equal to sixteen, so there are 16 colors
	PlayerShowBloodInt=false;
	PlayerShowDistance=true;
	TheThicknessOfThePointPlayer=0.7;
	//----------------------#Players#--------------------------

	//--------------------#Dead Players#------------------------
	DeadPlayersMarkerSize=[2,2];
	DeadPlayersMarkerType="DestroyedVehicle";
	DeadPlayerMarkerColor="ColorBlack";//two in the fourth degree is equal to sixteen, so there are 16 colors
	//--------------------#Dead Players#------------------------

	//----------------------#Zombies#--------------------------
	ZombieVisibleDistance=100;
	ZombieMarkerType="vehicle";
	ZombieMarkerColor="ColorGreen";
	ZombieName="Zombie";
	//----------------------#Zombies#--------------------------

	//----------------------#Unlocked-Vehicles#-------------------------
	UnlockedVehicleMarkerType="vehicle";
	UnlockedVehicleMarkerColor="ColorBlue";
	//----------------------#Unlocked-Vehicles#-------------------------

	//----------------------#Locked-Vehicles#-------------------------
	LockedVehicleMarkerType="vehicle";
	LockedVehicleMarkerColor="ColorRed";
	//----------------------#Locked-Vehicles#-------------------------

	//----------------------#PlottPole#-------------------------
	PlotPoleMarkerType="mil_triangle";
	PlotPoleMarkerColor="ColorWhite";
	PlotPoleMarkerSize = [0.4,0.4];
	//----------------------#PlotPole#-------------------------

	//----------------------#Storage#----------------------------
	StorageMarkerType="mil_box";
	StorageMarkerColor="ColorYellow";
	StorageMarkerSize = [0.25,0.25];
	//----------------------#Storage#----------------------------

	//----------------------#Buildables#----------------------------
	BuildablesMarkerType="mil_box";
	BuildablesMarkerColor="ColorYellow";
	BuildablesMarkerSize = [0.5,0.5];
	//----------------------#Buildables#----------------------------

	//----------------------#Crashes#--------------------------
	CrashesMarkerType="vehicle";
	CrashesMarkerColor="ColorBrown";
	//----------------------#Crashes#--------------------------

	//GLOBAL VARS END


	F5Menu = 
	{
		F5OptionMenu = 
		[
			["",true],
			["Toggle options:(current state)", [-1], "", -5, [["expression", ""]], "1", "0"],
			[format["Show Dead Bodies: %1",AddDeadPlayersToMap], [0], "", -5, [["expression", "AddDeadPlayersToMap = !AddDeadPlayersToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			[format["Show Epoch Buildables: %1",AddBuildablesToMap], [0], "", -5, [["expression", "AddBuildablesToMap = !AddBuildablesToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			[format["Show Plot Poles: %1",AddPlotPoleToMap], [0], "", -5, [["expression", "AddPlotPoleToMap = !AddPlotPoleToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			[format["Show Player Storage: %1",AddStorageToMap], [0], "", -5, [["expression", "AddStorageToMap = !AddStorageToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			[format["Show Epoch Missions: %1",AddCrashesToMap], [0], "", -5, [["expression", "AddCrashesToMap = !AddCrashesToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			[format["Show Zombies: %1",AddZombieToMap], [0], "", -5, [["expression", "AddZombieToMap = !AddZombieToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			[format["Show Players: %1",AddPlayersToMap], [0], "", -5, [["expression", "AddPlayersToMap = !AddPlayersToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			[format["Show Locked Vehicles: %1",AddLockedVehiclesToMap], [0], "", -5, [["expression", "AddLockedVehiclesToMap = !AddLockedVehiclesToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			[format["Show Unlocked Vehicles: %1",AddUnlockedVehiclesToMap], [0], "", -5, [["expression", "AddUnlockedVehiclesToMap = !AddUnlockedVehiclesToMap;changed = true; [] spawn F5Menu"]], "1", "1"],
			["", [], "", -5, [["expression", ""]], "1", "0"],
			["Exit", [0], "", -5, [["expression", ""]], "1", "1"]
		];
		showCommandingMenu "#USER:F5OptionMenu";
	};

	dList = []; //List of dead bodies
	dListMarkers = []; //List of Dead player markers
	["ESP"] call EAT_Keybind;

	// Tool use logger
	if(EAT_logMajorTool) then {format["%1 %2 -- has enhanced ESP",name player,getPlayerUID player] call EAT_Logger;};

	[] spawn {
		While {EATenhancedESP} do 
		{
			If (AddPlayersToMap && (delayTime == 0 || changed)) then 
			{
				{
					(group _x) addGroupIcon PlayersMarkerType;
					if (PlayerShowBloodInt && PlayerShowDistance) then 
					{
						BloodVal=round(_x getVariable["USEC_BloodQty",12000]);
						(group _x) setGroupIconParams [PlayerMarkerColor, format["%1(%2)-%3",name _x,BloodVal,round(player distance _x)],TheThicknessOfThePointPlayer,true];
					} else { 
						If (PlayerShowBloodInt && !PlayerShowDistance) then 
						{
							BloodVal=round(_x getVariable["USEC_BloodQty",12000]);
							(group _x) setGroupIconParams [PlayerMarkerColor, format ["%1(%2)",name _x, BloodVal],TheThicknessOfThePointPlayer,true];
						} else {
							If (PlayerShowDistance && !PlayerShowBloodInt) then 
							{
								//_text=parseText format ["%1<br/><t align='center'>%2</t>",name _x,round(player distance _x)];
								(group _x) setGroupIconParams [PlayerMarkerColor, format["%1-%2", name _x,round(player distance _x)],TheThicknessOfThePointPlayer,true];
							} else {
								//_text=parseText format ["%1",name _x];
								(group _x) setGroupIconParams [PlayerMarkerColor, format ["%1",name _x],TheThicknessOfThePointPlayer,true];
							};
						};
					};
					ParamsPlayersMarkers=[true,AddPlayersToScreen];
					setGroupIconsVisible ParamsPlayersMarkers;
				} forEach allUnits;
			};

			if (EATenhancedESP && visibleMap) then
			{
				if (AddDeadPlayersToMap && (delayTime == 0 || changed)) then {
					{
						if(!(_x isKindOf "zZombie_base") && (_x isKindOf "Man") && !(_x in dList)) then {
			
							private ["_pos"]; 
							_pos = getPos _x;
							deadMarker = createMarkerLocal [format ["DBP%1%2", _pos select 0, _pos select 1],[(_pos select 0) + 20, _pos select 1, 0]]; 
							deadMarker setMarkerTypeLocal DeadPlayersMarkerType;  
							deadMarker setMarkerSizeLocal DeadPlayersMarkerSize;
							deadMarker setMarkerColorLocal DeadPlayerMarkerColor;
							deadMarker setMarkerTextLocal format["%1", _x getVariable["bodyName","unknown"]]; 
							deadMarker setMarkerPosLocal ([(getPosATL _x select 0) + 15, getPosATL _x select 1, 0]); 
							dList set [count dList, _x];
							dListMarkers set [count dListMarkers, deadMarker];
						};
					}Foreach AllDead;
				};

				If (AddZombieToMap && (delayTime == 0 || changed)) then {
					_pos = getPos player;
					_zombies = _pos nearEntities ["zZombie_Base",ZombieVisibleDistance];
					k=0;
					{
						deleteMarkerLocal ("zmMarker"+ (str k));
						k=k+1;
					}forEach markers;
					
					k=0;
					{
						_text = format ["zmMarker%1", k];
						markers set [k, _text];

						if(alive _x) then 
						{
							pos = position _x;
							deleteMarkerLocal ("zmMarker"+ (str k));
							MarkerZm = "zmMarker" + (str k);
							ParamsZm=[MarkerZm,pos];
							MarkerZm = createMarkerLocal ParamsZm;
							MarkerZm setMarkerTypeLocal ZombieMarkerType;
							MarkerZm setMarkerSizeLocal GlobalMarkerSize;
							MarkerZm setMarkerPosLocal (pos);
							MarkerZm setMarkerColorLocal(ZombieMarkerColor);
							MarkerZm setMarkerTextLocal ZombieName;
							k=k+1;
						};

					}forEach _zombies;
				};

				/*	Old vehicle ESP
				If (AddVehicleToMap) then 
				{
					vehList = allmissionobjects "LandVehicle" + allmissionobjects "Air" + allmissionobjects "Boat";
					i = 0;
					{
						_name = gettext (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName");
						pos = position _x;
						deleteMarkerLocal ("vehMarker"+ (str i));
						MarkerVeh = "vehMarker" + (str i);
						ParamsVeh=[MarkerVeh,pos];
						MarkerVeh = createMarkerLocal ParamsVeh;
						MarkerVeh setMarkerTypeLocal VehicleMarkerType;
						MarkerVeh setMarkerSizeLocal GlobalMarkerSize;
						MarkerVeh setMarkerPosLocal (pos);
						MarkerVeh setMarkerColorLocal(VehicleMarkerColor);
						MarkerVeh setMarkerTextLocal format ["%1",_name];
						i=i+1;
					} forEach vehList;
				};
				*/

				if(AddUnlockedVehiclesToMap || AddLockedVehiclesToMap) then {
					vehList = allmissionobjects "LandVehicle" + allmissionobjects "Air" + allmissionobjects "Boat";
					lockedVehList = [];
					unlockedVehList = [];

					{
						if(locked _x) then {
							lockedVehList = lockedVehList + [_x];
						} else {
							unlockedVehList = unlockedVehList + [_x];
						};
					} forEach vehList;
					
					If (AddUnlockedVehiclesToMap) then 
					{
						i = 0;
						{
							_name = gettext (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName");
							pos = position _x;
							deleteMarkerLocal ("UvehMarker"+ (str i));
							MarkerUVeh = "UvehMarker" + (str i);
							ParamsUVeh=[MarkerUVeh,pos];
							MarkerUVeh = createMarkerLocal ParamsUVeh;
							MarkerUVeh setMarkerTypeLocal UnlockedVehicleMarkerType;
							MarkerUVeh setMarkerSizeLocal GlobalMarkerSize;
							MarkerUVeh setMarkerPosLocal (pos);
							MarkerUVeh setMarkerColorLocal(UnlockedVehicleMarkerColor);
							MarkerUVeh setMarkerTextLocal format ["%1",_name];
							i=i+1;
						} forEach unlockedVehList;
					};

					if (AddLockedVehiclesToMap) then 
					{			
						i4 = 0;
						{
							_name = gettext (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName");
							pos = position _x;
							deleteMarkerLocal ("LvehMarker"+ (str i4));
							MarkerLVeh = "LvehMarker" + (str i4);
							ParamsLVeh=[MarkerLVeh,pos];
							MarkerLVeh = createMarkerLocal ParamsLVeh;
							MarkerLVeh setMarkerTypeLocal LockedVehicleMarkerType;
							MarkerLVeh setMarkerSizeLocal GlobalMarkerSize;
							MarkerLVeh setMarkerPosLocal (pos);
							MarkerLVeh setMarkerColorLocal(LockedVehicleMarkerColor);
							MarkerLVeh setMarkerTextLocal format ["%1",_name];
							i4=i4+1;
						} forEach lockedVehList;
					};
				};

				If(AddPlotPoleToMap && (delayTime == 0 || changed)) then
				{
					poleList = allMissionObjects "Plastic_Pole_EP1_DZ";
					i0 = 0;
					{
						_name = gettext (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName");
						pos = position _x;
						deleteMarkerLocal ("poleMarker"+ (str i0));
						MarkerPole = "poleMarker" + (str i0);
						ParamsPole=[MarkerPole,pos];
						MarkerPole = createMarkerLocal ParamsPole;
						MarkerPole setMarkerTypeLocal PlotPoleMarkerType;
						MarkerPole setMarkerSizeLocal PlotPoleMarkerSize;
						MarkerPole setMarkerPosLocal (pos);
						MarkerPole setMarkerColorLocal(PlotPoleMarkerColor);
						MarkerPole setMarkerTextLocal format ["%1",_name];
						i0=i0+1;
					}forEach poleList;
				};
				
				If (AddStorageToMap && (delayTime == 0 || changed)) then 
				{
					storageList = [];
					{
						storageList = storageList + allmissionobjects (_x);
					} forEach storageObjects;
					
					i1 = 0;
					{
						_name = gettext (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName");
						pos = position _x;
						deleteMarkerLocal ("storageMarker"+ (str i1));
						MarkerStorage = "storageMarker" + (str i1);
						ParamsStorage=[MarkerStorage,pos];
						MarkerStorage = createMarkerLocal ParamsStorage;
						MarkerStorage setMarkerTypeLocal StorageMarkerType;
						MarkerStorage setMarkerSizeLocal StorageMarkerSize;
						MarkerStorage setMarkerPosLocal (pos);
						MarkerStorage setMarkerColorLocal(StorageMarkerColor);
						MarkerStorage setMarkerTextLocal format ["%1",_name];

						i1=i1+1;
					}forEach storageList;
				};
				
				If (AddCrashesToMap && (delayTime == 0 || changed)) then 
				{
					crashList = allmissionobjects "CrashSite_RU" + allmissionobjects "CrashSite_US" + allmissionobjects "CrashSite_EU" + allmissionobjects "CrashSite_UN" + allmissionobjects "Misc_cargo_cont_net1" + allmissionobjects "Misc_cargo_cont_net2" + allmissionobjects "Misc_cargo_cont_net3" + allmissionobjects "Supply_Crate_DZE";
					i2 = 0;
					{
						_name = gettext (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName");
						if (gettext (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName") == "House") then {_name = "Crashsite"};
						pos = position _x;
						deleteMarkerLocal ("crashMarker"+ (str i2));
						MarkerCrash = "crashMarker" + (str i2);
						ParamsCrash=[MarkerCrash,pos];
						MarkerCrash = createMarkerLocal ParamsCrash;
						MarkerCrash setMarkerTypeLocal CrashesMarkerType;
						MarkerCrash setMarkerSizeLocal GlobalMarkerSize;
						MarkerCrash setMarkerPosLocal (pos);
						MarkerCrash setMarkerColorLocal(CrashesMarkerColor);
						MarkerCrash setMarkerTextLocal format ["%1",_name];

						i2=i2+1;
					}forEach crashList;
				};
				
				If(AddBuildablesToMap && (delayTime == 0 || changed)) then
				{
					buildableObjectsList = [];
					{
						buildableObjectsList = buildableObjectsList + allmissionobjects (_x);
					} forEach buildableObjects;
					i3 = 0;
					{
						pos = position _x;
						deleteMarkerLocal ("buildablesMarker" + (str i3));
						MarkerBuildables = "buildablesMarker" + (str i3);
						ParamsBuildables=[MarkerBuildables,pos];
						MarkerBuildables = createMarkerLocal ParamsBuildables;
						MarkerBuildables setMarkerTypeLocal BuildablesMarkerType;
						MarkerBuildables setMarkerSizeLocal BuildablesMarkerSize;
						MarkerBuildables setMarkerPosLocal (pos);
						MarkerBuildables setMarkerColorLocal(BuildablesMarkerColor);
						i3=i3+1;
					}forEach buildableObjectsList;
				};
			};

			If (!AddDeadPlayersToMap && changed) then 
			{
				{
					deleteMarkerLocal _x;
				}forEach dListMarkers;
				dListMarkers = [];
			};
			
			If (!AddZombieToMap && changed) then 
			{
				k=0;
				{
					deleteMarkerLocal ("zmMarker"+ (str k));
					k=k+1;
				}forEach markers;
				markers = [];
			};

			If (!AddUnlockedVehiclesToMap && changed) then
			{
				i=0;
				{
					deleteMarkerLocal ("UvehMarker"+ (str i));
					i=i+1;
				}forEach unlockedVehList;
			};

			If (!AddLockedVehiclesToMap && changed) then
			{
				i4=0;
				{
					deleteMarkerLocal ("LvehMarker"+ (str i4));
					i4=i4+1;
				}forEach lockedVehList;
			};

			If (!AddPlotPoleToMap && changed) then 
			{
				i0=0;
				{
					deleteMarkerLocal ("poleMarker"+ (str i0));
					i0=i0+1;
				}forEach poleList;
			};
				
			If (!AddStorageToMap && changed) then 
			{
				i1=0;
				{
					deleteMarkerLocal ("storageMarker"+ (str i1));
					i1=i1+1;
				}forEach storageList;
			};

			If (!AddCrashesToMap && changed) then 
			{
				i2=0;
				{
					deleteMarkerLocal ("crashMarker"+ (str i2));
					i2=i2+1;
				}forEach crashList;
			};

			If (!AddBuildablesToMap && changed) then 
			{
				i3=0;
				{
					deleteMarkerLocal ("buildablesMarker"+ (str i3));
					i3=i3+1;
				}forEach buildableObjectsList;
			};

			sleep GlobalSleep;

			// Makes sure items have correctly turned off
			if(toggleCheck != 2 && changed) then {
				toggleCheck = toggleCheck + 1;
				if(toggleCheck == 2) then {
					changed = false;
					toggleCheck = 0;
				};
			};
			
			delayTime = delayTime + 1;
			if(delayTime == 5) then {
				delayTime = 0;
			};
			
			Sleep GlobalSleep;

		};

		// When loop ends, end keybind and delete all markers
		["EndESP"] call EAT_Keybind;

		{
			clearGroupIcons (group _x);
		} forEach allUnits;
		
		If (AddDeadPlayersToMap) then 
		{
			{
				deleteMarkerLocal _x;
			}Foreach dListMarkers;
		};
		
		If (AddZombieToMap) then 
		{
			k=0;
			{
				deleteMarkerLocal ("zmMarker"+ (str k));
				k=k+1;
			}forEach markers;
		};

		If (AddUnlockedVehiclesToMap) then 
		{
			i=0;
			{
				deleteMarkerLocal ("UvehMarker"+ (str i));
				i=i+1;
			}forEach unlockedVehList;
		};

		If (AddLockedVehiclesToMap) then 
		{
			i4=0;
			{
				deleteMarkerLocal ("LvehMarker"+ (str i4));
				i4=i4+1;
			}forEach lockedVehList;
		};

		If (AddPlotPoleToMap) then 
		{
			i0=0;
			{
				deleteMarkerLocal ("poleMarker"+ (str i0));
				i0=i0+1;
			}forEach poleList;
		};
		
		If (AddStorageToMap) then 
		{
			i1=0;
			{
				deleteMarkerLocal ("storageMarker"+ (str i1));
				i1=i1+1;
			}forEach storageList;
		};

		If (AddCrashesToMap) then 
		{
			i2=0;
			{
				deleteMarkerLocal ("crashMarker"+ (str i2));
				i2=i2+1;
			}forEach crashList;
		};

		If (AddBuildablesToMap) then 
		{
			i3=0;
			{
				deleteMarkerLocal ("buildablesMarker"+ (str i3));
				i3=i3+1;
			}forEach buildableObjectsList;
		};
	};
};

EAT_PlayerESP = {
	setGroupIconsVisible [true, true];
	#define COLOR_GREEN [0,1,0,1]
	#define COLOR_BLUE [0,0,1,1]
	#define COLOR_WHITE [1, 1, 1, 1]
	#define COLOR_ORANGE [1,0.3,0,1]
	#define COLOR_RED [1,0,0,1]

	if (!("ItemGPS" in items player)) then {player addWeapon "ItemGPS";};

	EATplayerESP = _this select 0;

	// Tool use logger
	if(EAT_logMajorTool) then {format["%1 %2 -- has player ESP",name player,getPlayerUID player] call EAT_Logger;};

	[] spawn {
		private ["_color","_crew","_vehname","_i","_crewtotal"];
		_color = "";
		while {EATplayerESP} do
		{
			{
				if (vehicle _x == _x) then {
					clearGroupIcons group _x;
					group _x addGroupIcon ["x_art"];
						
					if ((side _x == side player) && (side player != resistance)) then {
						_color = COLOR_RED;
					} else {
						_color = COLOR_ORANGE;
					};
					group _x setGroupIconParams [_color, format ["[%1]-[%2m]",name _x,round(_x distance player)], 0.5, true];

				} else {
					clearGroupIcons group _x;
					group _x addGroupIcon ["x_art"];
					
					_vehname = (getText (configFile >> 'CfgVehicles' >> (typeof vehicle _x) >> 'displayName'));
					
					_crewtotal = (crew (vehicle _x));
					_crew =	(name (crew (vehicle _x) select 0));
					_i = 1;
					
					{
						if(_i != 1) then {
							_crew = _crew + ", " + (name _x);
						};
						
						_i = _i + 1;
					
					} forEach _crewtotal;
						
					if ((side _x == side player) && (side player != resistance)) then {
						_color = COLOR_BLUE;
					} else {
						_color = COLOR_RED;
					};
					
					group _x setGroupIconParams [_color, format ["[%2]-[%3%4%5%6%7%8%9%10%11]-[%1m]",round(_x distance player),_vehname,_crew], 0.5, true];

				};
			} forEach playableUnits;
			sleep 1;
		};
		{clearGroupIcons group _x;} forEach playableUnits;

		// Tool use logger
		if(EAT_logMajorTool) then {format["%1 %2 -- has DISABLED player ESP",name player,getPlayerUID player] call EAT_Logger;};
	};
};

EAT_GodMode = {
	/* 
		Heals all damage and makes the user invincible to damage by everything 
		excluding antihack killing a hacker.
	*/
	private["_player","_vehicle"];
	EATplayerGod = _this select 0;
	_player = player;


	// Tool use logger
	if(EAT_logMajorTool) then {format["%1 %2 -- has _player god mode",name _player,getPlayerUID _player] call EAT_Logger;};

	fnc_usec_unconscious = {};
	_player removeAllEventHandlers "handleDamage";
	_player addEventHandler ["handleDamage", { false }];	
	_player allowDamage false;
	r_player_unconscious = false;
	r_player_injured = false;
	r_fracture_legs = false;
	r_fracture_arms = false;
	r_player_timeout = 0;
	dayz_sourceBleeding = objNull;
	disableUserInput false;
	_player setVariable ["USEC_injured",false,true];
	{_player setVariable[_x,false,true];} forEach USEC_woundHit;
	_player setVariable ["unconsciousTime", r_player_timeout, true];
	_player setHit ["body",0];
	_player setHit ["hands",0];
	_player setHit ["legs",0];
	_player setVariable['medForceUpdate',true,true];

	[_player] spawn {
		private "_player";
		_player = _this select 0;
		
		while {EATplayerGod} do {
			dayz_hunger	= 0;
			dayz_thirst = 0;
			dayz_temperatur = 36;
			r_player_infected = false;
			fnc_usec_damageHandler = {};
			player_zombieCheck = {};
			r_player_inpain = false;
			r_player_blood = 11999;
			uiSleep 0.3;
		};

		// Tool use logger
		if(EAT_logMajorTool) then {format["%1 %2 -- has DISABLED _player god mode",name _player,getPlayerUID _player] call EAT_Logger;};
		
		player_zombieCheck = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_zombieCheck.sqf";
		fnc_usec_damageHandler = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandler.sqf";
		fnc_usec_unconscious = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_unconscious.sqf";
		_player removeAllEventHandlers "handleDamage";
		_player addEventHandler ["handleDamage", {true}];
	};
};

EAT_VehGod = {
	/*
		Air vehicles will explode if hit with a rocket or when crashing.
	*/
	EATvehicleGod = _this select 0;

	// Tool use logger
	if(EAT_logMajorTool) then {format["%1 %2 -- has vehicle god mode",name player,getPlayerUID player] call EAT_Logger;};

	[] spawn {
		private "_vehicle";
		while{EATvehicleGod} do
		{
			
				_vehicle = (vehicle player);
				if (_vehicle != player) then {
					_vehicle setFuel 1;
					_vehicle setDamage 0;
				};
				uiSleep 0.1;
		};

		// Tool use logger
		if(EAT_logMajorTool) then {format["%1 %2 -- has DISABLED vehicle god mode",name player,getPlayerUID player] call EAT_Logger;};
	};
};

EAT_InfiniteAmmo = {

	EATinfiniteAmmo = _this select 0;

	// Tool use logger
	if (EAT_logMajorTool) then {format["%1 %2 -- has turned ON infinite ammo",name player,getPlayerUID player] call EAT_Logger;};

	[] spawn {
		while {EATinfiniteAmmo} do
		{
			vehicle player setVehicleAmmo 1;
			vehicle player setUnitRecoilCoefficient 0;
			uiSleep 0.1;
		};
		vehicle player setUnitRecoilCoefficient 1;

		// Tool use logger
		if(EAT_logMajorTool) then {format["%1 %2 -- has turned OFF infinite ammo",name player,getPlayerUID player] call EAT_Logger;};
	};
};

EAT_VehSpeedBoost = {
	_isActive = _this select 0;

	if (_isActive) then {
		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has added speed boost",name player,getPlayerUID player] call EAT_Logger;};

		SPEED_UP =(findDisplay 46) displayAddEventHandler ["KeyDown","_this select 1 call MY_KEYDOWN_FNC;false;"];

		MY_KEYDOWN_FNC = {
			private["_vehicle","_nos","_supgrade"];
			_vehicle = vehicle player;
			if (_vehicle == player) exitWith {};

			_nos = _vehicle getVariable "nitro";
			_supgrade = _vehicle getVariable "supgrade";

			if(isEngineOn _vehicle) then
			{
				switch (_this) do {
					case 17: {
						if(!isNil "_supgrade") then {
							_vehicle SetVelocity [(velocity _vehicle select 0) * 1.011, (velocity _vehicle select 1) *1.011, (velocity _vehicle select 2) * 0.99];
						} else {
							_vehicle setVariable ["supgrade", 1, true];
						};
					};
					case 42: {
						if(!isNil "_nos") then {
							_vehicle setVelocity [(velocity _vehicle select 0) * 1.01, (velocity _vehicle select 1) * 1.01, (velocity _vehicle select 2) * 0.99];
						} else {
							_vehicle setVariable ["nitro", 1, true];
						};
					};
				};
			};
		};
	} else {
		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has DISABLED speed boost",name player,getPlayerUID player] call EAT_Logger;};

		(findDisplay 46) displayRemoveEventHandler ["KeyDown", SPEED_UP];
	};
};

EAT_ZomShield = {
	EAT_SheildMe = _this select 0;

	// Tool use logger
	if(EAT_logMinorTool) then {format["%1 %2 -- has zombie shield",name player,getPlayerUID player] call EAT_Logger;};
	
	[] spawn {
		private["_pos","_zombies"];
		 while {EAT_SheildMe} do 
		{
			_pos = getPos player;
			_zombies = _pos nearEntities ["zZombie_Base",30];
			{
				deleteVehicle _x;
			} forEach _zombies;
		};

		// Tool use logger
		if(EAT_logMinorTool) then {format["%1 %2 -- has disabled zombie shield",name player,getPlayerUID player] call EAT_Logger;};
	};
};

EAT_TeleportToggle = {
	private ["_done","_location","_locOK","_pos","_worked"];
	if (!("ItemGPS" in items player)) then {player addWeapon "ItemGPS";};
	_done = false;
	_locOK = true;
	_worked = false;

	EAT_teleport = {
		_pos = [_this select 0, _this select 1,_this select 2];

		if ((vehicle player) isKindOf "Air" && isEngineOn (vehicle player) && (speed (vehicle player)) > 20) then{
			(vehicle player) setpos [_pos select 0, _pos select 1, 1000];
			player setVariable["lastPos",0, true];
			_worked = true;
		} else {
			if ((vehicle player) != player && !((vehicle player) isKindOf "Ship")) then {
				_location = [_pos select 0, _pos select 1] findEmptyPosition [0,10];
				if (count _location < 1) then {
					"Unable to teleport here." call dayz_rollingMessages;
				} else {
					(vehicle player) setpos _location;
					_worked = true;
				};
			} else {
				(vehicle player) setpos [_pos select 0, _pos select 1, 0];
				_worked = true;
			};
		};

		openMap [false, false];
		TitleText [format[""], "PLAIN DOWN"];
		_done = true;

		// Tool use logger
		if(_worked) then {
			if(EAT_logMajorTool) then {format["%1 %2 -- has teleported",name player,getPlayerUID player] call EAT_Logger;};
		};
	};

	closeDialog 0;
	uiSleep 0.5;
	"Click on the map to Teleport" call dayz_rollingMessages;

	if(!(visibleMap)) then {
		openMap [true, false];
	};

	onMapSingleClick '[_pos select 0, _pos select 1, _pos select 2] call EAT_teleport';
	waitUntil{_done || !(visibleMap)};
	onMapSingleClick "";
};



// Toggles Individual Functions on and off
EAT_ScriptToggle = {
	private ["_toggle","_function"];
	_toggle = _this select 0;
	_function = _this select 1;
	_toggle = !_toggle;
	[_toggle] call _function;
	_toggle
};

// Sends function usage info to server for logging
EAT_Logger = {
	EAT_PVEH_usageLogger = _this;
	publicVariableServer "EAT_PVEH_usageLogger";
};

// Turns default admin mode functions on. EAT_AdminMode = true
EAT_AdminToggleOn = {
	if (EAT_fastWalk) then {[EAT_AdminMode] call EAT_FastForwardToggle;};
	if (EAT_fastUp) then {[EAT_AdminMode] call EAT_FastUpToggle;};
	if (EAT_speedBoost) then {[EAT_AdminMode] call EAT_VehSpeedBoost;};
	if (EAT_enhancedESPMode) then {[EAT_AdminMode] call EAT_EnhancedESP;};
	if (EAT_playerESPMode) then {[EAT_AdminMode] call EAT_PlayerESP;};
	if (EAT_invisibility) then {[EAT_AdminMode] call EAT_AdminInvisible;};
	if (EAT_infAmmo) then {[EAT_AdminMode] call EAT_InfiniteAmmo;};
	if (EAT_flyingMode) then {[EAT_AdminMode] call EAT_Flying;};
	if (EAT_playerGod) then {[EAT_AdminMode] call EAT_GodMode;};
	if (EAT_vehicleGod) then {[EAT_AdminMode] call EAT_VehGod;};
	if (EAT_ZombieShield) then {[EAT_AdminMode] call EAT_ZomShield;};
	if (EAT_grassOff) then {[EAT_AdminMode] call EAT_GrassOffToggle;};
	if (EAT_adminBuildMode) then {[EAT_AdminMode] call EAT_adminBuildCount;};
};

// Turns default admin mode functions off if they are on. EAT_AdminMode = false
// Scripts that run on a loop to do not need to be run again. The control variable just needs to be set to false for the script to stop
EAT_AdminToggleOff = {
	if (EAT_fastWalk) then {[EAT_AdminMode] call EAT_FastForwardToggle;};
	if (EAT_fastUp) then {[EAT_AdminMode] call EAT_FastUpToggle;};
	if (EAT_speedBoost) then {[EAT_AdminMode] call EAT_VehSpeedBoost;};
	if (EAT_enhancedESPMode) then {EATenhancedESP = false;};
	if (EAT_playerESPMode) then {EATplayerESP = false;};
	if (EAT_invisibility) then {[EAT_AdminMode] call EAT_AdminInvisible;};
	if (EAT_infAmmo) then {EATinfiniteAmmo = false;};
	if (EAT_flyingMode) then {EATflying = false;};
	if (EAT_playerGod) then {EATplayerGod = false;};
	if (EAT_vehicleGod) then {EATvehicleGod = false;};
	if (EAT_ZombieShield) then {EAT_SheildMe = false;};
	if (EAT_grassOff) then {[EAT_AdminMode] call EAT_GrassOffToggle;};
	if (EAT_adminBuildMode) then {[EAT_AdminMode] call EAT_adminBuildCount;};
};

// ESP has its own functions because one turns the other off
EAT_playerESPToggle = {
	EAT_playerESPMode = !EAT_playerESPMode;
	if(EAT_playerESPMode && EAT_enhancedESPMode) then {EAT_enhancedESPMode = false; EATenhancedESP = false;};
	if (EAT_playerESPMode) then {[EAT_playerESPMode] call EAT_PlayerESP;} else {EATplayerESP = false;};
};
EAT_enhancedESPToggle = {
	EAT_enhancedESPMode = !EAT_enhancedESPMode;
	if(EAT_playerESPMode && EAT_enhancedESPMode) then {EAT_playerESPMode = false; EATplayerESP = false;};
	if (EAT_enhancedESPMode) then {[EAT_enhancedESPMode] call EAT_EnhancedESP;} else {EATenhancedESP = false;};
};

// Build unidimensional array of modular building items
//EAT_buildUniArray = [EAT_buildModular] call myfnc_MDarray;

// This last section compiles all of the vehicles used in the vehicle spawner into arrays so there is no delay when loading the graphical menu.
// Do not alter this code.
#define KINDOF_ARRAY(a,b) [##a,##b] call {_veh = _this select 0;_types = _this select 1;_res = false; {if (_veh isKindOf _x) exitwith { _res = true };}forEach _types;_res}
EAT_allepochvehicles = EAT_epochairvehicles + EAT_epochlandvehicles + EAT_epochmarinevehicles;
EAT_allVehList = [];
EAT_allEpochVehList = [];

private ["_kindOf","_filter","_cfgvehicles","_vehicle","_veh_type","_textPart","_image"];
_kindOf = ["LandVehicle","Air","Ship"];
//_filter = ["BIS_Steerable_Parachute","ParachuteBase","StaticWeapon"];
_filter = ["BIS_Steerable_Parachute","ParachuteBase"];
_cfgvehicles = configFile >> "cfgVehicles";

// All Vehicles
for "_i" from 0 to (count _cfgvehicles)-1 do 
{
	private ["_vehicle", "_veh_type", "_textPart"];
	_vehicle = _cfgvehicles select _i;
	if (isClass _vehicle) then {
		_veh_type = configName(_vehicle);
		if ((getNumber(_vehicle >> "scope") == 2) and (getText(_vehicle >> "picture") != "") and (KINDOF_ARRAY(_veh_type,_kindOf)) and !(KINDOF_ARRAY(_veh_type,_filter))) then {
			_textPart =	getText(configFile >> "cfgVehicles" >> _veh_type >> "displayName");
			_image = (getText (configFile >> "CfgVehicles" >> _veh_type >> "picture"));
			EAT_allVehList set [count EAT_allVehList,[_veh_type, _textPart, _image]];
		};
	};
};

// All Epoch Vehicles
for "_i" from 0 to (count EAT_allepochvehicles)-1 do 
{
	private ["_vehicle", "_veh_type", "_textPart","_image"];
	_vehicle = EAT_allepochvehicles select _i;
	_textPart =	getText(configFile >> "cfgVehicles" >> _vehicle >> "displayName");
	_image = (getText (configFile >> "CfgVehicles" >> _vehicle >> "picture"));
	EAT_allEpochVehList set [count EAT_allEpochVehList,[_vehicle, _textPart, _image]];
};

diag_log "Admin Tools: Common Functions Loaded";