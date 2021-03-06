/*
	respawnBandits
	
	Usage: [_unitGroup,_trigger,_spawnType] call respawnBandits;
	
	Description: Called internally by fnc_banditAIRespawn. Calls fnc_createAI to respawn a unit near a randomly selected building from a stored reference location.
	
	Last updated: 11:15 PM 6/23/2013
*/

private ["_unitGroup","_trigger","_grpArray","_triggerPos","_patrolDist","_gradeChances","_spawnPositions","_p","_unit","_pos","_spawnType","_startTime","_maxUnits","_minAI","_addAI","_totalAI"];
if (!isServer) exitWith {};

_startTime = diag_tickTime;

_unitGroup = _this select 0;
_trigger = _this select 1;
_maxUnits = _this select 2;

_triggerPos = getpos _trigger;
_patrolDist = _trigger getVariable ["patrolDist",150];
_gradeChances = _trigger getVariable ["gradeChances",DZAI_gradeChances1];
_spawnPositions = _trigger getVariable "locationArray";
_spawnType = _trigger getVariable ["spawnType",2];

_minAI = _maxUnits select 0;
_addAI = _maxUnits select 1;
_totalAI = (_minAI + round(random _addAI));

//Select spawn position
_p = _spawnPositions call BIS_fnc_selectRandom;
_pos = [0,0,0];
if (_spawnType == 2) then {
	_pos = [_p, 1, 100, 2, 0, 2000, 0] call BIS_fnc_findSafePos;
	if (DZAI_debugLevel > 1) then {diag_log "DZAI Extended Debug: Respawning AI from building positions (respawnBandits).";};
} else {
	_pos = _p;
	if (DZAI_debugLevel > 1) then {diag_log "DZAI Extended Debug: Respawning AI from predefined positions (respawnBandits).";};
};

//Respawn the group
[_totalAI,_unitGroup,_pos,_trigger,_gradeChances] call fnc_createUnit;
if (DZAI_debugLevel > 1) then {diag_log format["DZAI Extended Debug: AI %1 of %2 spawned (spawnBandits).",_i,_totalAI];};

//Update AI count
_unitGroup setVariable ["groupSize",_totalAI];
DZAI_numAIUnits = DZAI_numAIUnits + _totalAI;
if (DZAI_debugLevel > 1) then {diag_log format ["DZAI Extended Debug: Created group %1 of size %2.",_unitGroup,_totalAI];};

if ((count (waypoints _unitGroup)) < 2) then {
	if ((typeName _patroldist) == "SCALAR") then {
		0 = [_unitGroup,_triggerPos,_patrolDist,DZAI_debugMarkers] spawn fnc_BIN_taskPatrol;
	} else {
		0 = [_unitGroup,_patrolDist,DZAI_debugMarkers] spawn fnc_DZAI_customPatrol;
	};
};
if (DZAI_debugLevel > 0) then {diag_log format["DZAI Debug: %2 AI units respawned in %1 seconds (respawnBandits).",diag_tickTime - _startTime,_totalAI];};

true
