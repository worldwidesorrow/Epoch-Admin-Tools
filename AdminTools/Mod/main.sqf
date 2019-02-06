EAT_ToolsMain = {

	// Main menu
	if(isNil "EAT_mainMenu") then {
		EAT_mainMenu = [["",true],["-- Epoch Admin Tools (Level: Mod) --", [], "", -5, [["expression", ""]], "1", "0"]];
		EAT_mainMenu = EAT_mainMenu + [["Mod Menu >>", [], "#USER:EAT_modMenu", -5, [["expression", ""]], "1", "1"]];
		EAT_mainMenu = EAT_mainMenu + [["Vehicle Menu >>",[],"#USER:EAT_vehicleMenu",-5,[["expression",""]],"1","1"]];
		EAT_mainMenu = EAT_mainMenu + [["Weapon/Item Kits >>", [], "#USER:EAT_weaponMenu", -5, [["expression", ""]], "1", "1"]];
		EAT_mainMenu = EAT_mainMenu + [["Teleport Menu >>",[],"#USER:EAT_teleportMenu", -5, [["expression", ""]], "1", "1"]];
		EAT_mainMenu = EAT_mainMenu + [["Skin Change Menu >>", [], "#USER:EAT_skinMenu", -5, [["expression", ""]], "1", "1"]];
		//if(EAT_ActionMenuPlayers && EAT_AllowContactAdmin)then{EAT_mainMenu = EAT_mainMenu + [["Player Ticket Menu >>", [], "", -5, [["expression", format[_EXECgenTools,"contactAdminTickets.sqf"]]], "1", "1"]];};
		EAT_mainMenu = EAT_mainMenu + [["", [], "", -5, [["expression", ""]], "1", "0"], ["Exit", [20], "", -5, [["expression", ""]], "1", "1"]];

		
	// Mod only menu
		EAT_modMenu = [["",true]];
		EAT_modMenu = EAT_modMenu + [["-- Moderator's Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_modMenu = EAT_modMenu + [["Mod Mode (F4 for options)",[],"", -5,[["expression","[] spawn EAT_ModModeToggle;"]],"1","1"]];
		EAT_modMenu = EAT_modMenu + [["Point to Repair",[],"", -5,[["expression","call EAT_Repair;"]], "1", "1"]];
		EAT_modMenu = EAT_modMenu + [["Point to Delete",[],"", -5,[["expression","[] spawn EAT_DeleteObj;"]],"1","1"]];
		EAT_modMenu = EAT_modMenu + [["Spectate player (F6 to cancel)",[],"", -5,[["expression","[] spawn EAT_Spectate;"]], "1", "1"]];
		EAT_modMenu = EAT_modMenu + [["Heal Players",[],"", -5, [["expression","[] spawn EAT_HealPlayer;"]], "1", "1"]];
		EAT_modMenu = EAT_modMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_modMenu = EAT_modMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];


	// Main vehicle selection menu
		EAT_vehicleMenu = [["",true]];
		EAT_vehicleMenu = EAT_vehicleMenu + [["-- Vehicle Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_vehicleMenu = EAT_vehicleMenu + [["Graphical Vehicle Menu", [],"", -5, [["expression", "[] spawn EAT_AddVehDialog;"]], "1", "1"]];
		EAT_vehicleMenu = EAT_vehicleMenu + [["Vehicle Tools >>", [], "#USER:EAT_vehicleTools", -5, [["expression", ""]], "1", "1"]];
		EAT_vehicleMenu = EAT_vehicleMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_vehicleMenu = EAT_vehicleMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

	// Different tools for working with vehicles
		EAT_vehicleTools = [["",true]];
		EAT_vehicleTools = EAT_vehicleTools + [["-- Vehicle Tools --", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_vehicleTools = EAT_vehicleTools + [["Vehicle Locater",[],"",-5,[["expression", "call EAT_locateVeh;"]], "1", "1"]];
		EAT_vehicleTools = EAT_vehicleTools + [["Recover Vehicle Key",[],"",-5,[["expression", "call EAT_RecoverKey;"]], "1", "1"]];
		EAT_vehicleTools = EAT_vehicleTools + [["Point to Repair", [],"", -5, [["expression", "call EAT_Repair;"]], "1", "1"]];
		EAT_vehicleTools = EAT_vehicleTools + [["Point to Delete",[],"",-5,[["expression","[] spawn EAT_DeleteObj;"]],"1","1"]];
		EAT_vehicleTools = EAT_vehicleTools + [["Flip Vehicle", [],"", -5, [["expression", "call EAT_flipVeh;"]], "1", "1"]];
		EAT_vehicleTools = EAT_vehicleTools + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_vehicleTools = EAT_vehicleTools + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

	// Menu for teleport options
		//	teleport to place Example: ["Name",[],"", -5, [["expression", '[x,y,z] execVM "admintools\tools\Teleport\teleportToLocation.sqf"']], "1", "1"]];
		EAT_teleportMenu = [["",true]];
		EAT_teleportMenu = EAT_teleportMenu + [["-- Teleport Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_teleportMenu = EAT_teleportMenu + [["Teleport (T Key)",[],"", -5,[["expression", "[] spawn EAT_TeleportToggle;"]], "1", "1"]];
	//	EAT_teleportMenu = EAT_teleportMenu + [["Teleport To Me",[],"", -5, [["expression", "[] spawn EAT_TPtoMe;"]], "1", "1"]];
		EAT_teleportMenu = EAT_teleportMenu + [["Teleport To Player",[],"", -5, [["expression", "[] spawn EAT_TpToPlayer;"]], "1", "1"]];
	//	EAT_teleportMenu = EAT_teleportMenu + [["Return Player to Last Pos",[],"", -5, [["expression", "[] spawn EAT_ReturnPlayerTP;"]], "1", "1"]];
		EAT_teleportMenu = EAT_teleportMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_teleportMenu = EAT_teleportMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

	// Menu for changing skins.
	// Entry Format:["Entry Name",[],"",-5,[["expression",'["Skin_class_name"] execVM "admintools\tools\skinChanger.sqf"']],"1","1"]];
		EAT_skinMenu = [["",true]];
		EAT_skinMenu = EAT_skinMenu + [["-- Skin Menu (Page 1)", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_skinMenu = EAT_skinMenu + [["Survivor",[],"",-5,[["expression",'["Survivor2_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu = EAT_skinMenu + [["Hero",[],"",-5,[["expression",'["Survivor3_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu = EAT_skinMenu + [["Bandit",[],"",-5,[["expression",'["Bandit1_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu = EAT_skinMenu + [["Soldier",[],"",-5,[["expression",'["Soldier1_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu = EAT_skinMenu + [["Ghillie",[],"",-5,[["expression",'["Sniper1_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu = EAT_skinMenu + [["Special Forces",[],"",-5,[["expression",'["CZ_Special_Forces_GL_DES_EP1_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu = EAT_skinMenu + [["Pilot",[],"",-5,[["expression",'["CZ_Special_Forces_GL_DES_EP1_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu = EAT_skinMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_skinMenu = EAT_skinMenu + [["Next page >", [], "#USER:EAT_skinMenu2", -5, [["expression", ""]], "1", "1"]];

	// Menu2 for changing skins.
		EAT_skinMenu2 = [["",true]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["-- Skin Menu (Page 2)", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["Camo",[],"",-5,[["expression",'["Camo1_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["Bodyguard",[],"",-5,[["expression",'["Soldier_Bodyguard_AA12_PMC_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["Officer",[],"",-5,[["expression",'["Rocket_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["Alejandria",[],"",-5,[["expression",'["SurvivorWcombat_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["Savannah",[],"",-5,[["expression",'["SurvivorWdesert_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["Melly",[],"",-5,[["expression",'["SurvivorWpink_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["Bandit Jane",[],"",-5,[["expression",'["BanditW2_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		//EAT_skinMenu2 = EAT_skinMenu2 + [["Invisible",[],"",-5,[["expression",'["Survivor1_DZ"] spawn EAT_SkinChanger;']],"1","1"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_skinMenu2 = EAT_skinMenu2 + [["< Back", [], "#USER:EAT_skinMenu", -5, [["expression", ""]], "1", "1"]];

	// Weapon menu select
		EAT_weaponMenu = [["",true]];
		EAT_weaponMenu = EAT_weaponMenu + [["-- Weapons Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_weaponMenu = EAT_weaponMenu + [["Admin/Mod Loadouts >>",[],"#USER:EAT_adminLoadoutsMenu", -5, [["expression", ""]], "1", "1"]];
		EAT_weaponMenu = EAT_weaponMenu + [["Primary Weapons Menu >>",[],"#USER:EAT_primaryWeaponMenu", -5, [["expression", ""]], "1", "1"]];
		EAT_weaponMenu = EAT_weaponMenu + [["Secondary Weapons Menu >>",[],"#USER:EAT_secondaryWeaponMenu", -5, [["expression", ""]], "1", "1"]];
		EAT_weaponMenu = EAT_weaponMenu + [["Gear/Items Menu >>",[],"#USER:EAT_gearMenu", -5, [["expression", ""]], "1", "1"]];
		EAT_weaponMenu = EAT_weaponMenu + [["Delete all gear", [],"", -5, [["expression","call EAT_RemoveGear;"]], "1", "1"]];
		EAT_weaponMenu = EAT_weaponMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_weaponMenu = EAT_weaponMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

		// Main weapons like the M4
		// Entry Format:["Name", [],"", -5, [["expression", format[_EXECweapons,"Gun_Calss_Name","Ammo_Class_Name","Explosive_Round_Class_Name"]]], "1", "1"]];
		// If there is no explosive 203 round then put "nil" in place of "Explosive_Round_Class_Name"
		EAT_primaryWeaponMenu = [["",true]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["-- Primary Weapons --", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["M4 Holo", [],"", -5, [["expression",'["M4A1_HWS_GL_camo","30Rnd_556x45_Stanag","1Rnd_HE_M203"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["M4A1_DZ GL SD Camo", [],"", -5, [["expression",'["M4A1_HWS_GL_SD_Camo","30Rnd_556x45_StanagSD","1Rnd_HE_M203"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["Sa58V ACOG", [],"", -5, [["expression",'["Sa58V_RCO_EP1","30Rnd_762x39_SA58"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["AKM Kobra", [],"", -5, [["expression",'["AKM_Kobra_DZ","30Rnd_762x39_AK47"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["FN FAL", [],"", -5, [["expression",'["FNFAL_CCO_DZ","20Rnd_762x51_FNFAL"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["Mk 48", [],"", -5, [["expression",'["Mk48_CCO_DZ","100Rnd_762x51_M240"] call EAT_AddWeapon;']], "1", "1"]];
		//EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["AS50", [],"", -5, [["expression",'["BAF_AS50_scoped","5Rnd_127x99_AS50"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [[".338 LAPUA", [],"", -5, [["expression",'["BAF_LRR_scoped","5Rnd_86x70_L115A1"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["DMR_DZ", [],"", -5, [["expression",'["DMR_DZ","20Rnd_762x51_DMR"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["Secondary Weapons", [], "#USER:EAT_secondaryWeaponMenu", -5, [["expression", ""]], "1", "1"]];

	// Sidearm weapons like the Makarov
		EAT_secondaryWeaponMenu = [["",true]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["-- Secondary Weapons --", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["PDW SD", [],"", -5, [["expression",'["UZI_SD_EP1","30Rnd_9x19_UZI_SD"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["PDW", [],"", -5, [["expression",'["PDW_DZ","30Rnd_9x19_UZI"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["Glock", [],"", -5, [["expression",'["G17_FL_DZ","17Rnd_9x19_glock17"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["M9_DZ SD", [],"", -5, [["expression",'["M9_SD_DZ","15Rnd_9x19_M9SD"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["Makarov_DZ", [],"", -5, [["expression",'["Makarov_DZ","8Rnd_9x18_Makarov"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["Makarov_DZ SD", [],"", -5, [["expression",'["Makarov_SD_DZ","8Rnd_9x18_Makarov"] call EAT_AddWeapon;']], "1", "1"]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["Gear/Items", [], "#USER:EAT_gearMenu", -5, [["expression", ""]], "1", "1"]];

	// Menu for spawning items to the admin like bags and tools
		EAT_gearMenu = [["",true]];
		EAT_gearMenu = EAT_gearMenu + [["-- Gear Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_gearMenu = EAT_gearMenu + [["ToolBelt gear", [],"", -5, [["expression","call EAT_AddTools;"]], "1", "1"]];
		EAT_gearMenu = EAT_gearMenu + [["Medical gear", [],"", -5, [["expression","call EAT_AddMeds;"]], "1", "1"]];
		EAT_gearMenu = EAT_gearMenu + [["Alice Pack", [],"", -5, [["expression",'["DZ_ALICE_Pack_EP1"] call EAT_AddBackPack;']], "1", "1"]];
		EAT_gearMenu = EAT_gearMenu + [["Coyote Pack", [],"", -5, [["expression",'["DZ_Backpack_EP1"] call EAT_AddBackPack;']], "1", "1"]];
		EAT_gearMenu = EAT_gearMenu + [["Large Gun Bag", [],"", -5, [["expression",'["DZ_LargeGunBag_EP1"] call EAT_AddBackPack;']], "1", "1"]];
		EAT_gearMenu = EAT_gearMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
		EAT_gearMenu = EAT_gearMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];
		
		EAT_adminLoadoutsMenu =
		[
			["",true],
			["-- Admin Loadout Menu --", [], "", -5, [["expression", ""]], "1", "0"],
			["DMR",[],"",-5,[["expression", "['DMR_DZ','M9_SD_DZ'] call EAT_Loadouts;"]],"1","1"],
			["Lapua",[],"",-5,[["expression", "['BAF_LRR_scoped','M9_SD_DZ'] call EAT_Loadouts;"]],"1","1"],
			["Mk48 CCO",[],"",-5,[["expression", "['Mk48_CCO_DZ','M9_SD_DZ'] call EAT_Loadouts;"]],"1","1"],
			//["M107",[],"",-5,[["expression", "['M107_DZ','M9_SD_DZ'] call EAT_Loadouts;"]],"1","1"],
			//["AS50",[],"",-5,[["expression", "['BAF_AS50_scoped','M9_SD_DZ'] call EAT_Loadouts;"]],"1","1"],
			["FN FAL CCO",[],"",-5,[["expression", "['FNFAL_CCO_DZ','M9_SD_DZ'] call EAT_Loadouts;"]],"1","1"],
			["Sa58 ACOG",[],"",-5,[["expression", "['Sa58V_RCO_EP1','M9_SD_DZ'] call EAT_Loadouts;"]],"1","1"],
			["", [], "", -5, [["expression", ""]], "1", "0"],
			["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]
		];
	};
	showCommandingMenu "#USER:EAT_mainMenu";
};
