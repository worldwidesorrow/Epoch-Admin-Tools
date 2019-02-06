private ["_playerUID","_clientKey","_worldspace","_selectDelay","_crate","_pos","_dir","_activatingPlayer","_bloodBag","_cfgweapons","_weapon","_key_colors","_wpn_type","_cfgmagazines","_magazine","_mag_type","_classname","_spawnCrate"];

// Macros for repeatable code
#define CRATE_SETUP _spawnCrate = _classname createVehicle _pos; _spawnCrate setDir _dir; _spawnCrate setposATL _pos; clearWeaponCargoGlobal _spawnCrate; clearMagazineCargoGlobal _spawnCrate; clearBackpackCargoGlobal _spawnCrate; _spawnCrate setVariable ["ObjectID","1",true]; dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_spawnCrate];
#define ADD_BACKPACK _spawnCrate addBackpackCargoGlobal ["DZ_LargeGunBag_EP1", 1];
#define ADD {_spawnCrate addMagazineCargoGlobal _x;} forEach
#define ADD_1X {_spawnCrate addWeaponCargoGlobal [_x, 1];} forEach
#define ADD_5X {_spawnCrate addWeaponCargoGlobal [_x, 5];} forEach

// Backpack crate
#define BACKPACKS ["DZ_Backpack_EP1","DZ_British_ACU","DZ_CivilBackpack_EP1","DZ_GunBag_EP1","DZ_LargeGunBag_EP1"]

// Items Crate
_bloodBag = "ItemBloodbag";
if(dayz_classicBloodBagSystem) then {_bloodBag = "bloodBagONEG";};
#define TOOLBELT ["Binocular","Binocular_Vector","ItemCompass","ItemCrowbar","ItemEtool","ItemFishingPole","ItemFlashlight","ItemFlashlightRed","ItemGPS","ItemHatchet","ItemKeyKit","ItemKnife","ItemMap","ItemMatchBox","ItemRadio","ItemSledge","ItemToolbox","ItemWatch","Laserdesignator","NVGoggles"]
#define CRATE_ITEMS ["FoodbeefCooked","HandChemBlue","HandChemGreen","HandChemRed","HandRoadFlare","ItemAntibiotic","ItemBandage",_bloodBag,"ItemBriefcase100oz","ItemBriefcaseEmpty","ItemCopperBar","ItemCopperBar10oz","ItemEpinephrine","ItemFuelBarrel","ItemGoldBar","ItemGoldBar10oz","ItemHeatPack","ItemJerrycan","ItemMorphine","ItemOilBarrel","ItemPainkiller","ItemSilverBar","ItemSilverBar10oz","ItemSodaMdew","PartEngine","PartFueltank","PartGeneric","PartGlass","PartVRotor","PartWheel","Skin_Bandit1_DZ","Skin_Bandit2_DZ","Skin_BanditW1_DZ","Skin_BanditW2_DZ","Skin_CZ_Soldier_Sniper_EP1_DZ","Skin_CZ_Special_Forces_GL_DES_EP1_DZ","Skin_Drake_Light_DZ","Skin_FR_OHara_DZ","Skin_FR_Rodriguez_DZ","Skin_Functionary1_EP1_DZ","Skin_Graves_Light_DZ","Skin_GUE_Commander_DZ","Skin_GUE_Soldier_2_DZ","Skin_GUE_Soldier_CO_DZ","Skin_GUE_Soldier_Crew_DZ","Skin_GUE_Soldier_MG_DZ","Skin_GUE_Soldier_Sniper_DZ","Skin_Haris_Press_EP1_DZ","Skin_Ins_Soldier_GL_DZ","Skin_Pilot_EP1_DZ","Skin_Priest_DZ","Skin_Rocker1_DZ","Skin_Rocker2_DZ","Skin_Rocker3_DZ","Skin_Rocker4_DZ","Skin_Rocket_DZ","Skin_RU_Policeman_DZ","Skin_Sniper1_DZ","Skin_Soldier_Bodyguard_AA12_PMC_DZ","Skin_Soldier_Sniper_PMC_DZ","Skin_Soldier_TL_PMC_DZ","Skin_SurvivorW2_DZ","Skin_SurvivorW3_DZ","Skin_SurvivorWcombat_DZ","Skin_SurvivorWdesert_DZ","Skin_SurvivorWpink_DZ","Skin_SurvivorWurban_DZ","Skin_Assistant_DZ","Skin_TK_INS_Soldier_EP1_DZ","Skin_TK_INS_Warlord_EP1_DZ","TrapBear","TrashJackDaniels","TrashTinCan"]

