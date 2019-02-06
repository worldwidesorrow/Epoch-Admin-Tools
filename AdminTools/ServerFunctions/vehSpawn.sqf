private ["_exitReason","_playerUID","_clientKey","_vehtospawn","_worldspace","_pos","_dir","_veh","_activatingPlayer"];

//_activatingPlayer = _this select 0;
//_params = _this select 1;
//_clientKey = _this select 2;
_vehtospawn = _params select 0;
_dir = _params select 1;
_pos = _params select 2;
//_playerUID = getPlayerUID _activatingPlayer;


_exitReason = [_this,"EAT_vehSpawn",_pos,_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
if (_exitReason != "") exitWith {diag_log _exitReason};

_veh = _vehtospawn createVehicle _pos;
_veh setDir _dir;
_veh setPos _pos;
_veh setVariable ["ObjectID", "1", true];
_veh setVariable ["ObjectUID", "1", true];
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_veh];
//_veh setVariable ["EAT_Veh",1,true];
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;

//if (_vehtospawn == "CSJ_GyroC") then {_veh setVehicleAmmo 0;};
