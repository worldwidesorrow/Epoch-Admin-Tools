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

// Initialize Base Manager Variables
BD_Buildables = true;
BD_PlotPoles = true;
BD_vehicles = true;
BCCurrentBase = [];
BC_BuildVector = [];

EAT_isOverpoch = isClass (configFile >> "CfgWeapons" >> "USSR_cheytacM200"); // Used to detect the Overwatch Mod for crate spawning

// These arrays are used in the "Epoch Only" vehicle spawner. By default, they are comprised of all of the vehicles available at the traders, but they can be altered if desired.
EAT_EpochAirVehicles = ["GNT_C185U_DZ","GNT_C185_DZ","GNT_C185R_DZ","GNT_C185C_DZ","AN2_DZ","AN2_2_DZ","An2_2_TK_CIV_EP1_DZ","C130J_US_EP1_DZ","MV22_DZ","CSJ_GyroC_DZE","CSJ_GyroCover","CSJ_GyroP","AH6X_DZ","MH6J_DZ","MTVR_Bird_DZE","pook_H13_civ_DZE","pook_H13_civ_white_DZE","pook_H13_civ_slate_DZE","pook_H13_civ_black_DZE","pook_H13_civ_yellow_DZE","pook_medevac_DZE","pook_medevac_CDF_DZE","pook_medevac_CIV_DZE","Mi17_Civilian_DZ","Mi17_medevac_CDF_DZ","Mi17_medevac_Ins_DZ","Mi17_medevac_RU_DZ","UH60M_MEV_EP1_DZ","BAF_Merlin_DZE","CH53_DZE","pook_transport_DZE","pook_transport_CDF_DZE","pook_gunship_DZE","pook_gunship_CDF_DZE","AH6J_EP1_DZE","UH1H_DZE","UH1H_CDF_DZE","UH1H_WD_DZE","UH1H_2_DZE","UH1H_DES_DZE","UH1H_GREY_DZE","UH1H_BLACK_DZE","UH1H_SAR_DZE","Mi17_DZE","Mi17_TK_EP1_DZE","Mi17_UN_CDF_EP1_DZE","Mi17_CDF_DZE","Mi17_DES_DZE","Mi17_GREEN_DZE","Mi17_BLUE_DZE","Mi17_BLACK_DZE","Mi171Sh_CZ_EP1_DZE","MH60S_DZE","Ka60_GL_PMC_DZE","AW159_Lynx_BAF_DZE","UH60M_EP1_DZE","UH1Y_DZE","CH_47F_EP1_DZE","CH_47F_EP1_Black_DZE","CH_47F_EP1_GREY_DZE","CH_47F_EP1_DES_DZE"];
EAT_EpochLandVehicles = ["MMT_Civ_DZE","Old_bike_TK_CIV_EP1_DZE","Old_moto_TK_Civ_EP1_DZE","M1030_US_DES_EP1_DZE","TT650_Civ_DZE","TT650_Ins_DZE","TT650_TK_CIV_EP1_DZE","ATV_CZ_EP1_DZE","ATV_CIV_CP_DZE","ATV_CIV_Grey_CP_DZE","ATV_CIV_Red_CP_DZE","ATV_CIV_Green_CP_DZE","BAF_ATV_W_DZE","ATV_CIV_Blue_CP_DZE","ATV_CIV_Yellow_CP_DZE","ATV_CIV_Purple_CP_DZE","ATV_CIV_Black_CP_DZE","Octavia_ACR_DZE","Skoda_DZE","SkodaBlue_DZE","SkodaGreen_DZE","SkodaRed_DZE","VolhaLimo_TK_CIV_EP1_DZE","Volha_1_TK_CIV_EP1_DZE","Volha_2_TK_CIV_EP1_DZE","VWGolf_DZE","Mini_Cooper_DZE","car_hatchback_DZE","car_hatchback_red_DZE","car_sedan_DZE","GLT_M300_ST_DZE","GLT_M300_LT_DZE","Lada1_DZE","Lada1_TK_CIV_EP1_DZE","Lada2_DZE","Lada2_TK_CIV_EP1_DZE","LadaLM_DZE","datsun1_civil_3_open_DZE","datsun1_civil_1_open_DZE","datsun1_green_open_DZE","datsun1_civil_2_covered_DZE","datsun1_red_covered_DZE","hilux1_civil_1_open_DZE","hilux1_civil_3_open_DZE","hilux1_civil_2_covered_DZE","UAZ_CDF_DZE","UAZ_INS_DZE","UAZ_RU_DZE","UAZ_Unarmed_TK_CIV_EP1_DZE","UAZ_Unarmed_TK_EP1_DZE","UAZ_Unarmed_UN_EP1_DZE","SUV_TK_CIV_EP1_DZE","SUV_Blue","SUV_Charcoal","SUV_Green","SUV_Orange","SUV_Pink","SUV_Red","SUV_Silver","SUV_White","SUV_Yellow","SUV_Camo","Nissan_Orange_DZE","Nissan_Blue_DZE","Nissan_Mod_DZE","Nissan_Gold_DZE","Nissan_Green_DZE","Nissan_Black_DZE","Nissan_Pink_DZE","Nissan_Red_DZE","Nissan_Ruben_DZE","Nissan_V_DZE","Nissan_Yellow_DZE","Ural_INS_DZE","Ural_CDF_DZE","UralOpen_CDF_DZE","Ural_TK_CIV_EP1_DZE","Ural_UN_EP1_DZE","UralCivil_DZE","UralCivil2_DZE","UralSupply_TK_EP1_DZE","UralReammo_CDF_DZE","UralReammo_INS_DZE","UralRepair_CDF_DZE","UralRepair_INS_DZE","V3S_Open_TK_CIV_EP1_DZE","V3S_Open_TK_EP1_DZE","V3S_Civ_DZE","V3S_TK_EP1_DZE","V3S_Camper_DZE","V3S_RA_TK_GUE_EP1_DZE","Kamaz_DZE","KamazOpen_DZE","KamazRepair_DZE","KamazReammo_DZE","MTVR_DES_EP1_DZE","MTVR_DZE","MTVR_Open_DZE","MtvrRepair_DZE","MtvrReammo_DZE","T810A_ACR_DZE","T810A_ACR_DES_DZE","T810A_ACR_OPEN_DZE","T810A_ACR_DES_OPEN_DZE","T810_ACR_REAMMO_DZE","T810_ACR_REAMMO_DES_DZE","T810_ACR_REPAIR_DZE","T810_ACR_REPAIR_DES_DZE","UralRefuel_TK_EP1_DZ","UralRefuel_INS_DZE","UralRefuel_CDF_DZE","V3S_Refuel_TK_GUE_EP1_DZ","KamazRefuel_DZ","MtvrRefuel_DES_EP1_DZ","MtvrRefuel_DZ","T810A_ACR_REFUEL_DZE","T810A_ACR_REFUEL_DES_DZE","Jeep_DZE","LandRover_CZ_EP1_DZE","LandRover_TK_CIV_EP1_DZE","LandRover_ACR_DZE","BAF_Offroad_D_DZE","BAF_Offroad_W_DZE","LandRover_Ambulance_ACR_DZE","LandRover_Ambulance_Des_ACR_DZE","BTR40_TK_INS_EP1_DZE","BTR40_TK_GUE_EP1_DZE","GAZ_Vodnik_MedEvac_DZE","HMMWV_M1035_DES_EP1_DZE","HMMWV_Ambulance_DZE","HMMWV_Ambulance_CZ_DES_EP1_DZE","HMMWV_DES_EP1_DZE","HMMWV_DZ","Hummer_DZE","Ikarus_DZE","Ikarus_TK_CIV_EP1_DZE","Ikarus_White_DZE","Ikarus_Armored_DZE","S1203_TK_CIV_EP1_DZE","S1203_ambulance_EP1_DZE","Tractor_DZE","TractorOld_DZE","Tractor_Armored_DZE","ScrapAPC_DZE","Pickup_PK_TK_GUE_EP1_DZE","Pickup_PK_GUE_DZE","Pickup_PK_GUE_DZ","Pickup_PK_INS_DZE","Pickup_PK_INS_DZ","Offroad_DSHKM_Gue_DZE","ArmoredSUV_PMC_DZE","LandRover_MG_TK_EP1_DZE","LandRover_Special_CZ_EP1_DZE","UAZ_MG_TK_EP1_DZE","UAZ_MG_CDF_DZE","UAZ_MG_INS_DZE","UAZ_AGS30_CDF_DZE","UAZ_AGS30_INS_DZE","UAZ_AGS30_TK_EP1_DZE","UAZ_AGS30_RU_DZE","UAZ_AGS30_RUST_DZE","UAZ_AGS30_WINTER_DZE","BAF_Jackal2_L2A1_D_DZE","BAF_Jackal2_L2A1_W_DZE","BAF_Jackal2_GMG_D_DZE","BAF_Jackal2_GMG_W_DZE","BTR40_MG_TK_GUE_EP1_DZE","BTR40_MG_TK_INS_EP1_DZE","GAZ_Vodnik_DZE","BRDM2_HQ_TK_GUE_EP1_DZE","BRDM2_HQ_CDF_DZE","HMMWV_Armored_DZE","HMMWV_M2_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","HMMWV_MK19_DZE","HMMWV_DES_MK19_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE","T810A_PKT_ACR_DZE","T810A_PKT_DES_ACR_DZE"];
EAT_EpochMarineVehicles = ["RHIB_DZE","RHIB2Turret_DZE","Submarine_DZE","Smallboat_1_DZE","Smallboat_2_DZE","Fishing_Boat_DZE","PBX_DZE","Zodiac_DZE","JetSkiYanahui_Case_Red","JetSkiYanahui_Case_Yellow","JetSkiYanahui_Case_Green","JetSkiYanahui_Case_Blue"];