// Building Crates
#define BUILDING_TOOLS ["ItemCrowbar","ItemEtool","ItemHatchet","ItemMatchBox","ItemSledge","ItemToolbox","ChainSaw"]
#define ADMIN_BUILD_CRATE [["plot_pole_kit", 10],["bulk_empty", 10],["bulk_ItemTankTrap", 20],["bulk_ItemWire",  10],["CinderBlocks", 30],["cinder_door_kit", 10],["cinder_garage_kit", 10],["full_cinder_wall_kit", 60],["deer_stand_kit", 10],["desert_large_net_kit", 10],["desert_net_kit", 10],["forest_large_net_kit", 10],["forest_net_kit", 10],["fuel_pump_kit", 10],["ItemBurlap", 10],["ItemCanvas", 10],["ItemComboLock", 10],["ItemCorrugated", 10],["ItemFireBarrel_Kit", 10],["ItemFuelBarrelEmpty", 10],["ItemGenerator", 10],["ItemGunRackKit", 10],["ItemHotwireKit", 10],["ItemJerrycan", 10],["ItemLockbox", 10],["ItemPole", 10],["ItemSandbag", 50],["ItemSandbagExLarge", 20],["ItemSandbagExLarge5x", 20],["ItemSandbagLarge", 20],["ItemScaffoldingKit", 10],["BagFenceRound_DZ_kit",20],["ItemTankTrap", 10],["ItemTent", 5],["ItemDesertTent", 5],["ItemVault", 10],["ItemWire", 10],["ItemWoodFloor", 30],["ItemWoodFloorHalf", 30],["ItemWoodFloorQuarter", 30],["ItemWoodLadder", 30],["ItemWoodStairs", 10],["ItemWoodStairsSupport", 10],["ItemWoodWall", 30],["ItemWoodWallDoor", 10],["ItemWoodWallDoorLg", 10],["ItemWoodWallGarageDoor", 10],["ItemWoodWallGarageDoorLocked", 10],["ItemWoodWallLg", 30],["ItemWoodWallThird", 20],["ItemWoodWallWindow", 20],["ItemWoodWallWindowLg", 30],["ItemWoodWallWithDoor", 10],["ItemWoodWallwithDoorLg", 10],["ItemWoodWallWithDoorLgLocked", 10],["ItemWoodWallWithDoorLocked", 10],["light_pole_kit", 10],["m240_nest_kit", 5],["metal_floor_kit", 60],["metal_panel_kit", 20],["MortarBucket", 5],["outhouse_kit", 5],["park_bench_kit", 5],["PartGeneric", 30],["PartPlankPack", 30],["PartPlywoodPack", 30],["PartWoodLumber", 30],["PartWoodPile", 30],["PartWoodPlywood", 30],["rusty_gate_kit", 5],["sandbag_nest_kit", 30],["stick_fence_kit", 5],["storage_shed_kit", 10],["sun_shade_kit", 10],["wooden_shed_kit", 10],["wood_ramp_kit", 10],["wood_shack_kit", 10],["workbench_kit", 5]]
#define SM_CINDER_KIT [["plot_pole_kit", 1],["bulk_ItemTankTrap", 1],["ItemPole", 4],["bulk_ItemWire", 1],["CinderBlocks", 32],["MortarBucket", 8],["cinder_door_kit", 1],["cinder_garage_kit", 1],["full_cinder_wall_kit", 8],["half_cinder_wall_kit", 8],["metal_floor_kit", 8],["ItemComboLock", 2],["bulk_ItemSandbag", 1],["ItemVault", 1],["ItemGunRackKit", 1],["workbench_kit", 1],["ItemWoodCrateKit",1],["ItemFireBarrel_Kit",1],["metal_panel_kit", 8],["ItemCorrugated",8],["ItemMixOil", 1],["ItemJerrycan", 1],["storage_shed_kit", 1],["light_pole_kit", 1]]
#define MD_CINDER_KIT [["plot_pole_kit", 1],["bulk_ItemTankTrap", 2],["ItemPole", 8],["bulk_ItemWire", 2],["CinderBlocks", 64],["MortarBucket", 16],["cinder_door_kit", 2],["cinder_garage_kit", 2],["full_cinder_wall_kit", 16],["half_cinder_wall_kit", 16],["metal_floor_kit", 16],["ItemComboLock", 4],["bulk_ItemSandbag", 2],["ItemVault", 2],["ItemGunRackKit", 2],["workbench_kit", 1],["ItemWoodCrateKit",2],["ItemFireBarrel_Kit",1],["metal_panel_kit", 16],["ItemCorrugated",16],["ItemMixOil", 2],["ItemJerrycan", 1],["storage_shed_kit", 2],["light_pole_kit", 2]]
#define LG_CINDER_KIT [["plot_pole_kit", 1],["bulk_ItemTankTrap", 3],["ItemPole", 12],["bulk_ItemWire", 3],["CinderBlocks", 96],["MortarBucket", 24],["cinder_door_kit", 3],["cinder_garage_kit", 3],["full_cinder_wall_kit", 24],["half_cinder_wall_kit", 24],["metal_floor_kit", 24],["ItemComboLock", 6],["bulk_ItemSandbag", 3],["ItemVault", 3],["ItemGunRackKit", 3],["workbench_kit", 1],["ItemWoodCrateKit",3],["ItemFireBarrel_Kit",1],["metal_panel_kit", 24],["ItemCorrugated",24],["ItemMixOil", 3],["ItemJerrycan", 1],["storage_shed_kit", 3],["light_pole_kit", 3]]
#define SM_WOOD_KIT [["ItemWoodFloor", 4],["ItemWoodFloorHalf", 4],["ItemWoodFloorQuarter", 4],["ItemWoodLadder", 2],["ItemWoodStairs", 2],["ItemWoodWallDoorLg", 1],["ItemWoodWallGarageDoor", 1],["ItemWoodWallLg", 4],["ItemWoodWallThird", 3],["ItemWoodWallWindowLg", 4],["ItemWoodWallwithDoorLg", 1],["ItemComboLock", 2],["ItemLockbox", 1],["ItemGunRackKit", 1],["workbench_kit", 1],["ItemWoodCrateKit",1],["ItemFireBarrel_Kit",1],["ItemMixOil", 1],["ItemJerrycan", 1]]
#define MD_WOOD_KIT [["ItemWoodFloor", 8],["ItemWoodFloorHalf", 8],["ItemWoodFloorQuarter", 8],["ItemWoodLadder", 4],["ItemWoodStairs", 4],["ItemWoodWallDoorLg", 2],["ItemWoodWallGarageDoor", 2],["ItemWoodWallLg", 8],["ItemWoodWallThird", 6],["ItemWoodWallWindowLg", 8],["ItemWoodWallwithDoorLg", 2],["ItemComboLock", 4],["ItemLockbox", 2],["ItemGunRackKit", 2],["workbench_kit", 1],["ItemWoodCrateKit",2],["ItemFireBarrel_Kit",1],["ItemMixOil", 2],["ItemJerrycan", 2]]
#define LG_WOOD_KIT [["ItemWoodFloor", 16],["ItemWoodFloorHalf", 16],["ItemWoodFloorQuarter", 16],["ItemWoodLadder", 6],["ItemWoodStairs", 6],["ItemWoodWallDoorLg", 3],["ItemWoodWallGarageDoor", 3],["ItemWoodWallLg", 16],["ItemWoodWallThird", 12],["ItemWoodWallWindowLg", 16],["ItemWoodWallwithDoorLg", 3],["ItemComboLock", 6],["ItemVault", 1],["ItemGunRackKit", 3],["workbench_kit", 1],["ItemWoodCrateKit",3],["ItemFireBarrel_Kit",1],["ItemMixOil", 3],["ItemJerrycan", 3]]

