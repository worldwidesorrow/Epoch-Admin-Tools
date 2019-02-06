/************** Epoch Moderator Tools Variables **************/

//This creates a log in your server\EpochAdminToolLogs\toolUsageLog.txt REQUIRES: EATadminLogger.dll
EAT_logMajorTool = true; //A major tool is a strong tool with high possibility for exploitation
EAT_logMinorTool = true;//A minor tool is a weak tool with low possibility for exploitation

/************** ModMode Variables **************/
	
// Defines the default on and off for mod mode options
// ALL items can be turned on or off during gameplay, these are just defaults
EAT_playerGod = true;
EAT_vehicleGod = false;
EAT_playerESPMode = true;
EAT_grassOff = true;
EAT_infAmmo = true;
EAT_fastWalk = true;
EAT_fastUp = true;
EAT_invisibility = false;
EAT_ZombieShield = false;

// These arrays are used in the moderator's vehicle spawner. By default, they are comprised of all of the vehicles available at the traders, but they can be altered if desired.
EAT_EpochAirVehicles = ["Mi17_DZE","UH1H_DZE","UH1Y_DZE","UH60M_EP1_DZE","MH60S_DZE","CH_47F_EP1_DZE","CH53_DZE","CSJ_GyroC","CSJ_GyroCover","CSJ_GyroP","AH6X_DZ","MH6J_DZ","UH60M_MEV_EP1_DZ","Mi17_Civilian_DZ","BAF_Merlin_DZE","GNT_C185U_DZ","GNT_C185_DZ","GNT_C185R_DZ","GNT_C185C_DZ","AN2_DZ","AN2_2_DZ","An2_2_TK_CIV_EP1_DZ","MV22_DZ","C130J_US_EP1_DZ"];
EAT_EpochLandVehicles = ["LandRover_MG_TK_EP1_DZE","LandRover_Special_CZ_EP1_DZE","UAZ_MG_TK_EP1_DZE","GAZ_Vodnik_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE","Pickup_PK_TK_GUE_EP1_DZE","Pickup_PK_GUE_DZE","Pickup_PK_INS_DZE","Offroad_DSHKM_Gue_DZE","ArmoredSUV_PMC_DZE","LandRover_CZ_EP1","LandRover_TK_CIV_EP1","HMMWV_M1035_DES_EP1","HMMWV_Ambulance","HMMWV_Ambulance_CZ_DES_EP1","HMMWV_DES_EP1","HMMWV_DZ","BTR40_TK_INS_EP1","GAZ_Vodnik_MedEvac","MMT_Civ","Old_bike_TK_INS_EP1","TT650_Civ","TT650_Ins","TT650_TK_CIV_EP1","ATV_CZ_EP1","ATV_US_EP1","M1030_US_DES_EP1","Old_moto_TK_Civ_EP1","tractor","Ikarus","Ikarus_TK_CIV_EP1","S1203_TK_CIV_EP1","S1203_ambulance_EP1","Ural_CDF","Ural_TK_CIV_EP1","Ural_UN_EP1","UralCivil_DZE","UralCivil2_DZE","V3S_Open_TK_CIV_EP1","V3S_Open_TK_EP1","V3S_Civ","V3S_RA_TK_GUE_EP1_DZE","V3S_TK_EP1_DZE","Kamaz_DZE","KamazOpen_DZE","MTVR_DES_EP1","MTVR","UralRefuel_TK_EP1_DZ","V3S_Refuel_TK_GUE_EP1_DZ","KamazRefuel_DZ","MtvrRefuel_DES_EP1_DZ","MtvrRefuel_DZ","hilux1_civil_3_open_DZE","datsun1_civil_3_open_DZE","hilux1_civil_1_open_DZE","datsun1_civil_2_covered_DZE","datsun1_civil_1_open_DZE","hilux1_civil_2_covered_DZE","Skoda","SkodaBlue","SkodaGreen","SkodaRed","VolhaLimo_TK_CIV_EP1","Volha_1_TK_CIV_EP1","Volha_2_TK_CIV_EP1","VWGolf","car_hatchback","car_sedan","GLT_M300_LT","GLT_M300_ST","Lada1","Lada1_TK_CIV_EP1","Lada2","Lada2_TK_CIV_EP1","LadaLM","SUV_TK_CIV_EP1","SUV_Blue","SUV_Charcoal","SUV_Green","SUV_Orange","SUV_Pink","SUV_Red","SUV_Silver","SUV_White","SUV_Yellow","SUV_Camo","UAZ_CDF","UAZ_INS","UAZ_RU","UAZ_Unarmed_TK_CIV_EP1","UAZ_Unarmed_TK_EP1","UAZ_Unarmed_UN_EP1"];
EAT_EpochMarineVehicles = ["RHIB","Smallboat_1","Smallboat_2","Zodiac","Fishing_Boat","PBX","JetSkiYanahui_Case_Red","JetSkiYanahui_Case_Yellow","JetSkiYanahui_Case_Green","JetSkiYanahui_Case_Blue"];

diag_log("Moderator Tools: Configs loaded");
