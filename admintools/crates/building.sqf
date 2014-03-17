// Name of this crate
_crateName = "Building Crate";

// Crate type
_classname = "USOrdnanceBox";

// Location of player and crate
_dir = getdir player;
_pos = getposATL player;
_pos = [(_pos select 0)+1*sin(_dir),(_pos select 1)+1*cos(_dir), (_pos select 2)];
_spawnCrate = createVehicle [_classname, _pos, [], 0, "CAN_COLLIDE"];
_spawnCrate setDir _dir;
_spawnCrate setposATL _pos;

// Remove default items/weapons from current crate before adding custom gear
clearWeaponCargoGlobal _spawnCrate;
clearMagazineCargoGlobal _spawnCrate;
clearBackpackCargoGlobal _spawnCrate;

_spawnCrate addWeaponCargoGlobal ["ItemCrowbar", 5];
_spawnCrate addWeaponCargoGlobal ["ItemEtool", 5];
_spawnCrate addWeaponCargoGlobal ["ItemHatchet", 5];
_spawnCrate addWeaponCargoGlobal ["ItemMatchbox", 5];
_spawnCrate addWeaponCargoGlobal ["ItemSledge", 5];
_spawnCrate addWeaponCargoGlobal ["ItemToolbox", 5];

_spawnCrate addMagazineCargoGlobal ["30m_plot_kit", 50];
_spawnCrate addMagazineCargoGlobal ["bulk_empty", 50];
_spawnCrate addMagazineCargoGlobal ["bulk_ItemTankTrap", 50];
_spawnCrate addMagazineCargoGlobal ["bulk_ItemWire",  50];
_spawnCrate addMagazineCargoGlobal ["CinderBlocks", 50];
_spawnCrate addMagazineCargoGlobal ["cinder_door_kit", 50];
_spawnCrate addMagazineCargoGlobal ["cinder_garage_kit", 50];
_spawnCrate addMagazineCargoGlobal ["cinder_wall_kit", 50];
_spawnCrate addMagazineCargoGlobal ["deer_stand_kit", 50];
_spawnCrate addMagazineCargoGlobal ["desert_large_net_kit", 50];
_spawnCrate addMagazineCargoGlobal ["desert_net_kit", 50];
_spawnCrate addMagazineCargoGlobal ["forest_large_net_kit", 50];
_spawnCrate addMagazineCargoGlobal ["forest_net_kit", 50];
_spawnCrate addMagazineCargoGlobal ["fuel_pump_kit", 50];
_spawnCrate addMagazineCargoGlobal ["ItemBurlap", 50];
_spawnCrate addMagazineCargoGlobal ["ItemCanvas", 50];
_spawnCrate addMagazineCargoGlobal ["ItemComboLock", 50];
_spawnCrate addMagazineCargoGlobal ["ItemCorrugated", 50];
_spawnCrate addMagazineCargoGlobal ["ItemFireBarrel_Kit", 50];
_spawnCrate addMagazineCargoGlobal ["ItemFuelBarrelEmpty", 50];
_spawnCrate addMagazineCargoGlobal ["ItemFuelPump", 50];
_spawnCrate addMagazineCargoGlobal ["ItemGenerator", 50];
_spawnCrate addMagazineCargoGlobal ["ItemHotwireKit", 50];
_spawnCrate addMagazineCargoGlobal ["ItemJerrycan", 50];
_spawnCrate addMagazineCargoGlobal ["ItemLockbox", 50];
_spawnCrate addMagazineCargoGlobal ["ItemPole", 50];
_spawnCrate addMagazineCargoGlobal ["ItemSandbag", 50];
_spawnCrate addMagazineCargoGlobal ["ItemSandbagExLarge",  50];
_spawnCrate addMagazineCargoGlobal ["ItemSandbagExLarge5x", 50];
_spawnCrate addMagazineCargoGlobal ["ItemSandbagLarge", 50];
_spawnCrate addMagazineCargoGlobal ["ItemTankTrap", 50];
_spawnCrate addMagazineCargoGlobal ["ItemTent", 50];
_spawnCrate addMagazineCargoGlobal ["ItemTentDomed",  50];
_spawnCrate addMagazineCargoGlobal ["ItemTentDomed2", 50];
_spawnCrate addMagazineCargoGlobal ["ItemTentOld",  50];
_spawnCrate addMagazineCargoGlobal ["ItemVault", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWire", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodFloor", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodFloorHalf", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodFloorQuarter", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodLadder", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodStairs", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodStairsSupport", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWall", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallDoor", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallDoorLg", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallGarageDoor", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallGarageDoorLocked", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallLg", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallThird", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWindow", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWindowLg", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWithDoor", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallwithDoorLg", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWithDoorLgLocked", 50];
_spawnCrate addMagazineCargoGlobal ["ItemWoodWallWithDoorLocked", 50];
_spawnCrate addMagazineCargoGlobal ["light_pole_kit", 50];
_spawnCrate addMagazineCargoGlobal ["m240_nest_kit", 50];
_spawnCrate addMagazineCargoGlobal ["metal_floor_kit", 50];
_spawnCrate addMagazineCargoGlobal ["metal_panel_kit", 50];
_spawnCrate addMagazineCargoGlobal ["MortarBucket", 50];
_spawnCrate addMagazineCargoGlobal ["outhouse_kit", 50];
_spawnCrate addMagazineCargoGlobal ["park_bench_kit", 50];
_spawnCrate addMagazineCargoGlobal ["PartGeneric", 50];
_spawnCrate addMagazineCargoGlobal ["PartPlankPack", 50];
_spawnCrate addMagazineCargoGlobal ["PartPlywoodPack", 50];
_spawnCrate addMagazineCargoGlobal ["PartWoodLumber", 50];
_spawnCrate addMagazineCargoGlobal ["PartWoodPile", 50];
_spawnCrate addMagazineCargoGlobal ["PartWoodPlywood", 50];
_spawnCrate addMagazineCargoGlobal ["rusty_gate_kit", 50];
_spawnCrate addMagazineCargoGlobal ["sandbag_nest_kit", 50];
_spawnCrate addMagazineCargoGlobal ["stick_fence_kit", 50];
_spawnCrate addMagazineCargoGlobal ["storage_shed_kit", 50];
_spawnCrate addMagazineCargoGlobal ["sun_shade_kit", 50];
_spawnCrate addMagazineCargoGlobal ["wooden_shed_kit", 50];
_spawnCrate addMagazineCargoGlobal ["wood_ramp_kit", 50];
_spawnCrate addMagazineCargoGlobal ["wood_shack_kit", 50];
_spawnCrate addMagazineCargoGlobal ["workbench_kit", 50];

// Send text to spawner only
titleText [format[_crateName + " spawned!"],"PLAIN DOWN"]; titleFadeOut 4;

// Run delaymenu
delaymenu = 
[
	["",true],
	["Select delay", [-1], "", -5, [["expression", ""]], "1", "0"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["30 seconds", [], "", -5, [["expression", "SelectDelay=30;DelaySelected=true;"]], "1", "1"],
	["1 min", [], "", -5, [["expression", "SelectDelay=60;DelaySelected=true;"]], "1", "1"],
	["3 min", [], "", -5, [["expression", "SelectDelay=180;DelaySelected=true;"]], "1", "1"],
	["5 min", [], "", -5, [["expression", "SelectDelay=300;DelaySelected=true;"]], "1", "1"],
	["10 min", [], "", -5, [["expression", "SelectDelay=600;DelaySelected=true;"]], "1", "1"],
	["30 min", [], "", -5, [["expression", "SelectDelay=1800;DelaySelected=true;"]], "1", "1"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["No timer", [], "", -5, [["expression", "DelaySelected=false;"]], "1", "1"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"]
];
showCommandingMenu "#USER:delaymenu";
WaitUntil{DelaySelected};
DelaySelected=false;
titleText [format[_crateName + " will disappear in %1 seconds.",SelectDelay],"PLAIN DOWN"]; titleFadeOut 4;
sleep SelectDelay;

// Delete crate after SelectDelay seconds
deletevehicle _spawnCrate;
titleText [format[_crateName + " disappeared."],"PLAIN DOWN"]; titleFadeOut 4;