/************** Epoch Admin Tools Variables **************/
	
//Enable/Disable weather/time change menu. This may cause server to revert to mid-day on restart.
EAT_wtChanger = true;

// Change the maximum build distance for placable base items
DZE_buildMaxMoveDistance = 20;

//This creates a log in your server\EpochAdminToolLogs\toolUsageLog.txt REQUIRES: EATadminLogger.dll
EAT_logMajorTool = true; //A major tool is a strong tool with high possibility for exploitation
EAT_logMinorTool = true;//A minor tool is a weak tool with low possibility for exploitation

/************** Admin/Mod mode Variables **************/
	
// Defines the default on and off for admin/mod mode options
// ALL items can be turned on or off during gameplay, these are just defaults
EAT_playerGod = true;
EAT_vehicleGod = false;
EAT_playerESPMode = true;
EAT_enhancedESPMode = false;
EAT_grassOff = true;
EAT_infAmmo = true;
EAT_speedBoost = false;
EAT_fastWalk = true;
EAT_fastUp = true;
EAT_invisibility = false;
EAT_flyingMode = false;
EAT_adminBuildMode = false;
EAT_ZombieShield = false;

EAT_isOverpoch = isClass (configFile >> "CfgWeapons" >> "USSR_cheytacM200"); // Used to detect the Overwatch Mod for crate spawning

