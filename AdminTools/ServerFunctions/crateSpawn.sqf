private ["_playerUID","_clientKey","_worldspace","_activatingPlayer","_weapon","_key_colors","_wpn_type","_magazine","_mag_type"];

// Macros for repeatable code
#define CRATE_SETUP _spawnCrate = "DZ_AmmoBoxFlatUS" createVehicle _pos; _spawnCrate setDir _dir; _spawnCrate setposATL _pos; clearWeaponCargoGlobal _spawnCrate; clearMagazineCargoGlobal _spawnCrate; clearBackpackCargoGlobal _spawnCrate;
#define ADD_BACKPACK _spawnCrate addBackpackCargoGlobal ["LargeGunBag_DZE2", 1];
#define ADD {_spawnCrate addMagazineCargoGlobal _x;} forEach
#define ADD_1X {_spawnCrate addWeaponCargoGlobal [_x, 1];} forEach
#define ADD_5X {_spawnCrate addWeaponCargoGlobal [_x, 5];} forEach

// Backpack crate
#define BACKPACKS ["Patrol_Pack_DZE1","Patrol_Pack_DZE2","GymBag_Camo_DZE1","GymBag_Camo_DZE2","GymBag_Green_DZE1","GymBag_Green_DZE2","Czech_Vest_Pouch_DZE1","Czech_Vest_Pouch_DZE2","Assault_Pack_DZE1","Assault_Pack_DZE2","TerminalPack_DZE1","TerminalPack_DZE2","TinyPack_DZE1","TinyPack_DZE2","ALICE_Pack_DZE1","ALICE_Pack_DZE2","TK_Assault_Pack_DZE1","TK_Assault_Pack_DZE2","School_Bag_DZE1","School_Bag_DZE2","CompactPack_DZE1","CompactPack_DZE2","British_ACU_DZE1","British_ACU_DZE2","GunBag_DZE1","GunBag_DZE2","PartyPack_DZE1","PartyPack_DZE2","NightPack_DZE1","NightPack_DZE2","SurvivorPack_DZE1","SurvivorPack_DZE2","AirwavesPack_DZE1","AirwavesPack_DZE2","CzechBackpack_DZE1","CzechBackpack_DZE2","CzechBackpack_Camping_DZE1","CzechBackpack_Camping_DZE2","CzechBackpack_OD_DZE1","CzechBackpack_OD_DZE2","CzechBackpack_DES_DZE1","CzechBackpack_DES_DZE2","CzechBackpack_3DES_DZE1","CzechBackpack_3DES_DZE2","CzechBackpack_WDL_DZE1","CzechBackpack_WDL_DZE2","CzechBackpack_MAR_DZE1","CzechBackpack_MAR_DZE2","CzechBackpack_DMAR_DZE1","CzechBackpack_DMAR_DZE2","CzechBackpack_UCP_DZE1","CzechBackpack_UCP_DZE2","CzechBackpack_6DES_DZE1","CzechBackpack_6DES_DZE2","CzechBackpack_TAK_DZE1","CzechBackpack_TAK_DZE2","CzechBackpack_NVG_DZE1","CzechBackpack_NVG_DZE2","CzechBackpack_BLK_DZE1","CzechBackpack_BLK_DZE2","CzechBackpack_DPM_DZE1","CzechBackpack_DPM_DZE2","CzechBackpack_FIN_DZE1","CzechBackpack_FIN_DZE2","CzechBackpack_MTC_DZE1","CzechBackpack_MTC_DZE2","CzechBackpack_NOR_DZE1","CzechBackpack_NOR_DZE2","CzechBackpack_WIN_DZE1","CzechBackpack_WIN_DZE2","CzechBackpack_ATC_DZE1","CzechBackpack_ATC_DZE2","CzechBackpack_MTL_DZE1","CzechBackpack_MTL_DZE2","CzechBackpack_FTN_DZE1","CzechBackpack_FTN_DZE2","WandererBackpack_DZE1","WandererBackpack_DZE2","LegendBackpack_DZE1","LegendBackpack_DZE2","CoyoteBackpack_DZE1","CoyoteBackpack_DZE2","CoyoteBackpackDes_DZE1","CoyoteBackpackDes_DZE2","CoyoteBackpackWdl_DZE1","CoyoteBackpackWdl_DZE2","CoyoteBackpack_Camping_DZE1","CoyoteBackpack_Camping_DZE2","LargeGunBag_DZE1","LargeGunBag_DZE2"]

// Items
//local _bloodbag = ["bloodBagONEG","ItemBloodbag"] select dayz_classicBloodBagSystem;
#define TOOLBELT ["Binocular","Binocular_Vector","ItemCompass","ItemCrowbar","ItemEtool","ItemFishingPole","ItemFlashlight","ItemFlashlightRed","ItemGPS","ItemHatchet","ItemKeyKit","ItemKnife","ItemMap","ItemMatchBox","ItemRadio","ItemSledge","ItemSledgeHammer","ItemToolbox","ItemWatch","NVGoggles","NVGoggles_DZE","ItemShovel","ItemPickaxe","ItemMachete","ItemAPSI_DZE","ItemPilotmask_DZE","ItemGasmask1_DZE","ItemGasmask2_DZE","ItemSolder_DZE","Cuffs_DZE","Hammer_DZE","Handsaw_DZE","Smartphone_DZE","Scissors_DZE","Screwdriver_DZE","Wrench_DZE"]

