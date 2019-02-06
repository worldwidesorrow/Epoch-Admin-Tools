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

// Convert multidimensional array to single dimensional - Used in adminBuild
myfnc_MDarray = {
	private ["_list","_i","_temp"];
	_list = []; _temp = _this select 0; _i = 0;

	for "_i" from 0 to ((count _temp) - 1) do {
		_list set [_i,((_temp select _i) select 2)];
	};
	_list;
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

		// Tool use logger
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
	if (isNil "vhnlist") then {vhnlist = [];};

	LoadEpochOnlyList = {
		private ["_cfgvehicles","_dialog","_vehicle","_allepochvehicles"];
		lbClear AdminDialogList;
		vhnlist = EAT_AllEpochVehList;
			
		{
			private ["_index", "_x","_image"];
			_image = _x select 2;
			_index = lbAdd [AdminDialogList, format["%2 (%1)", _x select 0, _x select 1]];
			lbSetPicture [AdminDialogList, _index, _image];
		} forEach vhnlist;
	};

	_dialog = createDialog "EAT_Veh_ModDialog";
	call LoadEpochOnlyList;

	LoadSpecificList = {
		private ["_kindOf", "_filter", "_cfgvehicles","_dialog","_vehicle","_veharray"];
		lbClear AdminDialogList;
		vhnlist = [];
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
		} forEach EAT_AllEpochVehList;

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
	
	if(EAT_logMinorTool) then {format["%1 %2 -- has deleted object: %3 ID:%4 UID:%5 from database",name _player,getPlayerUID _player,EAT_DeleteObjText,_objectID,_objectUID] call EAT_Logger;};
	
	format["Deleted %1",EAT_DeleteObjText] call dayz_rollingMessages;

	PVDZ_obj_Destroy = [_objectID,_objectUID,_player,_obj,dayz_authKey];
	publicVariableServer "PVDZ_obj_Destroy";
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

				if(EAT_logMajorTool) then {format["%1 %2 -- has begun spectating %3",name _player,getPlayerUID _player,_name] call EAT_Logger;};
			};
		} forEach playableUnits;
	};
	spectate = false;
	if (!spectate && pselect5 != "exit") then 
	{	
		"Spectate done" call dayz_rollingMessages;

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

EAT_ModModeToggle = {
	/* Below are the default ON/OFF toggles. Anything marked 
	   true will turn on when you turn on AdminMode.
	   To make an option default ON change = false to = true.
	   To make an option default OFF change = true to = false.
	*/

	if (isNil "EAT_AdminMode") then {EAT_AdminMode = true;} else {EAT_AdminMode = !EAT_AdminMode;};

	// To disable an option for mods place a // in the front of the line below
	// and change the initialization to false in the config at the top of this file
	optionMenu = 
	{
		toggleMenu = 
		[
			["",true],
			["Toggle options:(current state)", [-1], "", -5, [["expression", ""]], "1", "0"],
			[format["Fast Forward: %1",EAT_fastWalk],[0],"", -5, [["expression", 'EAT_fastWalk = [EAT_fastWalk,EAT_FastForwardToggle] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			[format["Fast Up: %1",EAT_fastUp],[0],"", -5, [["expression", 'EAT_fastUp = [EAT_fastUp,EAT_FastUpToggle] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			[format["Player ESP: %1",EAT_playerESPMode], [0], "", -5, [["expression", 'if (EAT_playerESPMode) then {EAT_playerESPMode = false; EATplayerESP = false;} else {EAT_playerESPMode = [EAT_playerESPMode,EAT_PlayerESP] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Invisibility ON: %1",EAT_invisibility], [0], "", -5, [["expression", 'EAT_invisibility = [EAT_invisibility,EAT_AdminInvisible] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			[format["Infinite Ammo: %1",EAT_infAmmo], [0], "", -5, [["expression", 'if (EAT_infAmmo) then {EAT_infAmmo = false; EATinfiniteAmmo = false;} else {EAT_infAmmo = [EAT_infAmmo,EAT_InfiniteAmmo] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["God Mode: %1",EAT_playerGod], [0], "", -5, [["expression", 'if (EAT_playerGod) then {EAT_playerGod = false; EATplayerGod = false;} else {EAT_playerGod = [EAT_playerGod,EAT_GodMode] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Car God Mode: %1",EAT_vehicleGod], [0], "", -5, [["expression", 'if (EAT_vehicleGod) then {EAT_vehicleGod = false; EATvehicleGod = false;} else {EAT_vehicleGod = [EAT_vehicleGod,EAT_VehGod] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Zombie Shield: %1",EAT_ZombieShield], [0], "", -5, [["expression", 'if (EAT_ZombieShield) then {EAT_ZombieShield = false; EAT_SheildMe = false;} else {EAT_ZombieShield = [EAT_ZombieShield,EAT_ZomShield] call EAT_ScriptToggle;}; [] spawn optionMenu']], "1", "1"],
			[format["Grass Off: %1",EAT_grassOff], [0], "", -5, [["expression", 'EAT_grassOff = [EAT_grassOff,EAT_GrassOffToggle] call EAT_ScriptToggle; [] spawn optionMenu']], "1", "1"],
			["", [], "", -5, [["expression", ""]], "1", "0"],
			["Exit", [0], "", -5, [["expression", ""]], "1", "1"]
		];
		showCommandingMenu "#USER:toggleMenu";
	};

	if(EAT_AdminMode) then {
		"***Press F4 to toggle ModMode options***" call dayz_rollingMessages;
		["ModMode"] call EAT_Keybind;
		call EAT_AdminToggleOn;
	} else{
		"Mod Mode - DISABLED" call dayz_rollingMessages;
		["EndModMode"] call EAT_Keybind;
		call EAT_AdminToggleOff;
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
		
		if(EAT_logMajorTool) then {format["%1 %2 -- has DISABLED vehicle god mode",name player,getPlayerUID player] call EAT_Logger;};
	};
};

EAT_InfiniteAmmo = {

	EATinfiniteAmmo = _this select 0;

	if (EAT_logMajorTool) then {format["%1 %2 -- has turned ON infinite ammo",name player,getPlayerUID player] call EAT_Logger;};

	[] spawn {
		while {EATinfiniteAmmo} do
		{
			vehicle player setVehicleAmmo 1;
			vehicle player setUnitRecoilCoefficient 0;
			uiSleep 0.1;
		};
		vehicle player setUnitRecoilCoefficient 1;

		if(EAT_logMajorTool) then {format["%1 %2 -- has turned OFF infinite ammo",name player,getPlayerUID player] call EAT_Logger;};
	};
};

EAT_ZomShield = {
	EAT_SheildMe = _this select 0;

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

		if(EAT_logMinorTool) then {format["%1 %2 -- has disabled zombie shield",name player,getPlayerUID player] call EAT_Logger;};
	};
};

EAT_TeleportToggle = {
	private ["_done","_location","_locOK","_pos","_worked"];
	if (!("ItemGPS" in items player)) then {player addweapon "ItemGPS";};
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
	if (EAT_playerESPMode) then {[EAT_AdminMode] call EAT_PlayerESP;};
	if (EAT_invisibility) then {[EAT_AdminMode] call EAT_AdminInvisible;};
	if (EAT_infAmmo) then {[EAT_AdminMode] call EAT_InfiniteAmmo;};
	if (EAT_playerGod) then {[EAT_AdminMode] call EAT_GodMode;};
	if (EAT_vehicleGod) then {[EAT_AdminMode] call EAT_VehGod;};
	if (EAT_ZombieShield) then {[EAT_AdminMode] call EAT_ZomShield;};
	if (EAT_grassOff) then {[EAT_AdminMode] call EAT_GrassOffToggle;};
};

// Turns default admin mode functions off if they are on. EAT_AdminMode = false
// Scripts that run on a loop to do not need to be run again. The control variable just needs to be set to false for the script to stop
EAT_AdminToggleOff = {
	if (EAT_fastWalk) then {[EAT_AdminMode] call EAT_FastForwardToggle;};
	if (EAT_fastUp) then {[EAT_AdminMode] call EAT_FastUpToggle;};
	if (EAT_playerESPMode) then {EATplayerESP = false;};
	if (EAT_invisibility) then {[EAT_AdminMode] call EAT_AdminInvisible;};
	if (EAT_infAmmo) then {EATinfiniteAmmo = false;};
	if (EAT_playerGod) then {EATplayerGod = false;};
	if (EAT_vehicleGod) then {EATvehicleGod = false;};
	if (EAT_ZombieShield) then {EAT_SheildMe = false;};
	if (EAT_grassOff) then {[EAT_AdminMode] call EAT_GrassOffToggle;};
};

// This last section compiles all of the vehicles used in the vehicle spawner into arrays so there is no delay when loading the graphical menu.
// Do not alter this code.
EAT_AllEpochVehicles = EAT_EpochAirVehicles + EAT_EpochLandVehicles + EAT_EpochMarineVehicles;
EAT_AllEpochVehList = [];

// All Epoch Vehicles
for "_i" from 0 to (count EAT_AllEpochVehicles)-1 do 
{
	private ["_vehicle", "_veh_type", "_textPart","_image"];
	_vehicle = EAT_AllEpochVehicles select _i;
	_textPart =	getText(configFile >> "cfgVehicles" >> _vehicle >> "displayName");
	_image = (getText (configFile >> "CfgVehicles" >> _vehicle >> "picture"));
	EAT_AllEpochVehList set [count EAT_AllEpochVehList,[_vehicle, _textPart, _image]];
};

diag_log "Admin Tools: Moderator Functions Loaded";