// These arrays are used in the "Epoch Only" vehicle spawner. By default, they are comprised of all of the vehicles available at the traders, but they can be altered if desired.
EAT_EpochAirVehicles = ["GNT_C185U_DZ","GNT_C185_DZ","GNT_C185R_DZ","GNT_C185C_DZ","AN2_DZ","AN2_2_DZ","An2_2_TK_CIV_EP1_DZ","C130J_US_EP1_DZ","MV22_DZ","CSJ_GyroC_DZE","CSJ_GyroCover","CSJ_GyroP","AH6X_DZ","MH6J_DZ","MTVR_Bird_DZE","pook_H13_civ_DZE","pook_H13_civ_white_DZE","pook_H13_civ_slate_DZE","pook_H13_civ_black_DZE","pook_H13_civ_yellow_DZE","pook_medevac_DZE","pook_medevac_CDF_DZE","pook_medevac_CIV_DZE","Mi17_Civilian_DZ","Mi17_medevac_CDF_DZ","Mi17_medevac_Ins_DZ","Mi17_medevac_RU_DZ","UH60M_MEV_EP1_DZ","BAF_Merlin_DZE","CH53_DZE","pook_transport_DZE","pook_transport_CDF_DZE","pook_gunship_DZE","pook_gunship_CDF_DZE","AH6J_EP1_DZE","UH1H_DZE","UH1H_CDF_DZE","UH1H_WD_DZE","UH1H_2_DZE","UH1H_DES_DZE","UH1H_GREY_DZE","UH1H_BLACK_DZE","UH1H_SAR_DZE","Mi17_DZE","Mi17_TK_EP1_DZE","Mi17_UN_CDF_EP1_DZE","Mi17_CDF_DZE","Mi17_DES_DZE","Mi17_GREEN_DZE","Mi17_BLUE_DZE","Mi17_BLACK_DZE","Mi171Sh_CZ_EP1_DZE","MH60S_DZE","Ka60_GL_PMC_DZE","AW159_Lynx_BAF_DZE","UH60M_EP1_DZE","UH1Y_DZE","CH_47F_EP1_DZE","CH_47F_EP1_Black_DZE","CH_47F_EP1_GREY_DZE","CH_47F_EP1_DES_DZE"];
EAT_EpochLandVehicles = ["MMT_Civ_DZE","Old_bike_TK_CIV_EP1_DZE","Old_moto_TK_Civ_EP1_DZE","M1030_US_DES_EP1_DZE","TT650_Civ_DZE","TT650_Ins_DZE","TT650_TK_CIV_EP1_DZE","ATV_CZ_EP1_DZE","ATV_CIV_CP_DZE","ATV_CIV_Grey_CP_DZE","ATV_CIV_Red_CP_DZE","ATV_CIV_Green_CP_DZE","BAF_ATV_W_DZE","ATV_CIV_Blue_CP_DZE","ATV_CIV_Yellow_CP_DZE","ATV_CIV_Purple_CP_DZE","ATV_CIV_Black_CP_DZE","Octavia_ACR_DZE","Skoda_DZE","SkodaBlue_DZE","SkodaGreen_DZE","SkodaRed_DZE","VolhaLimo_TK_CIV_EP1_DZE","Volha_1_TK_CIV_EP1_DZE","Volha_2_TK_CIV_EP1_DZE","VWGolf_DZE","Mini_Cooper_DZE","car_hatchback_DZE","car_hatchback_red_DZE","car_sedan_DZE","GLT_M300_ST_DZE","GLT_M300_LT_DZE","Lada1_DZE","Lada1_TK_CIV_EP1_DZE","Lada2_DZE","Lada2_TK_CIV_EP1_DZE","LadaLM_DZE","datsun1_civil_3_open_DZE","datsun1_civil_1_open_DZE","datsun1_green_open_DZE","datsun1_civil_2_covered_DZE","datsun1_red_covered_DZE","hilux1_civil_1_open_DZE","hilux1_civil_3_open_DZE","hilux1_civil_2_covered_DZE","UAZ_CDF_DZE","UAZ_INS_DZE","UAZ_RU_DZE","UAZ_Unarmed_TK_CIV_EP1_DZE","UAZ_Unarmed_TK_EP1_DZE","UAZ_Unarmed_UN_EP1_DZE","SUV_TK_CIV_EP1_DZE","SUV_Blue","SUV_Charcoal","SUV_Green","SUV_Orange","SUV_Pink","SUV_Red","SUV_Silver","SUV_White","SUV_Yellow","SUV_Camo","Nissan_Orange_DZE","Nissan_Blue_DZE","Nissan_Mod_DZE","Nissan_Gold_DZE","Nissan_Green_DZE","Nissan_Black_DZE","Nissan_Pink_DZE","Nissan_Red_DZE","Nissan_Ruben_DZE","Nissan_V_DZE","Nissan_Yellow_DZE","Ural_INS_DZE","Ural_CDF_DZE","UralOpen_CDF_DZE","Ural_TK_CIV_EP1_DZE","Ural_UN_EP1_DZE","UralCivil_DZE","UralCivil2_DZE","UralSupply_TK_EP1_DZE","UralReammo_CDF_DZE","UralReammo_INS_DZE","UralRepair_CDF_DZE","UralRepair_INS_DZE","V3S_Open_TK_CIV_EP1_DZE","V3S_Open_TK_EP1_DZE","V3S_Civ_DZE","V3S_TK_EP1_DZE","V3S_Camper_DZE","V3S_RA_TK_GUE_EP1_DZE","Kamaz_DZE","KamazOpen_DZE","KamazRepair_DZE","KamazReammo_DZE","MTVR_DES_EP1_DZE","MTVR_DZE","MTVR_Open_DZE","MtvrRepair_DZE","MtvrReammo_DZE","T810A_ACR_DZE","T810A_ACR_DES_DZE","T810A_ACR_OPEN_DZE","T810A_ACR_DES_OPEN_DZE","T810_ACR_REAMMO_DZE","T810_ACR_REAMMO_DES_DZE","T810_ACR_REPAIR_DZE","T810_ACR_REPAIR_DES_DZE","UralRefuel_TK_EP1_DZ","UralRefuel_INS_DZE","UralRefuel_CDF_DZE","V3S_Refuel_TK_GUE_EP1_DZ","KamazRefuel_DZ","MtvrRefuel_DES_EP1_DZ","MtvrRefuel_DZ","T810A_ACR_REFUEL_DZE","T810A_ACR_REFUEL_DES_DZE","Jeep_DZE","LandRover_CZ_EP1_DZE","LandRover_TK_CIV_EP1_DZE","LandRover_ACR_DZE","BAF_Offroad_D_DZE","BAF_Offroad_W_DZE","LandRover_Ambulance_ACR_DZE","LandRover_Ambulance_Des_ACR_DZE","BTR40_TK_INS_EP1_DZE","BTR40_TK_GUE_EP1_DZE","GAZ_Vodnik_MedEvac_DZE","HMMWV_M1035_DES_EP1_DZE","HMMWV_Ambulance_DZE","HMMWV_Ambulance_CZ_DES_EP1_DZE","HMMWV_DES_EP1_DZE","HMMWV_DZ","Hummer_DZE","Ikarus_DZE","Ikarus_TK_CIV_EP1_DZE","Ikarus_White_DZE","Ikarus_Armored_DZE","S1203_TK_CIV_EP1_DZE","S1203_ambulance_EP1_DZE","Tractor_DZE","TractorOld_DZE","Tractor_Armored_DZE","ScrapAPC_DZE","Pickup_PK_TK_GUE_EP1_DZE","Pickup_PK_GUE_DZE","Pickup_PK_GUE_DZ","Pickup_PK_INS_DZE","Pickup_PK_INS_DZ","Offroad_DSHKM_Gue_DZE","ArmoredSUV_PMC_DZE","LandRover_MG_TK_EP1_DZE","LandRover_Special_CZ_EP1_DZE","UAZ_MG_TK_EP1_DZE","UAZ_MG_CDF_DZE","UAZ_MG_INS_DZE","UAZ_AGS30_CDF_DZE","UAZ_AGS30_INS_DZE","UAZ_AGS30_TK_EP1_DZE","UAZ_AGS30_RU_DZE","UAZ_AGS30_RUST_DZE","UAZ_AGS30_WINTER_DZE","BAF_Jackal2_L2A1_D_DZE","BAF_Jackal2_L2A1_W_DZE","BAF_Jackal2_GMG_D_DZE","BAF_Jackal2_GMG_W_DZE","BTR40_MG_TK_GUE_EP1_DZE","BTR40_MG_TK_INS_EP1_DZE","GAZ_Vodnik_DZE","BRDM2_HQ_TK_GUE_EP1_DZE","BRDM2_HQ_CDF_DZE","HMMWV_Armored_DZE","HMMWV_M2_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","HMMWV_MK19_DZE","HMMWV_DES_MK19_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE","T810A_PKT_ACR_DZE","T810A_PKT_DES_ACR_DZE"];
EAT_EpochMarineVehicles = ["RHIB_DZE","RHIB2Turret_DZE","Submarine_DZE","Smallboat_1_DZE","Smallboat_2_DZE","Fishing_Boat_DZE","PBX_DZE","Zodiac_DZE","JetSkiYanahui_Case_Red","JetSkiYanahui_Case_Yellow","JetSkiYanahui_Case_Green","JetSkiYanahui_Case_Blue"];