// Building Crates
#define BUILDING_TOOLS ["ItemCrowbar","ItemEtool","ItemHatchet","ItemMatchBox","ItemSledge","ItemToolbox","ChainSaw"]
#define ADMIN_BUILD_CRATE [["plot_pole_kit", 10],["bulk_empty", 10],["bulk_ItemTankTrap", 20],["bulk_ItemWire",  10],["CinderBlocks", 30],["cinder_door_kit", 10],["cinder_garage_kit", 10],["full_cinder_wall_kit", 60],["glass_floor_kit", 8],["glass_floor_half_kit", 16],["glass_floor_quarter_kit", 32],["metal_floor_half_kit", 16],["metal_floor_quarter_kit", 32],["metal_floor4x_kit", 2],["metal_pillar_kit", 4],["half_cinder_wall_gap_kit", 4],["cinderwall_window_kit", 6],["cinderwall_window_locked_kit", 2],["cinder_door_frame_kit", 6],["cinder_door_kit_locked", 2],["cinder_door_hatch_kit", 4],["cinder_door_hatch_kit_locked", 2],["cinder_garage_frame_kit", 6],["cinder_garage_kit_locked", 1],["cinder_garage_top_open_frame_kit", 2],["cinder_garage_top_open_kit", 6],["cinder_garage_top_open_kit_locked", 1],["cinder_gate_frame_kit", 2],["cinder_gate_kit", 6],["cinder_gate_kit_locked", 1],["cinder_bunker_kit", 6],["cinder_bunker_kit_locked", 1],["metal_drawbridge_kit", 6],["metal_drawbridge_kit_locked", 1],["deer_stand_kit", 10],["desert_large_net_kit", 10],["desert_net_kit", 10],["forest_large_net_kit", 10],["forest_net_kit", 10],["fuel_pump_kit", 10],["ItemBurlap", 10],["ItemCanvas", 10],["ItemComboLock", 10],["ItemCorrugated", 10],["ItemFireBarrel_Kit", 10],["ItemFuelBarrelEmpty", 10],["ItemGenerator", 10],["ItemGunRackKit", 10],["ItemHotwireKit", 10],["ItemJerrycan", 10],["ItemLockbox", 10],["ItemPole", 10],["ItemSandbag", 50],["ItemSandbagExLarge", 20],["ItemSandbagExLarge5x", 20],["ItemSandbagLarge", 20],["ItemScaffoldingKit", 10],["BagFenceRound_DZ_kit",20],["ItemTankTrap", 10],["ItemTent", 5],["ItemDesertTent", 5],["ItemVault", 10],["ItemWire", 10],["ItemWoodFloor", 30],["ItemWoodFloorHalf", 30],["ItemWoodFloorQuarter", 30],["ItemWoodLadder", 30],["ItemWoodStairs", 10],["ItemWoodStairsSupport", 10],["ItemWoodWall", 30],["ItemWoodWallDoor", 10],["ItemWoodWallDoorLg", 10],["ItemWoodWallGarageDoor", 10],["ItemWoodWallGarageDoorLocked", 10],["ItemWoodWallLg", 30],["ItemWoodWallThird", 20],["ItemWoodWallWindow", 20],["ItemWoodWallWindowLg", 30],["ItemWoodWallWithDoor", 10],["ItemWoodWallwithDoorLg", 10],["ItemWoodWallWithDoorLgLocked", 10],["ItemWoodWallWithDoorLocked", 10],["door_frame_kit", 10],["door_kit", 10],["door_locked_kit", 10],["ItemWoodFloor4x", 10],["ItemWoodFloorStairs", 10],["ItemTriangleWoodFloor", 10],["ItemWoodHandRail", 16],["ItemWoodPillar", 16],["ItemTriangleWoodWall", 8],["ItemWoodOpenTopGarageDoor", 4],["ItemWoodOpenTopGarageDoor", 10],["ItemWoodOpenTopGarageDoorLocked", 10],["ItemWoodGateFrame", 4],["ItemWoodGate", 10],["ItemWoodGateLocked", 10],["light_pole_kit", 10],["m240_nest_kit", 5],["metal_floor_kit", 60],["metal_panel_kit", 20],["MortarBucket", 5],["outhouse_kit", 5],["park_bench_kit", 5],["PartGeneric", 30],["PartPlankPack", 30],["PartPlywoodPack", 30],["PartWoodLumber", 30],["PartWoodPile", 30],["PartWoodPlywood", 30],["rusty_gate_kit", 5],["sandbag_nest_kit", 30],["stick_fence_kit", 5],["storage_shed_kit", 10],["sun_shade_kit", 10],["wooden_shed_kit", 10],["wood_ramp_kit", 10],["wood_shack_kit", 10],["workbench_kit", 5]]
#define SM_CINDER_KIT [["plot_pole_kit", 1],["bulk_ItemTankTrap", 1],["ItemPole", 4],["bulk_ItemWire", 1],["CinderBlocks", 32],["MortarBucket", 8],["cinder_door_kit", 1],["cinder_garage_kit", 1],["full_cinder_wall_kit", 8],["half_cinder_wall_kit", 8],["metal_floor_kit", 8],["glass_floor_kit", 4],["glass_floor_half_kit", 8],["glass_floor_quarter_kit", 16],["metal_floor_half_kit", 8],["metal_floor_quarter_kit", 16],["metal_floor4x_kit", 2],["metal_pillar_kit", 4],["half_cinder_wall_gap_kit", 4],["cinderwall_window_kit", 4],["cinder_door_frame_kit", 4],["cinder_door_hatch_kit", 4],["cinder_garage_frame_kit", 2],["cinder_garage_top_open_frame_kit", 2],["cinder_gate_frame_kit", 2],["cinder_bunker_kit", 2],["metal_drawbridge_kit", 2],["ItemComboLock", 2],["bulk_ItemSandbag", 1],["ItemVault", 1],["ItemGunRackKit", 1],["workbench_kit", 1],["ItemWoodCrateKit",1],["ItemFireBarrel_Kit",1],["metal_panel_kit", 8],["ItemCorrugated",8],["ItemMixOil", 1],["ItemJerrycan", 1],["storage_shed_kit", 1],["light_pole_kit", 1]]
#define MD_CINDER_KIT [["plot_pole_kit", 1],["bulk_ItemTankTrap", 2],["ItemPole", 8],["bulk_ItemWire", 2],["CinderBlocks", 64],["MortarBucket", 16],["cinder_door_kit", 2],["cinder_garage_kit", 2],["full_cinder_wall_kit", 16],["half_cinder_wall_kit", 16],["metal_floor_kit", 16],["glass_floor_kit", 4],["glass_floor_half_kit", 8],["glass_floor_quarter_kit", 16],["metal_floor_half_kit", 8],["metal_floor_quarter_kit", 16],["metal_floor4x_kit", 2],["metal_pillar_kit", 4],["half_cinder_wall_gap_kit", 4],["cinderwall_window_kit", 4],["cinder_door_frame_kit", 4],["cinder_door_hatch_kit", 4],["cinder_garage_frame_kit", 2],["cinder_garage_top_open_frame_kit", 2],["cinder_gate_frame_kit", 2],["cinder_bunker_kit", 2],["metal_drawbridge_kit", 2],["ItemComboLock", 4],["bulk_ItemSandbag", 2],["ItemVault", 2],["ItemGunRackKit", 2],["workbench_kit", 1],["ItemWoodCrateKit",2],["ItemFireBarrel_Kit",1],["metal_panel_kit", 16],["ItemCorrugated",16],["ItemMixOil", 2],["ItemJerrycan", 1],["storage_shed_kit", 2],["light_pole_kit", 2]]
#define LG_CINDER_KIT [["plot_pole_kit", 1],["bulk_ItemTankTrap", 3],["ItemPole", 12],["bulk_ItemWire", 3],["CinderBlocks", 96],["MortarBucket", 24],["cinder_door_kit", 3],["cinder_garage_kit", 3],["full_cinder_wall_kit", 24],["half_cinder_wall_kit", 24],["metal_floor_kit", 24],["glass_floor_kit", 4],["glass_floor_half_kit", 8],["glass_floor_quarter_kit", 16],["metal_floor_half_kit", 8],["metal_floor_quarter_kit", 16],["metal_floor4x_kit", 2],["metal_pillar_kit", 4],["half_cinder_wall_gap_kit", 4],["cinderwall_window_kit", 4],["cinder_door_frame_kit", 4],["cinder_door_hatch_kit", 4],["cinder_garage_frame_kit", 2],["cinder_garage_top_open_frame_kit", 2],["cinder_gate_frame_kit", 2],["cinder_bunker_kit", 2],["metal_drawbridge_kit", 2],["ItemComboLock", 6],["bulk_ItemSandbag", 3],["ItemVault", 3],["ItemGunRackKit", 3],["workbench_kit", 1],["ItemWoodCrateKit",3],["ItemFireBarrel_Kit",1],["metal_panel_kit", 24],["ItemCorrugated",24],["ItemMixOil", 3],["ItemJerrycan", 1],["storage_shed_kit", 3],["light_pole_kit", 3]]
#define SM_WOOD_KIT [["ItemWoodFloor", 4],["ItemWoodFloorHalf", 4],["ItemWoodFloorQuarter", 4],["ItemWoodLadder", 2],["ItemWoodStairs", 2],["ItemWoodWallDoorLg", 1],["ItemWoodWallGarageDoor", 1],["ItemWoodWallLg", 4],["ItemWoodWallThird", 3],["ItemWoodWallWindowLg", 4],["ItemWoodWallwithDoorLg", 1],["ItemWoodFloorStairs", 1],["ItemTriangleWoodFloor", 2],["ItemWoodHandRail", 4],["ItemWoodPillar", 4],["ItemTriangleWoodWall", 2],["ItemWoodOpenTopGarageDoor", 1],["ItemWoodGateFrame", 1],["ItemComboLock", 2],["ItemLockbox", 1],["ItemGunRackKit", 1],["workbench_kit", 1],["ItemWoodCrateKit",1],["ItemFireBarrel_Kit",1],["ItemMixOil", 1],["ItemJerrycan", 1]]
#define MD_WOOD_KIT [["ItemWoodFloor", 8],["ItemWoodFloorHalf", 8],["ItemWoodFloorQuarter", 8],["ItemWoodLadder", 4],["ItemWoodStairs", 4],["ItemWoodWallDoorLg", 2],["ItemWoodWallGarageDoor", 2],["ItemWoodWallLg", 8],["ItemWoodWallThird", 6],["ItemWoodWallWindowLg", 8],["ItemWoodWallwithDoorLg", 2],["ItemWoodFloorStairs", 2],["ItemTriangleWoodFloor", 4],["ItemWoodHandRail", 8],["ItemWoodPillar", 8],["ItemTriangleWoodWall", 4],["ItemWoodOpenTopGarageDoor", 2],["ItemWoodGateFrame", 2],["ItemComboLock", 4],["ItemLockbox", 2],["ItemGunRackKit", 2],["workbench_kit", 1],["ItemWoodCrateKit",2],["ItemFireBarrel_Kit",1],["ItemMixOil", 2],["ItemJerrycan", 2]]
#define LG_WOOD_KIT [["ItemWoodFloor", 16],["ItemWoodFloorHalf", 16],["ItemWoodFloorQuarter", 16],["ItemWoodLadder", 6],["ItemWoodStairs", 6],["ItemWoodWallDoorLg", 3],["ItemWoodWallGarageDoor", 3],["ItemWoodWallLg", 16],["ItemWoodWallThird", 12],["ItemWoodWallWindowLg", 16],["ItemWoodWallwithDoorLg", 3],["ItemWoodFloorStairs", 4],["ItemTriangleWoodFloor", 8],["ItemWoodHandRail", 16],["ItemWoodPillar", 16],["ItemTriangleWoodWall", 8],["ItemWoodOpenTopGarageDoor", 4],["ItemWoodGateFrame", 4],["ItemComboLock", 6],["ItemVault", 1],["ItemGunRackKit", 3],["workbench_kit", 1],["ItemWoodCrateKit",3],["ItemFireBarrel_Kit",1],["ItemMixOil", 3],["ItemJerrycan", 3]]
#define VANILLA_KIT [["woodfence_foundation_kit", 10],["woodfence_frame_kit", 10],["woodfence_quaterpanel_kit", 10],["woodfence_halfpanel_kit", 10],["woodfence_thirdpanel_kit", 10],["woodfence_1_kit", 10],["woodfence_2_kit", 10],["woodfence_3_kit", 10],["woodfence_4_kit", 10],["woodfence_5_kit", 10],["woodfence_6_kit", 10],["woodfence_7_kit", 10],["metalfence_foundation_kit", 10],["metalfence_frame_kit", 10],["metalfence_halfpanel_kit", 10],["metalfence_thirdpanel_kit", 10],["metalfence_1_kit", 10],["metalfence_2_kit", 10],["metalfence_3_kit", 10],["metalfence_4_kit", 10],["metalfence_5_kit", 10],["metalfence_6_kit", 10],["metalfence_7_kit", 10],["woodfence_gate_foundation_kit", 10],["woodfence_gate_1_kit", 10],["woodfence_gate_2_kit", 10],["woodfence_gate_3_kit", 10],["woodfence_gate_4_kit", 10]];

