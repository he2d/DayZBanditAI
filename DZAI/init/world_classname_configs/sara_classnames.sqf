/*
	Sahrani Classname Configuration
	
	Last updated: 1:14 PM 6/3/2013
	
*/

private ["_modname","_craftingBooks","_newAISkins","_newRifles1","_newRifles2","_newRifles3","_newSkinItems"];
_modname = toLower format ["%1",DZAI_modName];


_newAISkins = ["Rocket_DZ","BanditSkin_DZ","SniperBandit_DZ","SniperBanditW_DZ","Sniper1W_DZ","BanditSkinW_DZ"];
_newSkinItems = ["Skin_Rocket_DZ","Skin_BanditSkin_DZ"];
_craftingBooks = [["ItemCraftingBook",0.10],["ItemCraftingBook2",0.10],["ItemCraftingBook3",0.05]];

for "_i" from 0 to ((count _newAISkins) - 1) do {DZAI_BanditTypes set [(count DZAI_BanditTypes),(_newAISkins select _i)];};
DZAI_Edibles = DZAI_Edibles - ["FoodCanUnlabeled","FoodPistachio","FoodNutmix","FoodMRE"];
for "_i" from 0 to ((count _newSkinItems) - 1) do {DZAI_SkinLoot set [(count DZAI_SkinLoot),(_newSkinItems select _i)];};
DZAI_MiscItemS set [(count DZAI_MiscItemS),"ItemNails"];
 
for "_i" from 0 to ((count _craftingBooks) - 1) do {DZAI_tools0 set [(count DZAI_tools0),(_craftingBooks select _i)];};
for "_i" from 0 to ((count _craftingBooks) - 1) do {DZAI_tools1 set [(count DZAI_tools1),(_craftingBooks select _i)];};

diag_log "Sahrani classnames loaded.";
