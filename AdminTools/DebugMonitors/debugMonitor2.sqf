[] spawn {

	_serverName = "SERVER NAME";
	_teamspeak = "000.000.000.000"; // DELETE line 50 if you don't want this to show
	_restartTime = 180; //total time before server restart (3hrs = 180 minutes)
	_pic = "";

	if (isNil "DebugMonitorActive") then {DebugMonitorActive = true;};
	
	EAT_DebugMonitorToggle = {
		DebugMonitorActive = !DebugMonitorActive;
		hintSilent '';
	};
	
	waitUntil {!isNull (findDisplay 46)};
	Ins_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 210) then {call EAT_DebugMonitorToggle;};"];
	
	while {true} do {
		if (DebugMonitorActive) then {
			_time = (round(_restartTime-(serverTime)/60));
			_hours = (floor(_time/60));
			_minutes = (_time - (_hours * 60));

			if (player == vehicle player) then {
				_pic = (getText (configFile >> "cfgWeapons" >> (currentWeapon player) >> "picture"));
			} else {
				_pic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "picture"));
			};
					
			switch(_minutes) do
			{
				case 9: {_minutes = "09"};
				case 8: {_minutes = "08"};
				case 7: {_minutes = "07"};
				case 6: {_minutes = "06"};
				case 5: {_minutes = "05"};
				case 4: {_minutes = "04"};
				case 3: {_minutes = "03"};
				case 2: {_minutes = "02"};
				case 1: {_minutes = "01"};
				case 0: {_minutes = "00"};
			};
			
			hintSilent parseText format ["
				<t size='1.2' font='Bitstream' align='center' color='#718d67'>%12</t><br/>
				<t size='1' font='Bitstream' align='center' color='#e5e5e5'>%1 Players Online: </t><br/>
				<img size='3' align='Center' image='%11'/><br/>
				<t size='1' font='Bitstream' align='left' color='#f00c0c'>Blood: </t><t size='1' font='Bitstream' align='right' color='#f00c0c'>%5</t><br/>
				<t size='1' font='Bitstream' align='left' color='#007feb'>Humanity: </t><t size='1' font='Bitstream' align='right' color='#007feb'>%6</t><br/>
				<t size='1' font='Bitstream' align='left' color='#e5e5e5'>FPS: </t><t size='1' font='Bitstream' align='right' color='#e5e5e5'>%7</t><br/>
				<t size='1' font='Bitstream' align='left' color='#e5e5e5'>Murders: </t><t size='1' font='Bitstream' align='right' color='#e5e5e5'>%3</t><br/>
				<t size='1' font='Bitstream' align='left' color='#e5e5e5'>Bandit Kills: </t><t size='1' font='Bitstream' align='right' color='#e5e5e5'>%4</t><br/>
				<t size='1' font='Bitstream' align='left' color='#e5e5e5'>Zombie Kills: </t><t size='1' font='Bitstream' align='right' color='#e5e5e5'>%2</t><br/>
				<t size='1' font='Bitstream' align='left' color='#ffd863'>Server restart in: </t><t size='1' font='Bitstream' align='right' color='#ffd863'>%8:%9</t><br/><br/>
				<t size='.80' font='Bitstream' align='left' color='#5882FA'>Teamspeak:  </t><t size='.80' font='Bitstream' align='right' color='#5882FA'>%13</t>",
					
				(count playableUnits), // 1
				(player getVariable['zombieKills', 0]), // 2
				(player getVariable['humanKills', 0]), // 3
				(player getVariable['banditKills', 0]), // 4
				(player getVariable['USEC_BloodQty', r_player_blood]), // 5
				(player getVariable['humanity', 0]), // 6
				(round diag_fps), // 7
				_hours, // 8
				_minutes, // 9
				dayz_playerName, // 10
				_pic, // 11
				_serverName, // 12
				_teamspeak // 13
			];
			uiSleep 1;
		};
	};
};