// This section defines all of the buildings in the building GUI
// Format: variable = [["TYPE","NAME","BUILING_CLASS"],["TYPE","NAME","BUILING_CLASS"]];

//Residential
local _buildHouse = [["House","Large Brick (Open)","Land_HouseV2_04_interier"],["House","Log Cabin (Open)","Land_HouseV_1I4"],["House","Yellow Modern","Land_sara_domek_zluty"],["House","Large Orange","Land_Housev2_02_Interier"],["House","Yellow Wood","land_housev_3i3"],["House","Burgundy","land_housev_1l2"],["House","Orange/Green","Land_HouseV_3I1"],["House","Damaged Brick","land_r_housev2_04"],["House","Orange/Red","Land_HouseV_1I1"],["House","Barn","Land_HouseV_3I4"],["House","Yellow","Land_HouseV_1T"],["House","Red Brick","Land_HouseV_2I"],["House","Wood","Land_HouseV_1I3"],["House","Green","Land_HouseV_1L1"],["House","Yellow Wood","Land_HouseV_1I2"],["House","Yellow Stone","Land_HouseV_2L"],["House","Green Wood","Land_HouseV_2T2"],["House","Green wood/concrete","Land_HouseV_3I2"],["House","Shanty","Land_MBG_Shanty_BIG"],["House","Middle-East 1","Land_House_C_11_EP1"],["House","Middle-East 2","Land_House_C_12_EP1"],["House","Old Stone 1","Land_House_K_1_EP1"],["House","Old Stone 2","Land_House_K_3_EP1"],["House","Old Stone 3","Land_House_K_5_EP1"],["House","Old Stone 4","Land_House_K_7_EP1"],["House","Old Stone 5","Land_House_K_8_EP1"],["House","Old Stone 6","Land_House_L_1_EP1"],["House","Old Stone 7","Land_House_L_3_EP1"],["House","Old Stone 8","Land_House_L_4_EP1"],["House","Old Stone 9","Land_House_L_6_EP1"],["House","Old Stone 10","Land_House_L_7_EP1"],["House","Old Stone 11","Land_House_L_8_EP1"],["House","Old Stone Ruins","Land_ruin_01"]];
local _buildHouseBlock = [["House Block","A1","Land_HouseBlock_A1"],["House Block","A1","Land_HouseBlock_A1"],["House Block","A1_2","Land_HouseBlock_A1_2"],["House Block","A2","Land_HouseBlock_A2"],["House Block","A2_1","Land_HouseBlock_A2_1"],["House Block","A3","Land_HouseBlock_A3"],["House Block","B1","Land_HouseBlock_B1"],["House Block","B2","Land_HouseBlock_B2"],["House Block","B3","Land_HouseBlock_B3"],["House Block","B4","Land_HouseBlock_B4"],["House Block","B5","Land_HouseBlock_B5"],["House Block","B6","Land_HouseBlock_B6"],["House Block","C1","Land_HouseBlock_C1"],["House Block","C2","Land_HouseBlock_C2"],["House Block","C3","Land_HouseBlock_C3"],["House Block","C4","Land_HouseBlock_C4"],["House Block","C5","Land_HouseBlock_C5"]];
local _buildApartment = [["Apartment","B","Land_MBG_ApartmentsTwo_B"],["Apartment","G","Land_MBG_ApartmentsTwo_G"],["Apartment","P","Land_MBG_ApartmentsTwo_P"],["Apartment","W","Land_MBG_ApartmentsOne_W"],["Apartment","Large","land_mbg_apartments_big_04"],["Apartment","Red Short","Land_Panelak"],["Apartment","Red Tall","Land_Panelak2"],["Apartment","Red Very Tall","Land_Panelak3"],["Apartment","Grey (closed)","Land_A_Office02"]];
local _buildOffice = [["Office","International Hotel","Land_HouseB_Tenement"],["Office","Municipal Office","Land_A_MunicipalOffice"],["School","School (normal)","Land_A_Office01"]];
EAT_buildShed = [["Shed","Nice Wood (open)","Land_Shed_Wooden"],["Shed","Rickety Wood (closed)","Land_kulna"],["Shed","Large Old Wood (closed)","Land_Shed_W4"],["Shed","Patchwork wood (closed)","Land_Shed_W03"],["Shed","Grey Wood (closed)","Land_Shed_W02"],["Shed","Old Metal (closed)","Land_Shed_m03"]];
local _buildResidentMisc = [["Hospital","Hospital (normal)","land_a_hospital"],["Store","Pub","Land_A_Pub_01"],["Store","Supermarket 1","Land_A_GeneralStore_01"],["Store","Supermarket 2","Land_A_GeneralStore_01a"],["House","Mayor's Mansion","Land_A_Villa_EP1"]];
EAT_buildResidential = _buildHouse + _buildHouseBlock + _buildApartment + _buildOffice + EAT_buildShed + _buildResidentMisc;