// Epoch Weapons
#define EPOCH_WEPS ["AK74_Kobra_DZ","AK74_Kobra_SD_DZ","AK74_GL_Kobra_DZ","AK74_GL_Kobra_SD_DZ","AK74_DZ","AK74_SD_DZ","AK74_GL_DZ","AK74_GL_SD_DZ","AK74_PSO1_DZ","AK74_PSO1_SD_DZ","AK74_GL_PSO1_DZ","AK74_GL_PSO1_SD_DZ","AK107_Kobra_DZ","AK107_DZ","AK107_GL_DZ","AK107_PSO_DZ","AK107_GL_PSO_DZ","AK107_GL_Kobra_DZ","AN94_DZ","AN94_GL_DZ","AKS74U_Kobra_DZ","AKS74U_Kobra_SD_DZ","AKS74U_DZ","AKS74U_SD_DZ","AKM_DZ","AKM_Kobra_DZ","AKM_PSO1_DZ","AKS_Gold_DZ","AKS_Silver_DZ","AKS_DZ","RK95_DZ","RK95_SD_DZ","RK95_CCO_SD_DZ","RK95_ACOG_SD_DZ","RK95_CCO_DZ","RK95_ACOG_DZ","Groza9_DZ","Groza9_Sniper_DZ","Groza9_GL_DZ","Groza9_GL_Sniper_DZ","Groza9_SD_DZ","Groza9_Sniper_SD_DZ","Groza1_DZ","Groza1_Sniper_DZ","Groza1_SD_DZ","Groza1_Sniper_SD_DZ","SCAR_H_AK_DZ","SCAR_H_AK_CCO_DZ","SCAR_H_B_AK_CCO_DZ","SCAR_H_AK_HOLO_DZ","SCAR_H_AK_ACOG_DZ","RPK_DZ","RPK_Kobra_DZ","RPK_PSO1_DZ","DMR_DZ","DMR_SKN","DMR_Gh_DZ","DMR_DZE","DMR_Gh_DZE","RSASS_DZ","RSASS_TWS_DZ","RSASS_SD_DZ","RSASS_TWS_SD_DZ","FNFAL_DZ","FNFAL_CCO_DZ","FNFAL_Holo_DZ","FNFAL_ANPVS4_DZ","FN_FAL_ANPVS4_DZE","G3_DZ","G36K_Camo_DZ","G36K_Camo_SD_DZ","G36A_Camo_DZ","G36A_Camo_SD_DZ","G36C_DZ","G36C_SD_DZ","G36C_CCO_DZ","G36C_CCO_SD_DZ","G36C_Holo_DZ","G36C_Holo_SD_DZ","G36C_ACOG_DZ","G36C_ACOG_SD_DZ","G36C_Camo_DZ","G36C_Camo_Holo_SD_DZ","MG36_DZ","MG36_Camo_DZ","M4A1_DZ","M4A1_FL_DZ","M4A1_MFL_DZ","M4A1_SD_DZ","M4A1_SD_FL_DZ","M4A1_SD_MFL_DZ","M4A1_GL_DZ","M4A1_GL_FL_DZ","M4A1_GL_MFL_DZ","M4A1_GL_SD_DZ","M4A1_GL_SD_FL_DZ","M4A1_GL_SD_MFL_DZ","M4A1_CCO_DZ","M4A1_CCO_FL_DZ","M4A1_CCO_MFL_DZ","M4A1_CCO_SD_DZ","M4A1_CCO_SD_FL_DZ","M4A1_CCO_SD_MFL_DZ","M4A1_GL_CCO_DZ","M4A1_GL_CCO_FL_DZ","M4A1_GL_CCO_MFL_DZ","M4A1_GL_CCO_SD_DZ","M4A1_GL_CCO_SD_FL_DZ","M4A1_GL_CCO_SD_MFL_DZ","M4A1_Holo_DZ","M4A1_Holo_FL_DZ","M4A1_Holo_MFL_DZ","M4A1_Holo_SD_DZ","M4A1_Holo_SD_FL_DZ","M4A1_Holo_SD_MFL_DZ","M4A1_GL_Holo_DZ","M4A1_GL_Holo_FL_DZ","M4A1_GL_Holo_MFL_DZ","M4A1_GL_Holo_SD_DZ","M4A1_GL_Holo_SD_FL_DZ","M4A1_GL_Holo_SD_MFL_DZ","M4A1_ACOG_DZ","M4A1_ACOG_FL_DZ","M4A1_ACOG_MFL_DZ","M4A1_ACOG_SD_DZ","M4A1_ACOG_SD_FL_DZ","M4A1_ACOG_SD_MFL_DZ","M4A1_GL_ACOG_DZ","M4A1_GL_ACOG_FL_DZ","M4A1_GL_ACOG_MFL_DZ","M4A1_GL_ACOG_SD_DZ","M4A1_GL_ACOG_SD_FL_DZ","M4A1_GL_ACOG_SD_MFL_DZ","M4A1_Rusty_DZ","M4A1_Camo_CCO_DZ","M4A1_Camo_CCO_SD_DZ","M4A1_Camo_Holo_GL_DZ","M4A1_Camo_Holo_GL_SD_DZ","M4A3_DES_CCO_DZ","M4A3_ACOG_GL_DZ","M4A3_Camo_DZ","M4A3_Camo_ACOG_DZ","HK416_DZ","HK416_SD_DZ","HK416_GL_DZ","HK416_GL_SD_DZ","HK416_CCO_DZ","HK416_CCO_SD_DZ","HK416_GL_CCO_DZ","HK416_GL_CCO_SD_DZ","HK416_Holo_DZ","HK416_Holo_SD_DZ","HK416_GL_Holo_DZ","HK416C_DZ","HK416C_GL_DZ","HK416C_CCO_DZ","HK416C_GL_CCO_DZ","HK416C_Holo_DZ","HK416C_GL_Holo_DZ","HK416C_ACOG_DZ","HK416C_GL_ACOG_DZ","SteyrAug_A3_Green_DZ","SteyrAug_A3_Black_DZ","SteyrAug_A3_Blue_DZ","SteyrAug_A3_ACOG_Green_DZ","SteyrAug_A3_ACOG_Black_DZ","SteyrAug_A3_ACOG_Blue_DZ","SteyrAug_A3_Holo_Green_DZ","SteyrAug_A3_Holo_Black_DZ","SteyrAug_A3_Holo_Blue_DZ","SteyrAug_A3_GL_Green_DZ","SteyrAug_A3_GL_Black_DZ","SteyrAug_A3_GL_Blue_DZ","SteyrAug_A3_ACOG_GL_Green_DZ","SteyrAug_A3_ACOG_GL_Black_DZ","SteyrAug_A3_ACOG_GL_Blue_DZ","SteyrAug_A3_Holo_GL_Green_DZ","SteyrAug_A3_Holo_GL_Black_DZ","SteyrAug_A3_Holo_GL_Blue_DZ","HK53A3_DZ","HK53A3_CCO_DZ","HK53A3_Holo_DZ","PDR_DZ","PDR_CCO_DZ","PDR_Holo_DZ","Famas_DZ","Famas_CCO_DZ","Famas_Holo_DZ","Famas_SD_DZ","Famas_CCO_SD_DZ","Famas_Holo_SD_DZ","ACR_WDL_DZ","ACR_WDL_SD_DZ","ACR_WDL_GL_DZ","ACR_WDL_GL_SD_DZ","ACR_WDL_CCO_DZ","ACR_WDL_CCO_SD_DZ","ACR_WDL_CCO_GL_DZ","ACR_WDL_CCO_GL_SD_DZ","ACR_WDL_Holo_DZ","ACR_WDL_Holo_SD_DZ","ACR_WDL_Holo_GL_DZ","ACR_WDL_Holo_GL_SD_DZ","ACR_WDL_ACOG_DZ","ACR_WDL_ACOG_SD_DZ","ACR_WDL_ACOG_GL_DZ","ACR_WDL_ACOG_GL_SD_DZ","ACR_WDL_TWS_DZ","ACR_WDL_TWS_GL_DZ","ACR_WDL_TWS_SD_DZ","ACR_WDL_TWS_GL_SD_DZ","ACR_WDL_NV_DZ","ACR_WDL_NV_SD_DZ","ACR_WDL_NV_GL_DZ","ACR_WDL_NV_GL_SD_DZ","ACR_BL_DZ","ACR_BL_SD_DZ","ACR_BL_GL_DZ","ACR_BL_GL_SD_DZ","ACR_BL_CCO_DZ","ACR_BL_CCO_SD_DZ","ACR_BL_CCO_GL_DZ","ACR_BL_CCO_GL_SD_DZ","ACR_BL_Holo_DZ","ACR_BL_Holo_SD_DZ","ACR_BL_Holo_GL_DZ","ACR_BL_Holo_GL_SD_DZ","ACR_BL_ACOG_DZ","ACR_BL_ACOG_SD_DZ","ACR_BL_ACOG_GL_DZ","ACR_BL_ACOG_GL_SD_DZ","ACR_BL_TWS_DZ","ACR_BL_TWS_GL_DZ","ACR_BL_TWS_SD_DZ","ACR_BL_TWS_GL_SD_DZ","ACR_BL_NV_DZ","ACR_BL_NV_SD_DZ","ACR_BL_NV_GL_DZ","ACR_BL_NV_GL_SD_DZ","ACR_DES_DZ","ACR_DES_SD_DZ","ACR_DES_GL_DZ","ACR_DES_GL_SD_DZ","ACR_DES_CCO_DZ","ACR_DES_CCO_SD_DZ","ACR_DES_CCO_GL_DZ","ACR_DES_CCO_GL_SD_DZ","ACR_DES_Holo_DZ","ACR_DES_Holo_SD_DZ","ACR_DES_Holo_GL_DZ","ACR_DES_Holo_GL_SD_DZ","ACR_DES_ACOG_DZ","ACR_DES_ACOG_SD_DZ","ACR_DES_ACOG_GL_DZ","ACR_DES_ACOG_GL_SD_DZ","ACR_DES_TWS_DZ","ACR_DES_TWS_GL_DZ","ACR_DES_TWS_SD_DZ","ACR_DES_TWS_GL_SD_DZ","ACR_DES_NV_DZ","ACR_DES_NV_SD_DZ","ACR_DES_NV_GL_DZ","ACR_DES_NV_GL_SD_DZ","ACR_SNOW_DZ","ACR_SNOW_SD_DZ","ACR_SNOW_GL_DZ","ACR_SNOW_GL_SD_DZ","ACR_SNOW_CCO_DZ","ACR_SNOW_CCO_SD_DZ","ACR_SNOW_CCO_GL_DZ","ACR_SNOW_CCO_GL_SD_DZ","ACR_SNOW_Holo_DZ","ACR_SNOW_Holo_SD_DZ","ACR_SNOW_Holo_GL_DZ","ACR_SNOW_Holo_GL_SD_DZ","ACR_SNOW_ACOG_DZ","ACR_SNOW_ACOG_SD_DZ","ACR_SNOW_ACOG_GL_DZ","ACR_SNOW_ACOG_GL_SD_DZ","ACR_SNOW_TWS_DZ","ACR_SNOW_TWS_GL_DZ","ACR_SNOW_TWS_SD_DZ","ACR_SNOW_TWS_GL_SD_DZ","ACR_SNOW_NV_DZ","ACR_SNOW_NV_SD_DZ","ACR_SNOW_NV_GL_DZ","ACR_SNOW_NV_GL_SD_DZ","KAC_PDW_DZ","KAC_PDW_CCO_DZ","KAC_PDW_HOLO_DZ","KAC_PDW_ACOG_DZ","CTAR21_DZ","CTAR21_CCO_DZ","CTAR21_ACOG_DZ","Masada_DZ","Masada_SD_DZ","Masada_CCO_DZ","Masada_CCO_SD_DZ","Masada_Holo_DZ","Masada_Holo_SD_DZ","Masada_ACOG_DZ","Masada_ACOG_SD_DZ","Masada_BL_DZ","Masada_BL_SD_DZ","Masada_BL_CCO_DZ","Masada_BL_CCO_SD_DZ","Masada_BL_Holo_DZ","Masada_BL_Holo_SD_DZ","Masada_BL_ACOG_DZ","Masada_BL_ACOG_SD_DZ","MK16_DZ","MK16_CCO_DZ","MK16_Holo_DZ","MK16_ACOG_DZ","MK16_GL_DZ","MK16_GL_CCO_DZ","MK16_GL_Holo_DZ","MK16_GL_ACOG_DZ","MK16_CCO_SD_DZ","MK16_Holo_SD_DZ","MK16_ACOG_SD_DZ","MK16_GL_CCO_SD_DZ","MK16_GL_Holo_SD_DZ","MK16_GL_ACOG_SD_DZ","MK16_BL_CCO_DZ","MK16_BL_GL_ACOG_DZ","MK16_BL_Holo_SD_DZ","MK16_BL_GL_CCO_SD_DZ","XM8_DZ","XM8_DES_DZ","XM8_GREY_DZ","XM8_GREY_2_DZ","XM8_GL_DZ","XM8_DES_GL_DZ","XM8_GREY_GL_DZ","XM8_Compact_DZ","XM8_DES_Compact_DZ","XM8_GREY_Compact_DZ","XM8_GREY_2_Compact_DZ","XM8_Sharpsh_DZ","XM8_DES_Sharpsh_DZ","XM8_GREY_Sharpsh_DZ","XM8_SAW_DZ","XM8_DES_SAW_DZ","XM8_GREY_SAW_DZ","XM8_SD_DZ","M14_DZ","M14_Gh_DZ","M14_CCO_DZ","M14_CCO_Gh_DZ","M14_Holo_DZ","M14_Holo_Gh_DZ","M1A_SC16_BL_DZ","M1A_SC16_BL_ACOG_DZ","M1A_SC16_BL_CCO_DZ","M1A_SC16_BL_HOLO_DZ","M1A_SC16_BL_PU_DZ","M1A_SC16_BL_Sniper_DZ","M1A_SC16_TAN_DZ","M1A_SC16_TAN_ACOG_DZ","M1A_SC16_TAN_CCO_DZ","M1A_SC16_TAN_HOLO_DZ","M1A_SC16_TAN_PU_DZ","M1A_SC16_TAN_Sniper_DZ","M1A_SC2_BL_DZ","M1A_SC2_BL_ACOG_DZ","M1A_SC2_BL_CCO_DZ","M1A_SC2_BL_HOLO_DZ","M1A_SC2_BL_PU_DZ","M1A_SC2_BL_Sniper_DZ","M21_DZ","M21A5_DZ","M21A5_SD_DZ","HK417_DZ","HK417_SD_DZ","HK417_CCO_DZ","HK417_CCO_SD_DZ","HK417_Holo_DZ","HK417_Holo_SD_DZ","HK417_ACOG_DZ","HK417_ACOG_SD_DZ","HK417C_DZ","HK417C_GL_DZ","HK417C_CCO_DZ","HK417C_GL_CCO_DZ","HK417C_Holo_DZ","HK417C_GL_Holo_DZ","HK417C_ACOG_DZ","HK417C_GL_ACOG_DZ","HK417_Sniper_DZ","HK417_Sniper_SD_DZ","MK14_DZ","MK14_CCO_DZ","MK14_Holo_DZ","MK14_ACOG_DZ","MK14_Sniper_DZ","MK14_SD_DZ","MK14_CCO_SD_DZ","MK14_Holo_SD_DZ","MK14_ACOG_SD_DZ","MK14_Sniper_SD_DZ","MK17_DZ","MK17_CCO_DZ","MK17_Holo_DZ","MK17_ACOG_DZ","MK17_GL_DZ","MK17_GL_CCO_DZ","MK17_GL_Holo_DZ","MK17_GL_ACOG_DZ","MK17_CCO_SD_DZ","MK17_Holo_SD_DZ","MK17_ACOG_SD_DZ","MK17_GL_CCO_SD_DZ","MK17_GL_Holo_SD_DZ","MK17_BL_Holo_DZ","MK17_BL_GL_ACOG_DZ","MK17_BL_CCO_SD_DZ","MK17_BL_GL_Holo_SD_DZ","MK17_Sniper_DZ","MK17_Sniper_SD_DZ","M110_NV_DZ","CZ805_A1_DZ","CZ805_A1_GL_DZ","CZ805_A2_DZ","CZ805_A2_SD_DZ","CZ805_B_GL_DZ","M24_DZ","M24_Gh_DZ","M24_DES_DZ","M40A3_Gh_DZ","M40A3_DZ","CZ750_DZ","M249_CCO_DZ","M249_DZ","M249_Holo_DZ","M249_EP1_DZ","M249_m145_EP1_DZE","L110A1_CCO_DZ","L110A1_Holo_DZ","L110A1_DZ","BAF_L110A1_Aim_DZE","M240_DZ","M240_CCO_DZ","M240_Holo_DZ","m240_scoped_EP1_DZE","M60A4_EP1_DZE","Mk43_DZ","MK43_Holo_DZ","MK43_ACOG_DZ","MK43_M145_DZ","M1014_DZ","M1014_CCO_DZ","M1014_Holo_DZ","Mk48_CCO_DZ","Mk48_DZ","Mk48_Holo_DZ","Mk48_DES_CCO_DZ","PKM_DZ","Pecheneg_DZ","UK59_DZ","RPK74_Kobra_DZ","RPK74_DZ","RPK74_PSO1_DZ","SVD_PSO1_DZ","SVD_PSO1_Gh_DZ","SVD_DZ","SVD_Gh_DZ","SVD_PSO1_Gh_DES_DZ","SVD_NSPU_DZ","SVD_Gold_DZ","SVU_PSO1_DZ","VSS_vintorez_DZE","VAL_DZ","VAL_Kobra_DZ","VAL_PSO1_DZ","KSVK_DZE","Mosin_DZ","Mosin_BR_DZ","Mosin_FL_DZ","Mosin_MFL_DZ","Mosin_Belt_DZ","Mosin_Belt_FL_DZ","Mosin_Belt_MFL_DZ","Mosin_PU_DZ","Mosin_PU_FL_DZ","Mosin_PU_MFL_DZ","Mosin_PU_Belt_DZ","Mosin_PU_Belt_FL_DZ","Mosin_PU_Belt_MFL_DZ","MP5_DZ","MP5_SD_DZ","Kriss_DZ","Kriss_CCO_DZ","Kriss_Holo_DZ","Kriss_SD_DZ","Kriss_CCO_SD_DZ","Kriss_Holo_SD_DZ","Scorpion_Evo3_DZ","Scorpion_Evo3_CCO_DZ","Scorpion_Evo3_CCO_SD_DZ","MP7_DZ","MP7_FL_DZ","MP7_MFL_DZ","MP7_Holo_DZ","MP7_Holo_FL_DZ","MP7_Holo_MFL_DZ","MP7_CCO_DZ","MP7_CCO_FL_DZ","MP7_CCO_MFL_DZ","MP7_ACOG_DZ","MP7_ACOG_FL_DZ","MP7_ACOG_MFL_DZ","MP7_SD_DZ","MP7_SD_FL_DZ","MP7_SD_MFL_DZ","MP7_Holo_SD_DZ","MP7_Holo_SD_FL_DZ","MP7_Holo_SD_MFL_DZ","MP7_CCO_SD_DZ","MP7_CCO_SD_FL_DZ","MP7_CCO_SD_MFL_DZ","MP7_ACOG_SD_DZ","MP7_ACOG_SD_FL_DZ","MP7_ACOG_SD_MFL_DZ","TMP_DZ","TMP_CCO_DZ","TMP_Holo_DZ","TMP_SD_DZ","TMP_CCO_SD_DZ","TMP_Holo_SD_DZ","UMP_DZ","UMP_CCO_DZ","UMP_Holo_DZ","UMP_SD_DZ","UMP_CCO_SD_DZ","UMP_Holo_SD_DZ","P90_DZ","P90_CCO_DZ","P90_Holo_DZ","P90_SD_DZ","P90_CCO_SD_DZ","P90_Holo_SD_DZ","Sten_MK_DZ","MAT49_DZ","M31_DZ","M16A2_DZ","M16A2_GL_DZ","M16A2_Rusty_DZ","M16A4_DZ","M16A4_FL_DZ","M16A4_MFL_DZ","M16A4_GL_DZ","M16A4_GL_FL_DZ","M16A4_GL_MFL_DZ","M16A4_CCO_DZ","M16A4_CCO_FL_DZ","M16A4_CCO_MFL_DZ","M16A4_GL_CCO_DZ","M16A4_GL_CCO_FL_DZ","M16A4_GL_CCO_MFL_DZ","M16A4_Holo_DZ","M16A4_Holo_FL_DZ","M16A4_Holo_MFL_DZ","M16A4_GL_Holo_DZ","M16A4_GL_Holo_FL_DZ","M16A4_GL_Holo_MFL_DZ","M16A4_ACOG_DZ","M16A4_ACOG_FL_DZ","M16A4_ACOG_MFL_DZ","M16A4_GL_ACOG_DZ","M16A4_GL_ACOG_FL_DZ","M16A4_GL_ACOG_MFL_DZ","SA58_DZ","SA58_RIS_DZ","SA58_RIS_FL_DZ","SA58_RIS_MFL_DZ","SA58_CCO_DZ","SA58_CCO_FL_DZ","SA58_CCO_MFL_DZ","SA58_Holo_DZ","SA58_Holo_FL_DZ","SA58_Holo_MFL_DZ","SA58_ACOG_DZ","SA58_ACOG_FL_DZ","SA58_ACOG_MFL_DZ","Sa58V_DZ","Sa58V_Camo_CCO_DZ","Sa58V_Camo_ACOG_DZ","L85A2_DZ","L85A2_FL_DZ","L85A2_MFL_DZ","L85A2_SD_DZ","L85A2_SD_FL_DZ","L85A2_SD_MFL_DZ","L85A2_CCO_DZ","L85A2_CCO_FL_DZ","L85A2_CCO_MFL_DZ","L85A2_CCO_SD_DZ","L85A2_CCO_SD_FL_DZ","L85A2_CCO_SD_MFL_DZ","L85A2_Holo_DZ","L85A2_Holo_FL_DZ","L85A2_Holo_MFL_DZ","L85A2_Holo_SD_DZ","L85A2_Holo_SD_FL_DZ","L85A2_Holo_SD_MFL_DZ","L85A2_ACOG_DZ","L85A2_ACOG_FL_DZ","L85A2_ACOG_MFL_DZ","L85A2_ACOG_SD_DZ","L85A2_ACOG_SD_FL_DZ","L85A2_ACOG_SD_MFL_DZ","BAF_L85A2_RIS_TWS_DZ","L86A2_LSW_DZ","Bizon_DZ","Bizon_Kobra_DZ","Bizon_SD_DZ","Bizon_Kobra_SD_DZ","CZ550_DZ","LeeEnfield_DZ","MR43_DZ","Winchester1866_DZ","Remington870_DZ","Remington870_FL_DZ","Remington870_MFL_DZ","Saiga12K_DZ","USAS12_DZ","AA12_DZ","Crossbow_DZ","Crossbow_FL_DZ","Crossbow_MFL_DZ","Crossbow_CCO_DZ","Crossbow_CCO_FL_DZ","Crossbow_CCO_MFL_DZ","Crossbow_Scope_DZ","Crossbow_Scope_FL_DZ","Crossbow_Scope_MFL_DZ","L115A3_DZ","L115A3_2_DZ","MSR_DZ","MSR_SD_DZ","MSR_NV_DZ","MSR_NV_SD_DZ","MSR_TWS_DZ","MSR_TWS_SD_DZ","XM2010_DZ","XM2010_SD_DZ","XM2010_NV_DZ","XM2010_NV_SD_DZ","XM2010_TWS_DZ","XM2010_TWS_SD_DZ","Anzio_20_DZ","BAF_AS50_scoped_DZ","m107_DZ","m107_SKN","M4SPR_DZE","M200_CheyTac_DZ","M200_CheyTac_SD_DZ","WA2000_DZ","Barrett_MRAD_Iron_DZ","Barrett_MRAD_CCO_DZ","Barrett_MRAD_Sniper_DZ","M9_DZ","M9_SD_DZ","M9_Camo_DZ","M9_Camo_SD_DZ","M93R_DZ","P99_Black_DZ","P99_Black_SD_DZ","P99_Green_DZ","P99_Green_SD_DZ","P99_Silver_DZ","P99_Silver_SD_DZ","BrowningHP_DZ","P226_DZ","P226_Silver_DZ","P38_DZ","PPK_DZ","MK22_DZ","MK22_2_DZ","MK22_SD_DZ","MK22_2_SD_DZ","G17_DZ","G17_FL_DZ","G17_MFL_DZ","G17_SD_DZ","G17_SD_FL_DZ","G17_SD_MFL_DZ","G18_DZ","M1911_DZ","M1911_2_DZ","Kimber_M1911_DZ","Kimber_M1911_SD_DZ","USP_DZ","USP_SD_DZ","Makarov_DZ","Makarov_SD_DZ","Tokarew_TT33_DZ","Ruger_MK2_DZ","APS_DZ","APS_SD_DZ","PDW_DZ","PDW_SD_DZ","TEC9_DZ","Mac10_DZ","Revolver_DZ","Revolver_Gold_DZ","Colt_Anaconda_DZ","Colt_Anaconda_Gold_DZ","Colt_Bull_DZ","Colt_Python_DZ","Colt_Revolver_DZ","CZ75P_DZ","CZ75D_DZ","CZ75SP_DZ","CZ75SP_SD_DZ","DesertEagle_DZ","DesertEagle_Gold_DZ","DesertEagle_Silver_DZ","DesertEagle_Modern_DZ","Sa61_DZ"]

