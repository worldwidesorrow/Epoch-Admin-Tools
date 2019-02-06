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
EAT_epochairvehicles = ["Mi17_DZE","UH1H_DZE","UH1Y_DZE","UH60M_EP1_DZE","MH60S_DZE","CH_47F_EP1_DZE","CH53_DZE","CSJ_GyroC","CSJ_GyroCover","CSJ_GyroP","AH6X_DZ","MH6J_DZ","UH60M_MEV_EP1_DZ","Mi17_Civilian_DZ","BAF_Merlin_DZE","GNT_C185U_DZ","GNT_C185_DZ","GNT_C185R_DZ","GNT_C185C_DZ","AN2_DZ","AN2_2_DZ","An2_2_TK_CIV_EP1_DZ","MV22_DZ","C130J_US_EP1_DZ"];
EAT_epochlandvehicles = ["LandRover_MG_TK_EP1_DZE","LandRover_Special_CZ_EP1_DZE","UAZ_MG_TK_EP1_DZE","GAZ_Vodnik_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE","Pickup_PK_TK_GUE_EP1_DZE","Pickup_PK_GUE_DZE","Pickup_PK_INS_DZE","Offroad_DSHKM_Gue_DZE","ArmoredSUV_PMC_DZE","LandRover_CZ_EP1","LandRover_TK_CIV_EP1","HMMWV_M1035_DES_EP1","HMMWV_Ambulance","HMMWV_Ambulance_CZ_DES_EP1","HMMWV_DES_EP1","HMMWV_DZ","BTR40_TK_INS_EP1","GAZ_Vodnik_MedEvac","MMT_Civ","Old_bike_TK_INS_EP1","TT650_Civ","TT650_Ins","TT650_TK_CIV_EP1","ATV_CZ_EP1","ATV_US_EP1","M1030_US_DES_EP1","Old_moto_TK_Civ_EP1","tractor","Ikarus","Ikarus_TK_CIV_EP1","S1203_TK_CIV_EP1","S1203_ambulance_EP1","Ural_CDF","Ural_TK_CIV_EP1","Ural_UN_EP1","UralCivil_DZE","UralCivil2_DZE","V3S_Open_TK_CIV_EP1","V3S_Open_TK_EP1","V3S_Civ","V3S_RA_TK_GUE_EP1_DZE","V3S_TK_EP1_DZE","Kamaz_DZE","KamazOpen_DZE","MTVR_DES_EP1","MTVR","UralRefuel_TK_EP1_DZ","V3S_Refuel_TK_GUE_EP1_DZ","KamazRefuel_DZ","MtvrRefuel_DES_EP1_DZ","MtvrRefuel_DZ","hilux1_civil_3_open_DZE","datsun1_civil_3_open_DZE","hilux1_civil_1_open_DZE","datsun1_civil_2_covered_DZE","datsun1_civil_1_open_DZE","hilux1_civil_2_covered_DZE","Skoda","SkodaBlue","SkodaGreen","SkodaRed","VolhaLimo_TK_CIV_EP1","Volha_1_TK_CIV_EP1","Volha_2_TK_CIV_EP1","VWGolf","car_hatchback","car_sedan","GLT_M300_LT","GLT_M300_ST","Lada1","Lada1_TK_CIV_EP1","Lada2","Lada2_TK_CIV_EP1","LadaLM","SUV_TK_CIV_EP1","SUV_Blue","SUV_Charcoal","SUV_Green","SUV_Orange","SUV_Pink","SUV_Red","SUV_Silver","SUV_White","SUV_Yellow","SUV_Camo","UAZ_CDF","UAZ_INS","UAZ_RU","UAZ_Unarmed_TK_CIV_EP1","UAZ_Unarmed_TK_EP1","UAZ_Unarmed_UN_EP1"];
EAT_epochmarinevehicles = ["RHIB","Smallboat_1","Smallboat_2","Zodiac","Fishing_Boat","PBX","JetSkiYanahui_Case_Red","JetSkiYanahui_Case_Yellow","JetSkiYanahui_Case_Green","JetSkiYanahui_Case_Blue"];