//Industrial
local _buildCargo = [["Cargo","1 Closed Red Crate","Land_Misc_Cargo1Bo"],["Cargo","2 Closed Red Crates","Land_Misc_Cargo2D"],["Cargo","1 Open Cargo Crate","Land_Misc_Cargo1D"],["Cargo","Military Crate","US_WarfareBVehicleServicePoint_Base_EP1"]];
local _buildIndustrialParts = [["Metal","Overhang","Land_Ind_Shed_02_main"],["Metal","Arch","Land_Ind_Shed_01_end"],["Station","Vehicle Ceckpoint","Land_Hlidac_budka"]];
local _buildIndustrial = [["Industrial","Large Construction","MAP_A_BuildingWIP"],["Industrial","Hangar","Land_Hangar_2"],["Industrial","Workshop","Land_Ind_Workshop01_01"],["Industrial","Workshop","Land_Ind_Workshop01_04"],["Industrial","Workshop","Land_Ind_Workshop01_L"],["Industrial","Shed","Land_Shed_Ind02"],["Industrial","Repair Center","Land_repair_center"],["Industrial","Garage","Land_Ind_Garage01"],["Industrial","Industrial Warehouse","Land_Ind_Pec_03a"],["Industrial","Fuel Station","Land_A_FuelStation_Shed"],["Industrial","Fuel Station","Land_A_FuelStation_Feed"],["Industrial","Fuel Station","Land_A_FuelStation_Build"],["Industrial","Fuel Tank","Land_Fuel_tank_stairs"],["Industrial","Fuel Tank","Land_Ind_TankSmall"],["Industrial","Large Factory","Land_Ind_Vysypka"],["Industrial","Small Factory","Land_Tovarna2"],["Industrial","Well","MAP_Pumpa"],["Industrial","Well","Land_Misc_Well_C_EP1"],["Industrial","Fire Barrel","Land_Fire_barrel"]];
EAT_buildIndustrial = _buildIndustrial + _buildCargo + _buildIndustrialParts;