// This section defines all of the buildings in the building GUI
// Format: variable = [["TYPE","NAME","BUILING_CLASS"],["TYPE","NAME","BUILING_CLASS"]];

// Epoch Modular Buildables
EAT_buildCinder = [["Cinder","1/2 Wall","CinderWallHalf_DZ"],["Cinder","1/2 Wall w/ Gap","CinderWallHalf_Gap_DZ"],["Cinder","Full Wall","CinderWall_DZ"],["Cinder","Full Wall w/ Window","CinderWallWindow_DZ"],["Cinder","Garage Doorway","CinderWallDoorway_DZ"],["Cinder","Garage Doorway Open Top","CinderGarageOpenTopFrame_DZ"],["Cinder","Doorway","CinderWallSmallDoorway_DZ"],["Cinder","Doorway w/ Hatch","CinderDoorHatch_DZ"],["Cinder","Tall Gate","CinderGateFrame_DZ"],["Cinder","Bunker","Concrete_Bunker_DZ"]];
EAT_buildWood = [["Wood","Ramp","WoodRamp_DZ"],["Wood","Floor w/ Stairs","WoodFloorStairs_DZ"],["Wood","4X Floor","WoodFloor4x_DZ"],["Wood","Wood Floor","WoodFloor_DZ"],["Wood","1/2 Floor","WoodFloorHalf_DZ"],["Wood","1/4 Floor","WoodFloorQuarter_DZ"],["Wood","Triangle Floor","WoodTriangleFloor_DZ"],["Wood","Large Wall","WoodLargeWall_DZ"],["Wood","Large Doorway","WoodLargeWallDoor_DZ"],["Wood","Large Wall w/Window","WoodLargeWallWin_DZ"],["Wood","Garage Frame","Land_DZE_GarageWoodDoor"],["Wood","Open Top Garage","Land_DZE_WoodOpenTopGarageDoor"],["Wood","Wood Gate Frame","WoodGateFrame_DZ"],["Wood","Wood Gate","Land_DZE_WoodGate"],["Wood","Wall","WoodSmallWall_DZ"],["Wood","1/3 Wall","WoodSmallWallThird_DZ"],["Wood","Triangle Wall","WoodTriangleWall_DZ"],["Wood","Wall w/Window","WoodSmallWallWin_DZ"],["Wood","Doorway","WoodSmallWallDoor_DZ"],["Wood","Stairs","WoodStairsSans_DZ"],["Wood","Stairs w/Stilts","WoodStairs_DZ"],["Wood","Stairs w/Rails","WoodStairsRails_DZ"],["Wood","Ladder","WoodLadder_DZ"],["Wood","Handrail","WoodHandrail_DZ"],["Wood","Pillar","WoodPillar_DZ"],["Wood","Door Frame","DoorFrame_DZ"],["Wood","Frame w/ Door","Door_DZ"]];
EAT_buildMetal = [["Metal","Panel","MetalPanel_DZ"],["Metal","4X Floor","MetalFloor4x_DZ"],["Metal","Floor","MetalFloor_DZ"],["Metal","1/2 Floor","MetalFloor_Half_DZ"],["Metal","1/4 Floor","MetalFloor_Quarter_DZ"],["Metal","Glass Floor","GlassFloor_DZ"],["Metal","1/2 Glass Floor","GlassFloor_Half_DZ"],["Metal","1/4 Glass Floor","GlassFloor_Quarter_DZ"],["Metal","Pillar","MetalPillar_DZ"],["Metal","Corrugated Fence","Fence_corrugated_DZ"],["Metal","Tank Trap","Hedgehog_DZ"],["Metal","Wire Fence","Fort_RazorWire"],["Metal","Metal Gate","MetalGate_DZ"],["Metal","Drawbridge","Metal_Drawbridge_DZ"]];
EAT_buildNets = [["Camo Net","Desert","DesertCamoNet_DZ"],["Camo Net","Forest","ForestCamoNet_DZ"],["Camo Net","Winter","WinterCamoNet_DZ"],["Camo Net","Large Desert","DesertLargeCamoNet_DZ"],["Camo Net","Large Forest","ForestLargeCamoNet_DZ"],["Camo Net","Large Winter","WinterLargeCamoNet_DZ"]];
EAT_buildStorage = [["Storage","Large Storage Shed","StorageShed_DZ"],["Storage","Upgraded Large Storage Shed","StorageShed2_DZ"],["Storage","Gun Rack","GunRack_DZ"],["Storage","Upgraded Gun Rack","GunRack2_DZ"],["Storage","Wood Crate","WoodCrate_DZ"],["Storage","Upgraded Wood Crate","WoodCrate2_DZ"],["Storage","Wood Shack","WoodShack_DZ"],["Storage","Upgraded Wood Shack","WoodShack2_DZ"],["Storage","Fancy Wood Shed","Wooden_shed_DZ"],["Storage","Upgraded Fancy Wood Shed","Wooden_shed2_DZ"],["Storage","Safe","VaultStorageLocked"],["Storage","Upgraded Safe","VaultStorage2Locked"],["Storage","Tall Safe","TallSafeLocked"],["Storage","Lockbox","LockboxStorageLocked"],["Storage","Upgraded Lockbox","LockboxStorage2Locked"],["Storage","Winter Lockbox","LockboxStorageWinterLocked"],["Storage","Upgraded Winter Lockbox","LockboxStorageWinter2Locked"]];
EAT_buildSandbags = [["SandBags","Sandbag Fence","Sandbag1_DZ"],["SandBags","Sandbag Fence (round)","BagFenceRound_DZ"],["SandBags","H-barrier Cube","Land_HBarrier1_DZ"],["SandBags","H-barrier (short)","Land_HBarrier3_DZ"],["SandBags","H-barrier (long)","Land_HBarrier5_DZ"],["SandBags","H-barrier (extra large)","Base_WarfareBBarrier10xTall"],["SandBags","Sandbag Nest","SandNest_DZ"]];
EAT_buildMisc = [["Misc","Workbench","WorkBench_DZ"],["Misc","Advanced Workbench","Advanced_WorkBench_DZ"],["Misc","Outhouse","OutHouse_DZ"],["Misc","Fuel Pump","FuelPump_DZ"],["Misc","Light Pole","LightPole_DZ"],["Misc","Generator","Generator_DZ"],["Misc","Plot Pole","Plastic_Pole_EP1_DZ"],["Misc","Canvas Hut","CanvasHut_DZ"],["Misc","Park Bench","ParkBench_DZ"],["Misc","Stick Fence","StickFence_DZ"],["Misc","Deer Stand","DeerStand_DZ"],["Misc","Scaffolding","Scaffolding_DZ"],["Misc","Fire Barrel","FireBarrel_DZ"],["Misc","Machine Gun Nest","M240Nest_DZ"],["Misc","Cooking Tripod","CookTripod_DZ"],["Misc","Stone Oven","Stoneoven_DZ"],["Misc","Toilet","Commode_DZ"],["Misc","Wardrobe","Wardrobe_DZ"],["Misc","Fridge","Fridge_DZ"],["Misc","Washing Machine","Washing_Machine_DZ"],["Misc","Server Rack","Server_Rack_DZ"],["Misc","ATM","ATM_DZ"],["Misc","Armchair","Armchair_DZ"],["Misc","Sofa","Sofa_DZ"],["Misc","Arcade Game","Arcade_DZ"],["Misc","Vending Machine","Vendmachine1_DZ"],["Misc","Vending Machine","Vendmachine2_DZ"],["Misc","Storage Crate","StorageCrate_DZ"],["Misc","Camo Storage Crate","CamoStorageCrate_DZ"],["Misc","Water Pump","Water_Pump_DZ"],["Misc","Greenhouse","Greenhouse_DZ"],["Misc","Bed","Bed_DZ"],["Misc","Table","Table_DZ"],["Misc","Office Chair","Office_Chair_DZ"],["Misc","Green Garage","Garage_Green_DZ"],["Misc","White Garage","Garage_White_DZ"],["Misc","Brown Garage","Garage_Brown_DZ"],["Misc","Grey Garage","Garage_Grey_DZ"],["Misc","Civilian Helipad","Helipad_Civil_DZ"]];
EAT_allBuildingList = EAT_buildCinder + EAT_buildWood + EAT_buildMetal + EAT_buildNets + EAT_buildStorage + EAT_buildSandbags + EAT_buildMisc;

diag_log("Admin Tools: config.sqf loaded");