// Overwatch Weapons
#define	OW_WEPS ["RH_m9","RH_m9c","RH_m93r","RH_M9sd","RH_m9csd","RH_browninghp","vil_B_HP","RH_anac","RH_anacg","RH_python","RH_deagle","RH_Deagleg","RH_Deaglem","RH_Deaglemzb","RH_Deaglemz","RH_Deagles","vil_Glock","RH_g17","vil_Glock_o","RH_g17sd","RH_g18","RH_g19","RH_g19t","RH_tec9","RH_m1911","RH_m1911sd","RH_m1911old","RH_mk22","RH_mk22sd","RH_mk22v","RH_mk22vsd","RH_p38","RH_ppk","RH_mk2","RH_p226","RH_p226s","RH_bull","RH_tt33","RH_usp","RH_uspm","RH_uspsd","vil_USP45","vil_USP45SD","vil_USP","vil_USPSD","RH_vz61",		"vil_AEK2","vil_AEK_GL","vil_AeK_3","vil_AeK_23","vil_AeK_3_K","vil_AK_105","Vil_AK_105_c","vil_AK_101","vil_AK_103","vil_AK_107","Vil_AK_107_c","vil_ak12","vil_ak12_ap","vil_ak12_gp","vil_AK_47","vil_AK_47_49","vil_AK_47_m1","vil_AK_47","vil_AK_74_N","vil_AK_74P","vil_AK_74m","vil_AK_74m_p29","vil_AK_74m_EOT_Alfa","vil_AK_74m_gp_29","vil_AK_74m_gp","vil_AK_74m_EOT","vil_AK_74m_EOT_FSB","vil_AK_74m_EOT_FSB_60","vil_AK_74m_EOT_FSB_45","vil_AK_74m_c","vil_AK_74m_k","vil_AK_74m_PSO","vil_AKM","vil_AKM_GL","vil_AKMS","vil_AKMS_GP25","vil_AKMSB","vil_AKS_47","vil_AKS_74","vil_AKS_74_gp","vil_AKS_74p_gp","vil_AKS_74p","vil_AKS_74p_45","vil_AKs_74_u","vil_AKs_74_u45","Vil_AKS_74_UB","Vil_AKS_74_UN_kobra","vil_AMD63","vil_AMD","vil_Abakan","vil_Abakan_P29","vil_Abakan_gp","vil_AK_nato_m1","vil_ASH82","vil_MPi","vil_PMI74S","vil_PMI","vil_PMIS","vil_type88_1","vil_M64","vil_M70","vil_M70B","vil_AK_nato_m80",		"vil_Galil","vil_Galil_arm","vil_SKS","gms_k98","gms_k98_knife","gms_k98_rg","gms_k98zf39","FHQ_ACR_BLK_CCO_GL_SD","FHQ_ACR_TAN_CCO_GL_SD","FHQ_ACR_SNW_CCO_GL_SD","FHQ_ACR_WDL_CCO_GL_SD","FHQ_ACR_BLK_CCO_SD","FHQ_ACR_TAN_CCO_SD","FHQ_ACR_SNW_CCO_SD","FHQ_ACR_WDL_CCO_SD","FHQ_ACR_BLK_G33_GL_SD","FHQ_ACR_TAN_G33_GL_SD","FHQ_ACR_SNW_G33_GL_SD","FHQ_ACR_WDL_G33_GL_SD","FHQ_ACR_BLK_G33_SD","FHQ_ACR_TAN_G33_SD","FHQ_ACR_SNW_G33_SD","FHQ_ACR_WDL_G33_SD","FHQ_ACR_BLK_HAMR_GL_SD","FHQ_ACR_TAN_HAMR_GL_SD","FHQ_ACR_SNW_HAMR_GL_SD","FHQ_ACR_WDL_HAMR_GL_SD","FHQ_ACR_BLK_HAMR_SD","FHQ_ACR_TAN_HAMR_SD","FHQ_ACR_SNW_HAMR_SD","FHQ_ACR_WDL_HAMR_SD","FHQ_ACR_BLK_HWS_GL_SD","FHQ_ACR_TAN_HWS_GL_SD","FHQ_ACR_SNW_HWS_GL_SD","FHQ_ACR_WDL_HWS_GL_SD","FHQ_ACR_BLK_HWS_SD","FHQ_ACR_TAN_HWS_SD","FHQ_ACR_SNW_HWS_SD","FHQ_ACR_WDL_HWS_SD","FHQ_ACR_BLK_IRN_GL_SD","FHQ_ACR_TAN_IRN_GL_SD","FHQ_ACR_SNW_IRN_GL_SD","FHQ_ACR_WDL_IRN_GL_SD","FHQ_ACR_BLK_RCO_GL_SD","FHQ_ACR_TAN_RCO_GL_SD","FHQ_ACR_SNW_RCO_GL_SD","FHQ_ACR_WDL_RCO_GL_SD","FHQ_ACR_BLK_RCO_SD","FHQ_ACR_TAN_RCO_SD","FHQ_ACR_SNW_RCO_SD","FHQ_ACR_WDL_RCO_SD","FHQ_ACR_BLK_IRN_SD","FHQ_ACR_TAN_IRN_SD","FHQ_ACR_SNW_IRN_SD","FHQ_ACR_WDL_IRN_SD",		"FHQ_ACR_BLK_IRN","FHQ_ACR_TAN_IRN","FHQ_ACR_SNW_IRN","FHQ_ACR_WDL_IRN","FHQ_ACR_BLK_CCO","FHQ_ACR_TAN_CCO","FHQ_ACR_SNW_CCO","FHQ_ACR_WDL_CCO","FHQ_ACR_BLK_CCO_GL","FHQ_ACR_TAN_CCO_GL","FHQ_ACR_SNW_CCO_GL","FHQ_ACR_WDL_CCO_GL","FHQ_ACR_BLK_G33","FHQ_ACR_TAN_G33","FHQ_ACR_SNW_G33","FHQ_ACR_WDL_G33","FHQ_ACR_BLK_G33_GL","FHQ_ACR_TAN_G33_GL","FHQ_ACR_SNW_G33_GL","FHQ_ACR_WDL_G33_GL","FHQ_ACR_BLK_HAMR","FHQ_ACR_TAN_HAMR","FHQ_ACR_SNW_HAMR","FHQ_ACR_WDL_HAMR","FHQ_ACR_BLK_HAMR_GL","FHQ_ACR_TAN_HAMR_GL","FHQ_ACR_SNW_HAMR_GL","FHQ_ACR_WDL_HAMR_GL","FHQ_ACR_BLK_HWS","FHQ_ACR_TAN_HWS","FHQ_ACR_SNW_HWS","FHQ_ACR_WDL_HWS","FHQ_ACR_BLK_HWS_GL","FHQ_ACR_TAN_HWS_GL","FHQ_ACR_SNW_HWS_GL","FHQ_ACR_WDL_HWS_GL","FHQ_ACR_BLK_IRN_GL","FHQ_ACR_TAN_IRN_GL","FHQ_ACR_SNW_IRN_GL","FHQ_ACR_WDL_IRN_GL","FHQ_ACR_BLK_RCO","FHQ_ACR_TAN_RCO","FHQ_ACR_SNW_RCO","FHQ_ACR_WDL_RCO","FHQ_ACR_BLK_RCO_GL","FHQ_ACR_TAN_RCO_GL","FHQ_ACR_SNW_RCO_GL","FHQ_ACR_WDL_RCO_GL",		"SCAR_L_CQC_CCO_SD","SCAR_L_CQC","SCAR_L_CQC_Holo","SCAR_L_CQC_EGLM_Holo","SCAR_L_STD_EGLM_RCO","SCAR_L_STD_HOLO","SCAR_L_STD_Mk4CQT","SCAR_H_CQC_CCO","SCAR_H_CQC_CCO_SD","SCAR_H_STD_EGLM_Spect","SCAR_H_LNG_Sniper","SCAR_H_LNG_Sniper_SD","vil_9a91","vil_9a91_c","vil_9a91_csd","vil_VAL","vil_VAL_C","vil_Groza_HG","vil_Groza_GL","vil_Groza_SC","vil_Groza_SD","vil_Vikhr","vil_vsk94","vil_MP5_EOTech","vil_MP5SD_EOTech","vil_uzimini","vil_uzimini_SD","vil_uzi","vil_uzi_c","vil_uzi_SD",		"USSR_cheytacM200","USSR_cheytacM200_sd","vil_SVD_63","vil_SVD_N","vil_SVD_M","vil_SVD_P21","vil_SVD_S","FHQ_MSR_DESERT","FHQ_MSR_NV_DESERT","FHQ_MSR_NV_SD_DESERT","FHQ_MSR_SD_DESERT","FHQ_RSASS_TAN","FHQ_RSASS_SD_TAN","vil_SV_98_69","vil_SV_98","vil_SV_98_SD","vil_SVDK","FHQ_XM2010_DESERT","FHQ_XM2010_NV_DESERT","FHQ_XM2010_NV_SD_DESERT","FHQ_XM2010_SD_DESERT","RH_ctar21","RH_ctar21glacog","RH_ctar21m","RH_ctar21mgl","RH_star21","vil_AG3","vil_G3a2","vil_G3a3","vil_G3an","vil_G3anb","vil_G3SG1","vil_G3sg1b","vil_G3TGS","vil_G3TGSb","vil_G3ZF","vil_G3zfb","vil_G3a4","vil_G3a4b","RH_masacog","RH_masaim","RH_masbaim","RH_masb","RH_masbeotech","RH_mas","RH_massd","RH_massdacog","RH_masbsdacog","RH_massdaim","RH_masbsdaim","RH_masbsd","RH_massdeotech","RH_masbsdeotech","vil_RPK75_Romania","vil_M240_B","vil_M249_Para","skavil_M60","skavil_M60e3","vil_Mg3","vil_MG4","vil_MG4E","vil_PKP","vil_PKP_EOT","vil_PK","vil_PKM","vil_RPD","vil_RPK","vil_RPK75","vil_RPK74","vil_RPK74M","vil_RPK74M_P29","vil_RPK75_M72","vil_zastava_m84","RH_hk417","RH_hk417acog","RH_hk417aim","RH_hk417s","RH_hk417sacog","RH_hk417saim","RH_hk417seotech","RH_hk417eotech","RH_hk417sd","RH_hk417sdacog","RH_hk417sdaim","RH_hk417sdeotech","RH_hk417sdsp","RH_hk417sp","RH_hk417sglacog","RH_hk417sgl","RH_hk417sglaim","RH_hk417sgleotech",		"RH_hk416","RH_hk416glacog","RH_hk416gl","RH_hk416aim","RH_hk416glaim","RH_hk416s","RH_hk416sacog","RH_hk416sglacog","RH_hk416saim","RH_hk416sglaim","RH_hk416seotech","RH_hk416sgleotech","RH_hk416sgl","RH_hk416eotech","RH_hk416gleotech","RH_hk416sd","RH_hk416sdgl","RH_hk416sdglaim","RH_hk416sdeotech","RH_hk416sdgleotech","vil_AG36KA4","vil_AG36KV","vil_G36KSKdes","vil_G36KA4","vil_G36KSKES","vil_G36KSKdesES","vil_G36KES","vil_G36KVZ","vil_G36KSK","vil_G36VA4Eot","vil_G36KV3","vil_G36KVA4","vil_G36KV3Des","vil_G36VA4","vil_AG36","vil_G36a2","vil_AG36A2","vil_G36CC","vil_G36E"]