// Farm
EAT_buildFarm = [["Farm","Barn","Land_stodola_old_open"],["Farm","Cowshed Section A","Land_Farm_Cowshed_a"],["Farm","Cowshed Section B","Land_Farm_Cowshed_b"],["Farm","Cowshed Section C","Land_Farm_Cowshed_c"],["Farm","Barn","Land_Barn_W_01"],["Farm","Barn","Land_stodola_open"],["Farm","Barn","Land_Barn_W_02"],["Farm","Hay Bale","Land_seno_balik"]];

//Military
EAT_buildMilitary = [["Military","Airplane Hangar","Land_SS_hangar"],["Military","Administration","Land_Mil_House"],["Military","ATC","Land_Mil_ControlTower"],["Barracks","L-Barracks","Land_Mil_Barracks_L"],["Barracks","L-Barracks","Land_Mil_Barracks_i"],["Barracks","Open Barracks","Land_Mil_Barracks"],["Military","Fire Station","Land_a_stationhouse"],["Depot","Warfare Depot","WarfareBDepot"],["Hospital","Field Hospital","INS_WarfareBFieldhHospital"],["Military","Guardhouse","Land_Mil_Guardhouse"],["Military","Military Tent","CampEast_EP1"],["Military","Medical Tent (Red Cross)","MASH_EP1"],["Military","Medical Tent","Camp_EP1"],["Military","Military Tent","Land_tent_east"]];

//Religious
EAT_buildReligious = [["Church","Orange","Land_Church_01"],["Church","Open","Land_Church_03"],["Church","Closed","Land_Church_02"],["Church","Destroyed","Land_Church_05R"],["Mosque","Small","Land_A_Mosque_small_2_EP1"],["Mosque","Medium","Land_A_Mosque_small_1_EP1"],["Mosque","Large","Land_A_Mosque_big_hq_EP1"],["Mosque","Addon","Land_A_Mosque_big_addon_EP1"],["Mosque","Wall","Land_A_Mosque_big_wall_EP1"]];

//Graves
EAT_buildGrave = [["Grave","Grave (normal)","Grave"],["Grave","Cross 1","GraveCross1"],["Grave","Cross 2","GraveCross2"],["Grave","Cross /w Helmet","GraveCrossHelmet"],["Grave","Mass Grave","Mass_grave_DZ"]];

//Castle
EAT_buildCastle = [["Castle","Gate","Land_A_Castle_Gate"],["Castle","Tower","Land_A_Castle_Bergfrit"],["Castle","Stairs","Land_A_Castle_Stairs_A"],["Castle","Wall","Land_A_Castle_Wall1_20"],["Castle","Wall","Land_A_Castle_Wall2_30"],["Castle","Wall","Land_A_Castle_WallS_10"],["Castle","Wall End","Land_A_Castle_Wall2_End_2"],["Castle","Wall End","Land_A_Castle_Wall1_20_Turn"],["Castle","Bastion","Land_A_Castle_Bastion"],["Castle","Keep","Land_A_Castle_Donjon"],["Castle","End1","Land_A_Castle_Wall1_End"],["Castle","End2","Land_A_Castle_WallS_End"],["Castle","End3","Land_A_Castle_Wall1_End_2"],["Castle","End4","Land_A_Castle_Wall2_End"],["Castle","End5","Land_A_Castle_Wall2_End_2"],["Dock","Wall","MAP_molo_krychle"]];