// Epoch Weapons
#define EPOCH_WEPS ["G36C_DZ","G36C_CCO_DZ","G36C_Holo_DZ","G36C_ACOG_DZ","G36C_SD_DZ","G36C_CCO_SD_DZ","G36C_Holo_SD_DZ","G36C_ACOG_SD_DZ","G36C_camo","G36A_Camo_DZ","G36K_Camo_DZ","G36K_Camo_SD_DZ","M16A2_DZ","M16A2_GL_DZ","M16A4_DZ","M16A4_CCO_DZ","M16A4_Holo_DZ","M16A4_ACOG_DZ","M16A4_GL_DZ","M16A4_FL_DZ","M16A4_MFL_DZ","M16A4_CCO_FL_DZ","M16A4_Holo_FL_DZ","M16A4_ACOG_FL_DZ","M16A4_GL_FL_DZ","M16A4_CCO_MFL_DZ","M16A4_Holo_MFL_DZ","M16A4_ACOG_MFL_DZ","M16A4_GL_MFL_DZ","M16A4_GL_CCO_DZ","M16A4_GL_Holo_DZ","M16A4_GL_ACOG_DZ","M16A4_GL_CCO_FL_DZ","M16A4_GL_Holo_FL_DZ","M16A4_GL_ACOG_FL_DZ","M16A4_GL_CCO_MFL_DZ","M16A4_GL_Holo_MFL_DZ","M16A4_GL_ACOG_MFL_DZ","M4A1_DZ","M4A1_FL_DZ","M4A1_MFL_DZ","M4A1_SD_DZ","M4A1_SD_FL_DZ","M4A1_SD_MFL_DZ","M4A1_CCO_DZ","M4A1_CCO_FL_DZ","M4A1_CCO_MFL_DZ","M4A1_CCO_SD_DZ","M4A1_CCO_SD_FL_DZ","M4A1_CCO_SD_MFL_DZ","M4A1_Holo_DZ","M4A1_Holo_FL_DZ","M4A1_Holo_MFL_DZ","M4A1_Holo_SD_DZ","M4A1_Holo_SD_FL_DZ","M4A1_Holo_SD_MFL_DZ","M4A1_ACOG_DZ","M4A1_ACOG_FL_DZ","M4A1_ACOG_MFL_DZ","M4A1_ACOG_SD_DZ","M4A1_ACOG_SD_FL_DZ","M4A1_ACOG_SD_MFL_DZ","M4A1_GL_DZ","M4A1_GL_FL_DZ","M4A1_GL_MFL_DZ","M4A1_GL_SD_DZ","M4A1_GL_SD_FL_DZ","M4A1_GL_SD_MFL_DZ","M4A1_GL_CCO_DZ","M4A1_GL_CCO_FL_DZ","M4A1_GL_CCO_MFL_DZ","M4A1_GL_CCO_SD_DZ","M4A1_GL_CCO_SD_FL_DZ","M4A1_GL_CCO_SD_MFL_DZ","M4A1_GL_Holo_DZ","M4A1_GL_Holo_FL_DZ","M4A1_GL_Holo_MFL_DZ","M4A1_GL_Holo_SD_DZ","M4A1_GL_Holo_SD_FL_DZ","M4A1_GL_Holo_SD_MFL_DZ","M4A1_GL_ACOG_DZ","M4A1_GL_ACOG_FL_DZ","M4A1_GL_ACOG_MFL_DZ","M4A1_GL_ACOG_SD_DZ","M4A1_GL_ACOG_SD_FL_DZ","M4A1_GL_ACOG_SD_MFL_DZ","M4A1_HWS_GL_camo","M4A1_HWS_GL_SD_Camo","M4A3_CCO_EP1","SCAR_L_CQC","SCAR_L_CQC_CCO_SD","SCAR_L_CQC_Holo","SCAR_L_CQC_EGLM_Holo","SCAR_L_STD_EGLM_RCO","SCAR_L_STD_HOLO","SCAR_L_STD_Mk4CQT","SA58_DZ","SA58_RIS_DZ","SA58_RIS_FL_DZ","SA58_RIS_MFL_DZ","SA58_CCO_DZ","SA58_CCO_FL_DZ","SA58_CCO_MFL_DZ","SA58_Holo_DZ","SA58_Holo_FL_DZ","SA58_Holo_MFL_DZ","SA58_ACOG_DZ","SA58_ACOG_FL_DZ","SA58_ACOG_MFL_DZ","Sa58V_CCO_EP1","Sa58V_RCO_EP1","AKS74U_DZ","AKS74U_Kobra_DZ","AKS74U_SD_DZ","AKS74U_Kobra_SD_DZ","AKM_DZ","AKM_Kobra_DZ","AKM_PSO1_DZ","AK74_DZ","AK74_Kobra_DZ","AK74_PSO1_DZ","AK74_GL_DZ","AK74_SD_DZ","AK74_Kobra_SD_DZ","AK74_PSO1_SD_DZ","AK74_GL_SD_DZ","AK74_GL_Kobra_DZ","AK74_GL_PSO1_DZ","AK74_GL_Kobra_SD_DZ","AK74_GL_PSO1_SD_DZ","FNFAL_DZ","FNFAL_CCO_DZ","FNFAL_Holo_DZ","BAF_L86A2_ACOG","L110A1_DZ","L110A1_CCO_DZ","L110A1_Holo_DZ","M249_DZ","M249_CCO_DZ","M249_Holo_DZ","M240_DZ","M240_CCO_DZ","M240_Holo_DZ","Mk48_DZ","Mk48_CCO_DZ","Mk48_Holo_DZ","RPK_DZ","RPK_Kobra_DZ","RPK_PSO1_DZ","RPK74_DZ","RPK74_Kobra_DZ","RPK74_PSO1_DZ","UK59_DZ","PKM_DZ","Pecheneg_DZ","Crossbow_DZ","Crossbow_CCO_DZ","Crossbow_FL_DZ","Crossbow_MFL_DZ","Crossbow_Scope_DZ","Crossbow_CCO_FL_DZ","Crossbow_Scope_FL_DZ","Crossbow_CCO_MFL_DZ","Crossbow_Scope_MFL_DZ","RedRyder","MR43_DZ","Winchester1866_DZ","M1014_DZ","M1014_CCO_DZ","M1014_Holo_DZ","Remington870_DZ","Remington870_FL_DZ","Remington870_MFL_DZ","LeeEnfield_DZ","Mosin_DZ","Mosin_FL_DZ","Mosin_MFL_DZ","Mosin_Belt_DZ","Mosin_Belt_FL_DZ","Mosin_Belt_MFL_DZ","Mosin_PU_DZ","Mosin_PU_FL_DZ","Mosin_PU_MFL_DZ","Mosin_PU_Belt_DZ","Mosin_PU_Belt_FL_DZ","Mosin_PU_Belt_MFL_DZ","M4SPR","M14_DZ","M14_Gh_DZ","M14_CCO_DZ","M14_Holo_DZ","M14_CCO_Gh_DZ","M14_Holo_Gh_DZ","CZ550_DZ","M24_DZ","M24_Gh_DZ","M24_des_EP1","M40A3_DZ","M40A3_Gh_DZ","SVD_DZ","SVD_Gh_DZ","SVD_PSO1_DZ","SVD_PSO1_Gh_DZ","SVD_des_EP1","Sa61_EP1","PDW_DZ","UZI_SD_EP1","MP5_DZ","MP5_SD_DZ","Bizon_DZ","Bizon_SD_DZ","MeleeBaseBallBat","Saiga12K","AA12_PMC","m8_compact","m8_sharpshooter","m8_holo_sd","m8_carbine","M8_SAW","SCAR_H_CQC_CCO","SCAR_H_CQC_CCO_SD","SCAR_H_STD_EGLM_Spect","MG36","MG36_camo","M249_m145_EP1_DZE","M60A4_EP1_DZE","m240_scoped_EP1_DZE","VSS_vintorez","KSVK_DZE","M9_DZ","M9_SD_DZ","G17_DZ","G17_FL_DZ","G17_MFL_DZ","G17_SD_DZ","G17_SD_FL_DZ","G17_SD_MFL_DZ","Makarov_DZ","Makarov_SD_DZ","Revolver_DZ","revolver_gold_EP1","M1911_DZ","G36_C_SD_camo","M4A1_AIM_SD_camo","FN_FAL_ANPVS4_DZE","SCAR_H_LNG_Sniper","SCAR_H_LNG_Sniper_SD","M110_NVG_EP1","DMR_DZ","DMR_Gh_DZ","BAF_LRR_scoped","BAF_LRR_scoped_W","m107_DZ","Anzio_20_DZ","BAF_AS50_scoped_DZ","L85A2_DZ","L85A2_FL_DZ","L85A2_MFL_DZ","L85A2_SD_DZ","L85A2_SD_FL_DZ","L85A2_SD_MFL_DZ","L85A2_CCO_DZ","L85A2_CCO_FL_DZ","L85A2_CCO_MFL_DZ","L85A2_CCO_SD_DZ","L85A2_CCO_SD_FL_DZ","L85A2_CCO_SD_MFL_DZ","L85A2_Holo_DZ","L85A2_Holo_FL_DZ","L85A2_Holo_MFL_DZ","L85A2_Holo_SD_DZ","L85A2_Holo_SD_FL_DZ","L85A2_Holo_SD_MFL_DZ","L85A2_ACOG_DZ","L85A2_ACOG_FL_DZ","L85A2_ACOG_MFL_DZ","L85A2_ACOG_SD_DZ","L85A2_ACOG_SD_FL_DZ","L85A2_ACOG_SD_MFL_DZ"]
#define EPOCH_MAGS ["2Rnd_12Gauge_Slug","2Rnd_12Gauge_Buck","5Rnd_127x108_KSVK","5Rnd_127x99_as50","5Rnd_762x51_M24","5Rnd_86x70_L115A1","5x_22_LR_17_HMR","6Rnd_45ACP","7Rnd_45ACP_1911","8Rnd_9x18_Makarov","8Rnd_9x18_MakarovSD","8Rnd_B_Beneli_74Slug","8Rnd_B_Beneli_Pellets","8Rnd_B_Saiga12_74Slug","8Rnd_B_Saiga12_Pellets","10Rnd_127x99_M107","3rnd_Anzio_20x102mm","10Rnd_762x54_SVD","10x_303","15Rnd_9x19_M9","15Rnd_9x19_M9SD","15Rnd_W1866_Slug","17Rnd_9x19_glock17","20Rnd_556x45_Stanag","20Rnd_762x51_DMR","20Rnd_762x51_FNFAL","20Rnd_B_765x17_Ball","30Rnd_545x39_AK","30Rnd_545x39_AKSD","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_762x39_AK47","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","30Rnd_9x19_UZI","30Rnd_9x19_UZI_SD","50Rnd_127x108_KORD","64Rnd_9x19_Bizon","64Rnd_9x19_SD_Bizon","75Rnd_545x39_RPK","100Rnd_762x51_M240","100Rnd_762x54_PK","100Rnd_556x45_BetaCMag","100Rnd_556x45_M249","200Rnd_556x45_L110A1","200Rnd_556x45_M249","1Rnd_Bolt_Tranquilizer","1Rnd_Bolt_Explosive","12Rnd_Quiver_Wood","1Rnd_HE_M203","HandGrenade_west","SmokeShell","SmokeShellGreen","SmokeShellRed","PipeBomb"]