//_activatingPlayer = _this select 0;
//_params = _this select 1;
//_clientKey = _this select 2;
local _selectDelay = _params select 0;
local _crate = _params select 1;
local _dir = _params select 2;
local _pos = _params select 3;
//_playerUID = getPlayerUID _activatingPlayer;
local _spawnCrate = "";


_exitReason = [_this,"EAT_crateSpawn",(_worldspace select 1),_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
if (_exitReason != "") exitWith {diag_log _exitReason};

call
{
	if (_crate == "Items") exitWith {
		CRATE_SETUP
		ADD_BACKPACK
		local _parents = ["FakeMagazine","ItemAntibiotic","ItemSodaEmpty","ItemWaterBottle","TrashTinCan"];
		local _ignore = ["bloodBagBase","SkinBase","wholeBloodBagBase","ItemAntibiotic_base","ItemAntibioticEmpty","ItemBriefcase_Base","ItemBriefcaseEmpty","ItemSilvercase_Base","ItemSodaEmpty","TrashTinCan","ItemFuelcanEmpty","ItemJerrycanEmpty","ItemFuelBarrelEmpty"];
		local _cfg = configFile >> "cfgMagazines";
		for "_i" from 0 to (count _cfg) - 1 do {
			local _type = _cfg select _i;
			local _item = configName _type;
			if (isClass _type && {getNumber (_type >> "scope") > 1} && {!(_item in _ignore)} && {!(configName(inheritsFrom _type) in _parents)} && {!(["Rnd",_item] call fnc_inString)} && {!(["_Swing",_item] call fnc_inString)} && {!(["cinder_",_item] call fnc_inString)} && {!(["metal_",_item] call fnc_inString)} && {!(["ItemWood",_item] call fnc_inString)} && {!(["PartWood",_item] call fnc_inString)}) then {
				_spawnCrate addMagazineCargoGlobal [_item, 5];
			};
		};
		local _cfg = configFile >> "cfgWeapons";
		local _parents = ["FakeWeapon","ItemMatchbox"];
		local _ignore = ["ItemCore","ItemKnife_Base","ItemMatchbox_base"];
		for "_i" from 0 to (count _cfg) - 1 do {
			local _type = _cfg select _i;
			local _item = configName _type;
			if (isClass _type && {isNumber (_type >> "type")} && {!(configName(inheritsFrom(_type)) in _parents)} && {!isNumber (_type >> "keyid")} && {!(_item in _ignore)}) then {
				if (getNumber (_type >> "type") == 131072) then {
					_spawnCrate addWeaponCargoGlobal [_item, 1];
				};
			};
		};
	};
	if (_crate == "Backpack") exitWith {
		CRATE_SETUP
		{_spawnCrate addBackpackCargoGlobal [_x, 1];} forEach BACKPACKS;
	};
	if (_crate == "AllItemsBuilding") exitWith {
		CRATE_SETUP
		ADD_5X BUILDING_TOOLS;
		ADD ADMIN_BUILD_CRATE;
		ADD_BACKPACK
	};
	if (_crate == "smallCinderBuildingKit") exitWith {
		CRATE_SETUP
		ADD_1X BUILDING_TOOLS;
		ADD SM_CINDER_KIT;
		ADD_BACKPACK
	};
	if (_crate == "mediumCinderBuildingKit") exitWith {
		CRATE_SETUP
		ADD_1X BUILDING_TOOLS;
		ADD MD_CINDER_KIT;
		ADD_BACKPACK
	};
	if (_crate == "largeCinderBuildingKit") exitWith {
		CRATE_SETUP
		ADD_1X BUILDING_TOOLS;
		ADD LG_CINDER_KIT;
		ADD_BACKPACK
	};
	if (_crate == "smallWoodBuildingKit") exitWith {
		CRATE_SETUP
		ADD_1X BUILDING_TOOLS;
		ADD SM_WOOD_KIT;
		ADD_BACKPACK
	};
	if (_crate == "mediumWoodBuildingKit") exitWith {
		CRATE_SETUP
		ADD_1X BUILDING_TOOLS;
		ADD MD_WOOD_KIT;
		ADD_BACKPACK
	};
	if (_crate == "largeWoodBuildingKit") exitWith {
		CRATE_SETUP
		ADD_1X BUILDING_TOOLS;
		ADD LG_WOOD_KIT;
		ADD_BACKPACK
	};
	if (_crate == "VanillaBuildKit") exitWith {
		CRATE_SETUP
		ADD_1X ["ItemToolbox","ItemEtool"];
		ADD VANILLA_KIT;
		ADD_BACKPACK
	};
	if (_crate == "EpochWeapons") exitWith {
		CRATE_SETUP
		local _tArr = []; // Create temp array to prevent duplicate magazine spawning
		local _mag = "";
		{
			_spawnCrate addWeaponCargoGlobal [_x, 1];
			local _ammo = getArray (configFile >> "cfgWeapons" >> _x >> "magazines");
			if (count _ammo > 0) then {
				_mag = _ammo select 0;
				if !(_mag in _tArr) then {
					_spawnCrate addMagazineCargoGlobal [_mag, 30];
					_tArr set [count _tArr, _mag];
				};
			};
		} forEach EPOCH_WEPS;
		ADD_BACKPACK
	};
	if (_crate == "OverwatchWeapons") exitWith {
		CRATE_SETUP
		local _tArr = []; // Create temp array to prevent duplicate magazine spawning
		local _mag = "";
		{
			_spawnCrate addWeaponCargoGlobal [_x, 1];
			local _ammo = getArray (configFile >> "cfgWeapons" >> _x >> "magazines");
			if (count _ammo > 0) then {
				_mag = _ammo select 0;
				if !(_mag in _tArr) then {
					_spawnCrate addMagazineCargoGlobal [_mag, 30];
					_tArr set [count _tArr, _mag];
				};
			};
		} forEach OW_WEPS;
		ADD_BACKPACK
	};
	if (_crate == "RocketLaunchers") exitWith {
		CRATE_SETUP
		ADD_BACKPACK
		local _tArr = []; // Create temp array to prevent duplicate magazine spawning
		local _mag = "";
		local _ignore = ["LauncherCore","Launcher"];
		local _cfg = configFile >> "cfgWeapons";
		for "_i" from 0 to (count _cfg) - 1 do {
			local _type = _cfg select _i;
			local _item = configName _type;
			if (isClass _type && {isNumber (_type >> "type")} && {!(_item in _ignore)}) then {
				if (getNumber (_type >> "type") == 4) then { // type 4 is launcher
					_spawnCrate addWeaponCargoGlobal [_item, 1];
					local _ammo = getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
					if (count _ammo > 0) then {
						_mag = _ammo select 0;
						if !(_mag in _tArr) then {
							_spawnCrate addMagazineCargoGlobal [_mag, 5];
							_tArr set [count _tArr, _mag];
						};
					};
				};
			};
		};
	};
};

if (_selectDelay != 0) exitWith {
	[_selectDelay,_spawnCrate] spawn {
		
		uiSleep (_this select 0);
		deleteVehicle (_this select 1);
	};
};