// Epoch Modular Buildables
local _buildCinder = [["Cinder","1/2 Wall","CinderWallHalf_DZ"],["Cinder","1/2 Wall w/ Gap","CinderWallHalf_Gap_DZ"],["Cinder","Full Wall","CinderWall_DZ"],["Cinder","Full Wall w/ Window","CinderWallWindow_DZ"],["Cinder","Garage Doorway","CinderWallDoorway_DZ"],["Cinder","Garage Doorway Open Top","CinderGarageOpenTopFrame_DZ"],["Cinder","Doorway","CinderWallSmallDoorway_DZ"],["Cinder","Doorway w/ Hatch","CinderDoorHatch_DZ"],["Cinder","Tall Gate","CinderGateFrame_DZ"],["Cinder","Bunker","Concrete_Bunker_DZ"]];
local _buildMetal = [["Metal","Panel","MetalPanel_DZ"],["Metal","4X Floor","MetalFloor4x_DZ"],["Metal","Floor","MetalFloor_DZ"],["Metal","1/2 Floor","MetalFloor_Half_DZ"],["Metal","1/4 Floor","MetalFloor_Quarter_DZ"],["Metal","Glass Floor","GlassFloor_DZ"],["Metal","1/2 Glass Floor","GlassFloor_Half_DZ"],["Metal","1/4 Glass Floor","GlassFloor_Quarter_DZ"],["Metal","Pillar","MetalPillar_DZ"],["Metal","Corrugated Fence","Fence_corrugated_DZ"],["Metal","Tank Trap","Hedgehog_DZ"],["Metal","Wire Fence","Fort_RazorWire"],["Metal","Metal Gate","MetalGate_DZ"],["Metal","Drawbridge","Metal_Drawbridge_DZ"]];
local _buildWood = [["Wood","Ramp","WoodRamp_DZ"],["Wood","Floor w/ Stairs","WoodFloorStairs_DZ"],["Wood","4X Floor","WoodFloor4x_DZ"],["Wood","Wood Floor","WoodFloor_DZ"],["Wood","1/2 Floor","WoodFloorHalf_DZ"],["Wood","1/4 Floor","WoodFloorQuarter_DZ"],["Wood","Triangle Floor","WoodTriangleFloor_DZ"],["Wood","Large Wall","WoodLargeWall_DZ"],["Wood","Large Doorway","WoodLargeWallDoor_DZ"],["Wood","Large Wall w/Window","WoodLargeWallWin_DZ"],["Wood","Garage Frame","Land_DZE_GarageWoodDoor"],["Wood","Open Top Garage","Land_DZE_WoodOpenTopGarageDoor"],["Wood","Wood Gate Frame","WoodGateFrame_DZ"],["Wood","Wood Gate","Land_DZE_WoodGate"],["Wood","Wall","WoodSmallWall_DZ"],["Wood","1/3 Wall","WoodSmallWallThird_DZ"],["Wood","Triangle Wall","WoodTriangleWall_DZ"],["Wood","Wall w/Window","WoodSmallWallWin_DZ"],["Wood","Doorway","WoodSmallWallDoor_DZ"],["Wood","Stairs","WoodStairsSans_DZ"],["Wood","Stairs w/Stilts","WoodStairs_DZ"],["Wood","Stairs w/Rails","WoodStairsRails_DZ"],["Wood","Ladder","WoodLadder_DZ"],["Wood","Handrail","WoodHandrail_DZ"],["Wood","Pillar","WoodPillar_DZ"],["Wood","Door Frame","DoorFrame_DZ"],["Wood","Frame w/ Door","Door_DZ"]];
local _buildNets = [["Camo Net","Desert","DesertCamoNet_DZ"],["Camo Net","Forest","ForestCamoNet_DZ"],["Camo Net","Winter","WinterCamoNet_DZ"],["Camo Net","Large Desert","DesertLargeCamoNet_DZ"],["Camo Net","Large Forest","ForestLargeCamoNet_DZ"],["Camo Net","Large Winter","WinterLargeCamoNet_DZ"]];
local _buildStorage = [["Storage","Large Storage Shed","StorageShed_DZ"],["Storage","Upgraded Large Storage Shed","StorageShed2_DZ"],["Storage","Gun Rack","GunRack_DZ"],["Storage","Upgraded Gun Rack","GunRack2_DZ"],["Storage","Wood Crate","WoodCrate_DZ"],["Storage","Upgraded Wood Crate","WoodCrate2_DZ"],["Storage","Wood Shack","WoodShack_DZ"],["Storage","Upgraded Wood Shack","WoodShack2_DZ"],["Storage","Fancy Wood Shed","Wooden_shed_DZ"],["Storage","Upgraded Fancy Wood Shed","Wooden_shed2_DZ"],["Storage","Safe","VaultStorageLocked"],["Storage","Upgraded Safe","VaultStorage2Locked"],["Storage","Tall Safe","TallSafeLocked"],["Storage","Lockbox","LockboxStorageLocked"],["Storage","Upgraded Lockbox","LockboxStorage2Locked"],["Storage","Winter Lockbox","LockboxStorageWinterLocked"],["Storage","Upgraded Winter Lockbox","LockboxStorageWinter2Locked"]];
local _buildSandbags = [["SandBags","Sandbag Fence","Sandbag1_DZ"],["SandBags","Sandbag Fence (round)","BagFenceRound_DZ"],["SandBags","H-barrier Cube","Land_HBarrier1_DZ"],["SandBags","H-barrier (short)","Land_HBarrier3_DZ"],["SandBags","H-barrier (long)","Land_HBarrier5_DZ"],["SandBags","H-barrier (extra large)","Base_WarfareBBarrier10xTall"],["SandBags","Sandbag Nest","SandNest_DZ"]];
local _buildMisc = [["Misc","Workbench","WorkBench_DZ"],["Misc","Advanced Workbench","Advanced_WorkBench_DZ"],["Misc","Outhouse","OutHouse_DZ"],["Misc","Fuel Pump","FuelPump_DZ"],["Misc","Light Pole","LightPole_DZ"],["Misc","Generator","Generator_DZ"],["Misc","Plot Pole","Plastic_Pole_EP1_DZ"],["Misc","Canvas Hut","CanvasHut_DZ"],["Misc","Park Bench","ParkBench_DZ"],["Misc","Stick Fence","StickFence_DZ"],["Misc","Deer Stand","DeerStand_DZ"],["Misc","Scaffolding","Scaffolding_DZ"],["Misc","Fire Barrel","FireBarrel_DZ"],["Misc","Machine Gun Nest","M240Nest_DZ"],["Misc","Cooking Tripod","CookTripod_DZ"],["Misc","Stone Oven","Stoneoven_DZ"],["Misc","Toilet","Commode_DZ"],["Misc","Wardrobe","Wardrobe_DZ"],["Misc","Fridge","Fridge_DZ"],["Misc","Washing Machine","Washing_Machine_DZ"],["Misc","Server Rack","Server_Rack_DZ"],["Misc","ATM","ATM_DZ"],["Misc","Armchair","Armchair_DZ"],["Misc","Sofa","Sofa_DZ"],["Misc","Arcade Game","Arcade_DZ"],["Misc","Vending Machine","Vendmachine1_DZ"],["Misc","Vending Machine","Vendmachine2_DZ"],["Misc","Storage Crate","StorageCrate_DZ"],["Misc","Camo Storage Crate","CamoStorageCrate_DZ"],["Misc","Water Pump","Water_Pump_DZ"],["Misc","Greenhouse","Greenhouse_DZ"],["Misc","Bed","Bed_DZ"],["Misc","Table","Table_DZ"],["Misc","Office Chair","Office_Chair_DZ"],["Misc","Green Garage","Garage_Green_DZ"],["Misc","White Garage","Garage_White_DZ"],["Misc","Brown Garage","Garage_Brown_DZ"],["Misc","Grey Garage","Garage_Grey_DZ"],["Misc","Civilian Helipad","Helipad_Civil_DZ"]];
EAT_buildModular = _buildCinder + _buildMetal + _buildWood + _buildNets + _buildStorage + _buildSandbags + _buildMisc;