// This section defines all of the buildings in the building GUI
// Format: variable = [["TYPE","NAME","BUILING_CLASS"],["TYPE","NAME","BUILING_CLASS"]];

// Epoch Modular Buildables
EAT_buildCinder = [["Cinder","1/2 Wall","CinderWallHalf_DZ"],["Cinder","Full Wall","CinderWall_DZ"],["Cinder","Garage Doorway","CinderWallDoorway_DZ"],["Cinder","Doorway","CinderWallSmallDoorway_DZ"]];
EAT_buildWood = [["Wood","Ramp","WoodRamp_DZ"],["Wood","Wood Floor","WoodFloor_DZ"],["Wood","1/2 Floor","WoodFloorHalf_DZ"],["Wood","1/4 Floor","WoodFloorQuarter_DZ"],["Wood","Large Wall","WoodLargeWall_DZ"],["Wood","Large Doorway","WoodLargeWallDoor_DZ"],["Wood","Large Wall w/Window","WoodLargeWallWin_DZ"],["Wood","Wall","WoodSmallWall_DZ"],["Wood","1/3 Wall","WoodSmallWallThird_DZ"],["Wood","Wall w/Window","WoodSmallWallWin_DZ"],["Wood","Doorway","WoodSmallWallDoor_DZ"],["Wood","Stairs","WoodStairsSans_DZ"],["Wood","Stairs w/Stilts","WoodStairs_DZ"],["Wood","Stairs w/Rails","WoodStairsRails_DZ"],["Wood","Ladder","WoodLadder_DZ"]];
EAT_buildMetal = [["Metal","Panel","MetalPanel_DZ"],["Metal","Floor","MetalFloor_DZ"],["Metal","Corrugated Fence","Fence_corrugated_DZ"],["Metal","Tank Trap","Hedgehog_DZ"],["Metal","Wire Fence","Fort_RazorWire"],["Metal","Metal Gate","MetalGate_DZ"]];
EAT_buildNets = [["Camo Net","Desert","DesertCamoNet_DZ"],["Camo Net","Forest","ForestCamoNet_DZ"],["Camo Net","Large Desert","DesertLargeCamoNet_DZ"],["Camo Net","Large Forest","ForestLargeCamoNet_DZ"]];
EAT_buildStorage = [["Storage","Large Storage Shed","StorageShed_DZ"],["Storage","Gun Rack","GunRack_DZ"],["Storage","Wood Crate","WoodCrate_DZ"],["Storage","Wood Shack","WoodShack_DZ"],["Storage","Fancy Wood Shed","Wooden_shed_DZ"]];
EAT_buildSandbags = [["SandBags","Sandbag Fence","Sandbag1_DZ"],["SandBags","Sandbag Fence (round)","BagFenceRound_DZ"],["SandBags","H-barrier Cube","Land_HBarrier1_DZ"],["SandBags","H-barrier (short)","Land_HBarrier3_DZ"],["SandBags","H-barrier (long)","Land_HBarrier5_DZ"],["SandBags","H-barrier (extra large)","Base_WarfareBBarrier10xTall"],["SandBags","Sandbag Nest","SandNest_DZ"]];
EAT_buildMisc = [["Misc","Outhouse","OutHouse_DZ"],["Misc","Fuel Pump","FuelPump_DZ"],["Misc","Light Pole","LightPole_DZ"],["Misc","Generator","Generator_DZ"],["Misc","Plot Pole","Plastic_Pole_EP1_DZ"],["Misc","Canvas Hut","CanvasHut_DZ"],["Misc","Park Bench","ParkBench_DZ"],["Misc","Stick Fence","StickFence_DZ"],["Misc","Deer Stand","DeerStand_DZ"],["Misc","Scaffolding","Scaffolding_DZ"],["Misc","Fire Barrel","FireBarrel_DZ"],["Misc","Machine Gun Nest","M240Nest_DZ"]];

EAT_allBuildingList = EAT_buildCinder + EAT_buildWood + EAT_buildMetal + EAT_buildNets + EAT_buildStorage + EAT_buildSandbags + EAT_buildMisc;

diag_log("Admin Tools: config.sqf loaded");