// Overwatch Weapons
#define	OW_WEPS ["RH_m9","RH_m9c","RH_m93r","RH_M9sd","RH_m9csd","RH_browninghp","vil_B_HP","RH_anac","RH_anacg","RH_python","RH_deagle","RH_Deagleg","RH_Deaglem","RH_Deaglemzb","RH_Deaglemz","RH_Deagles","vil_Glock","RH_g17","vil_Glock_o","RH_g17sd","RH_g18","RH_g19","RH_g19t","RH_tec9","RH_m1911","RH_m1911sd","RH_m1911old","RH_mk22","RH_mk22sd","RH_mk22v","RH_mk22vsd","RH_p38","RH_ppk","RH_mk2","RH_p226","RH_p226s","RH_bull","RH_tt33","RH_usp","RH_uspm","RH_uspsd","vil_USP45","vil_USP45SD","vil_USP","vil_USPSD","RH_vz61",		"vil_AEK2","vil_AEK_GL","vil_AeK_3","vil_AeK_23","vil_AeK_3_K","vil_AK_105","Vil_AK_105_c","vil_AK_101","vil_AK_103","vil_AK_107","Vil_AK_107_c","vil_ak12","vil_ak12_ap","vil_ak12_gp","vil_AK_47","vil_AK_47_49","vil_AK_47_m1","vil_AK_47","vil_AK_74_N","vil_AK_74P","vil_AK_74m","vil_AK_74m_p29","vil_AK_74m_EOT_Alfa","vil_AK_74m_gp_29","vil_AK_74m_gp","vil_AK_74m_EOT","vil_AK_74m_EOT_FSB","vil_AK_74m_EOT_FSB_60","vil_AK_74m_EOT_FSB_45","vil_AK_74m_c","vil_AK_74m_k","vil_AK_74m_PSO","vil_AKM","vil_AKM_GL","vil_AKMS","vil_AKMS_GP25","vil_AKMSB","vil_AKS_47","vil_AKS_74","vil_AKS_74_gp","vil_AKS_74p_gp","vil_AKS_74p","vil_AKS_74p_45","vil_AKs_74_u","vil_AKs_74_u45","Vil_AKS_74_UB","Vil_AKS_74_UN_kobra","vil_AMD63","vil_AMD","vil_Abakan","vil_Abakan_P29","vil_Abakan_gp","vil_AK_nato_m1","vil_ASH82","vil_MPi","vil_PMI74S","vil_PMI","vil_PMIS","vil_type88_1","vil_M64","vil_M70","vil_M70B","vil_AK_nato_m80",		"vil_Galil","vil_Galil_arm","vil_SKS","gms_k98","gms_k98_knife","gms_k98_rg","gms_k98zf39","FHQ_ACR_BLK_CCO_GL_SD","FHQ_ACR_TAN_CCO_GL_SD","FHQ_ACR_SNW_CCO_GL_SD","FHQ_ACR_WDL_CCO_GL_SD","FHQ_ACR_BLK_CCO_SD","FHQ_ACR_TAN_CCO_SD","FHQ_ACR_SNW_CCO_SD","FHQ_ACR_WDL_CCO_SD","FHQ_ACR_BLK_G33_GL_SD","FHQ_ACR_TAN_G33_GL_SD","FHQ_ACR_SNW_G33_GL_SD","FHQ_ACR_WDL_G33_GL_SD","FHQ_ACR_BLK_G33_SD","FHQ_ACR_TAN_G33_SD","FHQ_ACR_SNW_G33_SD","FHQ_ACR_WDL_G33_SD","FHQ_ACR_BLK_HAMR_GL_SD","FHQ_ACR_TAN_HAMR_GL_SD","FHQ_ACR_SNW_HAMR_GL_SD","FHQ_ACR_WDL_HAMR_GL_SD","FHQ_ACR_BLK_HAMR_SD","FHQ_ACR_TAN_HAMR_SD","FHQ_ACR_SNW_HAMR_SD","FHQ_ACR_WDL_HAMR_SD","FHQ_ACR_BLK_HWS_GL_SD","FHQ_ACR_TAN_HWS_GL_SD","FHQ_ACR_SNW_HWS_GL_SD","FHQ_ACR_WDL_HWS_GL_SD","FHQ_ACR_BLK_HWS_SD","FHQ_ACR_TAN_HWS_SD","FHQ_ACR_SNW_HWS_SD","FHQ_ACR_WDL_HWS_SD","FHQ_ACR_BLK_IRN_GL_SD","FHQ_ACR_TAN_IRN_GL_SD","FHQ_ACR_SNW_IRN_GL_SD","FHQ_ACR_WDL_IRN_GL_SD","FHQ_ACR_BLK_RCO_GL_SD","FHQ_ACR_TAN_RCO_GL_SD","FHQ_ACR_SNW_RCO_GL_SD","FHQ_ACR_WDL_RCO_GL_SD","FHQ_ACR_BLK_RCO_SD","FHQ_ACR_TAN_RCO_SD","FHQ_ACR_SNW_RCO_SD","FHQ_ACR_WDL_RCO_SD","FHQ_ACR_BLK_IRN_SD","FHQ_ACR_TAN_IRN_SD","FHQ_ACR_SNW_IRN_SD","FHQ_ACR_WDL_IRN_SD",		"FHQ_ACR_BLK_IRN","FHQ_ACR_TAN_IRN","FHQ_ACR_SNW_IRN","FHQ_ACR_WDL_IRN","FHQ_ACR_BLK_CCO","FHQ_ACR_TAN_CCO","FHQ_ACR_SNW_CCO","FHQ_ACR_WDL_CCO","FHQ_ACR_BLK_CCO_GL","FHQ_ACR_TAN_CCO_GL","FHQ_ACR_SNW_CCO_GL","FHQ_ACR_WDL_CCO_GL","FHQ_ACR_BLK_G33","FHQ_ACR_TAN_G33","FHQ_ACR_SNW_G33","FHQ_ACR_WDL_G33","FHQ_ACR_BLK_G33_GL","FHQ_ACR_TAN_G33_GL","FHQ_ACR_SNW_G33_GL","FHQ_ACR_WDL_G33_GL","FHQ_ACR_BLK_HAMR","FHQ_ACR_TAN_HAMR","FHQ_ACR_SNW_HAMR","FHQ_ACR_WDL_HAMR","FHQ_ACR_BLK_HAMR_GL","FHQ_ACR_TAN_HAMR_GL","FHQ_ACR_SNW_HAMR_GL","FHQ_ACR_WDL_HAMR_GL","FHQ_ACR_BLK_HWS","FHQ_ACR_TAN_HWS","FHQ_ACR_SNW_HWS","FHQ_ACR_WDL_HWS","FHQ_ACR_BLK_HWS_GL","FHQ_ACR_TAN_HWS_GL","FHQ_ACR_SNW_HWS_GL","FHQ_ACR_WDL_HWS_GL","FHQ_ACR_BLK_IRN_GL","FHQ_ACR_TAN_IRN_GL","FHQ_ACR_SNW_IRN_GL","FHQ_ACR_WDL_IRN_GL","FHQ_ACR_BLK_RCO","FHQ_ACR_TAN_RCO","FHQ_ACR_SNW_RCO","FHQ_ACR_WDL_RCO","FHQ_ACR_BLK_RCO_GL","FHQ_ACR_TAN_RCO_GL","FHQ_ACR_SNW_RCO_GL","FHQ_ACR_WDL_RCO_GL",		"SCAR_L_CQC_CCO_SD","SCAR_L_CQC","SCAR_L_CQC_Holo","SCAR_L_CQC_EGLM_Holo","SCAR_L_STD_EGLM_RCO","SCAR_L_STD_HOLO","SCAR_L_STD_Mk4CQT","SCAR_H_CQC_CCO","SCAR_H_CQC_CCO_SD","SCAR_H_STD_EGLM_Spect","SCAR_H_LNG_Sniper","SCAR_H_LNG_Sniper_SD","vil_9a91","vil_9a91_c","vil_9a91_csd","vil_VAL","vil_VAL_C","vil_Groza_HG","vil_Groza_GL","vil_Groza_SC","vil_Groza_SD","vil_Vikhr","vil_vsk94","vil_MP5_EOTech","vil_MP5SD_EOTech","vil_uzimini","vil_uzimini_SD","vil_uzi","vil_uzi_c","vil_uzi_SD",		"USSR_cheytacM200","USSR_cheytacM200_sd","vil_SVD_63","vil_SVD_N","vil_SVD_M","vil_SVD_P21","vil_SVD_S","FHQ_MSR_DESERT","FHQ_MSR_NV_DESERT","FHQ_MSR_NV_SD_DESERT","FHQ_MSR_SD_DESERT","FHQ_RSASS_TAN","FHQ_RSASS_SD_TAN","vil_SV_98_69","vil_SV_98","vil_SV_98_SD","vil_SVDK","FHQ_XM2010_DESERT","FHQ_XM2010_NV_DESERT","FHQ_XM2010_NV_SD_DESERT","FHQ_XM2010_SD_DESERT","RH_ctar21","RH_ctar21glacog","RH_ctar21m","RH_ctar21mgl","RH_star21","vil_AG3","vil_G3a2","vil_G3a3","vil_G3an","vil_G3anb","vil_G3SG1","vil_G3sg1b","vil_G3TGS","vil_G3TGSb","vil_G3ZF","vil_G3zfb","vil_G3a4","vil_G3a4b","RH_masacog","RH_masaim","RH_masbaim","RH_masb","RH_masbeotech","RH_mas","RH_massd","RH_massdacog","RH_masbsdacog","RH_massdaim","RH_masbsdaim","RH_masbsd","RH_massdeotech","RH_masbsdeotech","vil_RPK75_Romania","vil_M240_B","vil_M249_Para","skavil_M60","skavil_M60e3","vil_Mg3","vil_MG4","vil_MG4E","vil_PKP","vil_PKP_EOT","vil_PK","vil_PKM","vil_RPD","vil_RPK","vil_RPK75","vil_RPK74","vil_RPK74M","vil_RPK74M_P29","vil_RPK75_M72","vil_zastava_m84","RH_hk417","RH_hk417acog","RH_hk417aim","RH_hk417s","RH_hk417sacog","RH_hk417saim","RH_hk417seotech","RH_hk417eotech","RH_hk417sd","RH_hk417sdacog","RH_hk417sdaim","RH_hk417sdeotech","RH_hk417sdsp","RH_hk417sp","RH_hk417sglacog","RH_hk417sgl","RH_hk417sglaim","RH_hk417sgleotech",		"RH_hk416","RH_hk416glacog","RH_hk416gl","RH_hk416aim","RH_hk416glaim","RH_hk416s","RH_hk416sacog","RH_hk416sglacog","RH_hk416saim","RH_hk416sglaim","RH_hk416seotech","RH_hk416sgleotech","RH_hk416sgl","RH_hk416eotech","RH_hk416gleotech","RH_hk416sd","RH_hk416sdgl","RH_hk416sdglaim","RH_hk416sdeotech","RH_hk416sdgleotech","vil_AG36KA4","vil_AG36KV","vil_G36KSKdes","vil_G36KA4","vil_G36KSKES","vil_G36KSKdesES","vil_G36KES","vil_G36KVZ","vil_G36KSK","vil_G36VA4Eot","vil_G36KV3","vil_G36KVA4","vil_G36KV3Des","vil_G36VA4","vil_AG36","vil_G36a2","vil_AG36A2","vil_G36CC","vil_G36E"]
#define OW_MAGS [["vil_usp45_mag",20],["vil_bhp_mag",20],["RH_10Rnd_22LR_mk2",20],["RH_12Rnd_45cal_usp",20],["RH_13Rnd_9x19_bhp",20],["RH_15Rnd_9x19_usp",20],["RH_17Rnd_9x19_g17",20],["RH_19Rnd_9x19_g18",20],["RH_20Rnd_32cal_vz61",20],["RH_20Rnd_9x19_M93",20],["RH_30Rnd_9x19_tec",20],["RH_6Rnd_357_Mag",20],["RH_6Rnd_44_Mag",20],["RH_7Rnd_32cal_ppk",20],["RH_7Rnd_50_AE",20],["RH_8Rnd_45cal_m1911",20],["RH_8Rnd_762_tt33",20],["RH_8Rnd_9x19_Mk",20],["RH_8Rnd_9x19_P38",20],["vil_usp45sd_mag",20],["RH_15Rnd_9x19_uspsd",20],["RH_17Rnd_9x19_g17SD",20],["RH_8Rnd_9x19_Mksd",20],["vil_32Rnd_uzi",20],["vil_32Rnd_UZI_SD",20],["RH_32Rnd_9x19_Muzi",20],["vil_20Rnd_9x39_SP6_VAL",20],["vil_20Rnd_9x39_SP6ns_OC",20],["vil_20Rnd_9x39_SP6_OC",20],["vil_40Rnd_762x39_AK47",50],["vil_60Rnd_545x39_AK",50],["vil_30Rnd_762x39_AKSD",20],["VIL_30Rnd_556x45_AK",20],["vil_20Rnd_762x51_G3",30],["RH_20Rnd_762x51_hk417",30],["RH_20Rnd_762x51_SD_hk417",30],["FHQ_rem_30Rnd_680x43_ACR",50],["FHQ_rem_30Rnd_680x43_ACR_SD",50],["5x_22_LR_17_HMR",20],["USSR_5Rnd_408",20],["FHQ_rem_5Rnd_300Win_XM2010_NT",20],["FHQ_rem_5Rnd_300Win_XM2010_NT_SD",20],["FHQ_rem_7Rnd_338Lapua_MSR_NT_SD",20],["FHQ_rem_7Rnd_338Lapua_MSR_NT",20],["vil_10Rnd_762x54_SV",30],["vil_10Rnd_SVDK",20],["FHQ_rem_20Rnd_762x51_PMAG_NT",20],["FHQ_rem_20Rnd_762x51_PMAG_NT_SD",20],["200Rnd_556x45_M249",40],["100Rnd_762x51_M240",40],["100Rnd_762x54_PK",30],["gms_k98_mag",30],["vil_10Rnd_762x39_SKS",20],["30Rnd_556x45_Stanag",50],["30Rnd_556x45_StanagSD",50],["30Rnd_556x45_G36",30],["30Rnd_556x45_G36SD",30],["20rnd_762x51_B_SCAR",20],["20Rnd_762x51_SB_SCAR",20]]