//Ore
EAT_buildOre = [["Ore","Gold","Gold_Vein_DZE"],["Ore","Silver","Silver_Vein_DZE"],["Ore","Iron","Iron_Vein_DZE"]];

//Roads
EAT_buildRoad = [["Fence","Fence","MAP_zed2_civil"],["Fence","Fence","MAP_Wall_Fen1_5_Pole"],["Fence","Fence","MAP_Wall_Fen1_5"],["Fence","Fence","MAP_Wall_Fen1_5_Hole"],["Fence","Fence","MAP_Wall_Tin_4"],["Fence","Fence","MAP_Wall_Tin_4_2"],["Tree","Tree","MAP_t_picea2s"],["Tree","Tree","MAP_t_picea1s"],["Runway","Runway","MAP_runway_beton"],["Runway","Runway","MAP_runway_end15"],["Runway","Runway","MAP_runway_main"],["Runway","Runway","MAP_runway_poj_L_2_end"],["Runway","Runway","MAP_runway_poj_T_2"],["Runway","Runway","MAP_runway_poj_draha"],["Runway","Runway","MAP_runway_poj_L_2"],["Runway","Runway","MAP_runway_poj_T_1"],["Runway","Runway","MAP_runway_beton_end1"],["Runway","Runway","MAP_runway_beton_end2"],["Road","Road","MAP_asf3_10_75"],["Road","Road","MAP_asf3_6konec"],["Road","Road","MAP_asf3_0_2000"],["Road","Road","MAP_kr_t_asf3_asf3"],["Road","Road","MAP_asf3_6"],["Road","Road","MAP_asf3_12"],["Road","Road","MAP_asf2_0_2000"],["Road","Road","MAP_asf3_10_25"],["Road","Road","MAP_asf3_22_50"],["Road","Road","MAP_asf3_10_50"],["Road","Road","MAP_asf2_12"],["Road","Road","MAP_city_0_2000"],["Road","Road","MAP_city_10_75"],["Road","Road","MAP_kr_t_city_asf3"],["Road","Road","MAP_city_10_25"],["Road","Road","MAP_city_6"],["Road","Gravel Road","MAP_grav_1_1000"],["Road","Gravel Road","MAP_grav_10_50"],["Road","Gravel Road","MAP_grav_6konec"],["Road","Gravel Road","MAP_grav_30_25"],["Road","Gravel Road","MAP_grav_6"],["Road","Gravel Road","MAP_grav_15_75"],["Road","Gravel Road","MAP_grav_10_25"],["Road","Grass Cutter","ClutterCutter_EP1"]];

//Other
local _buildMarker = [["Marker","Archway","Sign_circle_EP1"]];
local _buildSand = [["Sandbag","Nest (BIG)","Land_fortified_nest_big"],["Sandbag","2 Story cubes /w Net","Land_Fort_Watchtower"]];
local _buildRamp = [["Ramp","Concrete Tall","Land_ConcreteRamp"],["Ramp","Concrete Short","RampConcrete"],["Ramp","Wood Small","Land_WoodenRamp"]];
local _buildMisc = [["Statue","Soldiers /w Flag","Land_A_statue01"],["Statue","Tank","Land_A_statue02"],["Misc","Archway","Land_brana02nodoor"]];
EAT_buildOutdoors = [["Outdoors","Outhouse","Land_KBud"]];
EAT_buildOther =  EAT_buildOutdoors + _buildMisc + _buildRamp + _buildSand + _buildMarker;


EAT_allBuildingList = EAT_buildResidential + EAT_buildIndustrial + EAT_buildMilitary + EAT_buildReligious + EAT_buildGrave + EAT_buildCastle + EAT_buildOre + EAT_buildOther;

/***************** add basses here for base manager *****************/
BCBaseList = [
	[
		"base1",
		"Test Base",
		[0,23,0],
		[
			["CinderWallDoor_DZ",[0.0551758,-0.736328,3.37357],239.861],
			["MetalFloor_DZ",[2.53516,0.763672,6.58356],59.9374],
			["MetalFloor_DZ",[2.54492,0.763672,3.19955],59.8886],
			["MetalFloor_DZ",[-2.00488,-1.83691,6.58356],239.937],
			["MetalFloor_DZ",[-2.00488,-1.83691,3.19955],239.889],
			["CinderWall_DZ",[-4.20508,1.36328,3.38358],150.186],
			["CinderWallDoorSmall_DZ",[-2.5249,3.76367,3.38358],239.993],
			["FireBarrel_DZ",[4.40527,1.86328,3.43457],59.2191],
			["CinderWallDoor_DZ",[4.78516,2.06348,-0.000427246],59.9374],
			["MetalFloor_DZ",[-0.0947266,5.26367,6.58356],239.937],
			["MetalFloor_DZ",[-0.0947266,5.26367,3.19955],59.8886],
			["WoodSmallWallThird_DZ",[4.84521,2.06348,3.38358],239.847],
			["WoodSmallWallThird_DZ",[4.89502,1.96289,3.38358],59.8468],
			["MetalFloor_DZ",[-4.63477,2.66309,3.19955],239.889],
			["MetalFloor_DZ",[-4.63477,2.66309,6.58356],59.9374],
			["CinderWall_DZ",[-0.214844,-5.63672,3.38358],329.709],
			["CinderWallDoorSmall_DZ",[2.71484,-5.23633,3.39355],59.7286],
			["MetalFloor_DZ",[5.16504,-3.83691,6.58356],239.937],
			["MetalFloor_DZ",[5.1748,-3.83691,3.19955],59.8886],
			["MetalFloor_DZ",[0.625,-6.43652,6.58356],59.9374],
			["MetalFloor_DZ",[0.635254,-6.43652,3.19955],239.889],
			["CinderWall_DZ",[6.18506,2.76367,3.38358],60.0843],
			["CinderWallDoorSmall_DZ",[2.33496,6.36328,-0.000427246],59.7633],
			["CinderWall_DZ",[-1.50488,7.46289,3.38956],329.972],
			["CinderWall_DZ",[-1.54492,7.46289,-0.000427246],150.363],
			["CinderWall_DZ",[-6.04492,4.76367,-0.000427246],148.928],
			["CinderWallDoorSmall_DZ",[7.34521,-2.33691,0.009552],59.8816],
			["CinderWallHalf_DZ",[-6.23486,4.66309,3.38956],149.364],
			["MetalFloor_DZ",[7.08496,3.36328,6.58356],59.9374],
			["MetalFloor_DZ",[-6.54492,-4.53711,3.19955],239.889],
			["MetalFloor_DZ",[-6.54492,-4.53711,6.58356],239.937],
			["MetalFloor_DZ",[5.36523,6.36328,3.18356],59.7772],
			["CinderWall_DZ",[8.55518,1.06348,-0.000427246],149.939],
			["CinderWall_DZ",[-8.59473,-1.13672,3.38358],150.109],
			["MetalFloor_DZ",[8.90527,0.263672,3.19357],59.8189],
			["CinderWall_DZ",[6.375,-6.23633,3.37958],149.81],
			["CinderWall_DZ",[6.375,-6.23633,-0.000427246],329.81],
			["Sandbag1_DZ",[6.68506,6.16309,-0.00143433],329.956],
			["MetalFloor_DZ",[4.44482,7.96289,3.19955],59.8886],
			["MetalFloor_DZ",[4.45508,7.96289,6.58356],59.9374],
			["MetalFloor_DZ",[-9.1748,0.0634766,6.58356],239.937],
			["MetalFloor_DZ",[-9.1748,0.0634766,3.19955],239.889],
			["CinderWallHalf_DZ",[1.60498,-9.03711,3.37958],149.81],
			["CinderWall_DZ",[1.60498,-9.03711,-0.000427246],329.81],
			["CinderWall_DZ",[-4.58496,-8.13672,3.38358],329.818],
			["CinderWallDoorSmall_DZ",[7.10498,6.36328,3.39755],330.226],
			["MetalFloor_DZ",[8.5752,4.26367,3.19357],59.7494],
			["MetalFloor_DZ",[8.70508,4.26367,6.58755],59.9444],
			["MetalFloor_DZ",[9.71484,-1.13672,6.58356],59.9374],
			["MetalFloor_DZ",[-3.90479,-9.03711,3.19955],239.889],
			["MetalFloor_DZ",[-3.91504,-9.03711,6.58356],239.937],
			["CinderWallDoorSmall_DZ",[9.78516,1.76367,3.39755],149.591],
			["WoodStairsSans_DZ",[9.64502,-3.23633,0.299561],149.952],
			["WoodSmallWallThird_DZ",[10.1748,-1.83691,3.37756],149.842],
			["WoodSmallWallThird_DZ",[10.2148,-1.73633,3.37756],329.842],
			["CinderWall_DZ",[3.24512,10.1631,-0.000427246],150.363],
			["CinderWall_DZ",[3.24512,10.1631,3.37958],330.363],
			["CinderWall_DZ",[-9.03516,-5.73633,-0.000427246],60.2108],
			["CinderWall_DZ",[-9.60498,-4.73633,3.38956],60.2249],
			["CinderWall_DZ",[-10.5649,2.16309,-0.000427246],150.057],
			["CinderWallHalf_DZ",[-10.5649,2.16309,3.37958],330.057],
			["CinderWall_DZ",[-8.23486,-7.13672,3.38956],60.0563],
			["CinderWall_DZ",[6.85498,9.16309,3.37958],60.0283],
			["CinderWall_DZ",[6.85498,9.16309,-0.000427246],240.028],
			["CinderWall_DZ",[-11.5552,-1.33691,-0.000427246],60.3165],
			["CinderWallHalf_DZ",[-11.5552,-1.33691,3.37958],240.317],
			["CinderWall_DZ",[11.1353,-3.43652,-0.000427246],329.81],
			["CinderWall_DZ",[11.1353,-3.43652,3.37958],149.81],
			["CinderWallHalf_DZ",[-2.60498,-11.4365,3.37958],150.089],
			["CinderWall_DZ",[-2.60498,-11.4365,-0.000427246],330.089],
			["CinderWallHalf_DZ",[10.7451,5.46289,3.37357],59.9723],
			["CinderWall_DZ",[12.0649,0.163086,3.37958],60.1405],
			["CinderWall_DZ",[12.0649,0.163086,-0.000427246],240.14],
			["CinderWall_DZ",[-6.29492,-10.5371,-0.000427246],60.2108],
			["CinderWallHalf_DZ",[-6.29492,-10.5371,3.37958],240.211],
			["WoodStairsSans_DZ",[12.2749,-1.63672,-2.20044],149.947]
		]
	],
		[
		"Base2", //Name the base
		"Bambi Bunker", //give it a display name
		[0,23,0], //This is the distance the base will spawn from you
		[
			["MetalFloor_DZ",[-0.635254,-0.428711,3.1275],124.745],
			["CinderWall_DZ",[0.869141,1.74072,-0.076416],214.745],
			["CinderWall_DZ",[1.53467,-1.93359,-0.076355],304.745],
			["CinderWall_DZ",[-2.80469,1.07617,-0.0765076],124.745],
			["CinderWallDoorSmall_DZ",[-2.13965,-2.59863,-0.0762634],34.7454]
		]
	] // to add a base place a comma here. ex: ],
	//add base from server/EpochAdminToolLogs/SavedBases here
];

diag_log("Admin Tools: config.sqf loaded");