//_activatingPlayer = _this select 0;
//_params = _this select 1;
//_clientKey = _this select 2;
_selectDelay = _params select 0;
_crate = _params select 1;
_dir = _params select 2;
_pos = _params select 3;
//_playerUID = getPlayerUID _activatingPlayer;
_spawnCrate = "";


_exitReason = [_this,"EAT_crateSpawn",(_worldspace select 1),_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
if (_exitReason != "") exitWith {diag_log _exitReason};

call
{
	if (_crate == "AllWeapons") exitWith {
		if (isNil "EAT_weapons_list") then
		{
			EAT_weapons_list = [];
			_cfgweapons = configFile >> 'cfgWeapons';
			for "_i" from 0 to (count _cfgweapons)-1 do
			{
				_weapon = _cfgweapons select _i;
				if (isClass _weapon) then
				{
					_key_colors = ["ItemKeyYellow","ItemKeyBlue","ItemKeyRed","ItemKeyGreen","ItemKeyBlack"];
					if (getNumber (_weapon >> "scope") == 2 and getText(_weapon >> "picture") != "" and !(configName(inheritsFrom(_weapon)) in _key_colors)) then
					{
						_wpn_type = configName _weapon;
						EAT_weapons_list set [count EAT_weapons_list, _wpn_type];
					};
				};
			};
		};
		if (isNil "EAT_magazines_list") then
		{
			EAT_magazines_list = [];
			_cfgmagazines = configFile >> 'cfgMagazines';
			for "_i" from 0 to (count _cfgmagazines)-1 do
			{
				_magazine = _cfgmagazines select _i;
				if (isClass _magazine) then
				{
					if (getNumber (_magazine >> "scope") == 2 and getText(_magazine >> "picture") != "") then
					{
						_mag_type = configName _magazine;
						EAT_magazines_list set [count EAT_magazines_list, _mag_type];
					};
				};
			};
		};
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		if (EAT_isOverpoch) then {
			{
				if(_x != "MeleeBaseBallBat") then{
				_spawnCrate addWeaponCargoGlobal [_x, 1];
				};
			} forEach EAT_weapons_list;
			{
				if(_x != "AngelCookies") then{
					_spawnCrate addMagazineCargoGlobal [_x, 20];
				};
			} forEach EAT_magazines_list;
		} else {
			{
				if(_x != "MeleeBaseBallBat") then{
				_spawnCrate addWeaponCargoGlobal [_x, 1];
				};
			} forEach EAT_weapons_list;
			{
				if(_x != "AngelCookies") then{
					_spawnCrate addMagazineCargoGlobal [_x, 20];
				};
			} forEach EAT_magazines_list;
		};
	};
	if (_crate == "Backpack") exitWith {
		_classname = "TentStorage";
		CRATE_SETUP
		// Add gear
		{_spawnCrate addBackpackCargoGlobal [_x, 1];} forEach BACKPACKS;
	};
	if (_crate == "AllItemsBuilding") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_5X BUILDING_TOOLS;
		ADD ADMIN_BUILD_CRATE;
		ADD_BACKPACK
	};
	if (_crate == "smallCinderBuildingKit") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_1X BUILDING_TOOLS;
		ADD SM_CINDER_KIT;
		ADD_BACKPACK
	};
	if (_crate == "mediumCinderBuildingKit") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_1X BUILDING_TOOLS;
		ADD MD_CINDER_KIT;
		ADD_BACKPACK
	};
	if (_crate == "largeCinderBuildingKit") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_1X BUILDING_TOOLS;
		ADD LG_CINDER_KIT;
		ADD_BACKPACK
	};
	if (_crate == "smallWoodBuildingKit") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_1X BUILDING_TOOLS;
		ADD SM_WOOD_KIT;
		ADD_BACKPACK
	};
	if (_crate == "mediumWoodBuildingKit") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_1X BUILDING_TOOLS;
		ADD MD_WOOD_KIT;
		ADD_BACKPACK
	};
	if (_crate == "largeWoodBuildingKit") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_1X BUILDING_TOOLS;
		ADD LG_WOOD_KIT;
		ADD_BACKPACK
	};
	if (_crate == "Items") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_5X TOOLBELT;
		{_spawnCrate addMagazineCargoGlobal [_x, 10];} forEach CRATE_ITEMS;
		ADD_BACKPACK
	};
	if (_crate == "EpochWeapons") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_5X EPOCH_WEPS;
		{_spawnCrate addMagazineCargoGlobal [_x, 20];} forEach EPOCH_MAGS;
		ADD_BACKPACK
	};
	if (_crate == "OverwatchWeapons") exitWith {
		_classname = "USOrdnanceBox";
		CRATE_SETUP
		// Add gear
		ADD_1X OW_WEPS;
		ADD OW_MAGS;
		ADD_BACKPACK
	};
};

if (_selectDelay != 0) exitWith {
	[_selectDelay,_spawnCrate] spawn {
		
		uiSleep (_this select 0);
		deleteVehicle (_this select 1);
	};
};