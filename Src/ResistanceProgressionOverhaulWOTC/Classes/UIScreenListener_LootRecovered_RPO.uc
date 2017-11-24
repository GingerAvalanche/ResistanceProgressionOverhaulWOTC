class UIScreenListener_LootRecovered_RPO extends UIScreenListener;

// DEPRECATED
/*
event OnInit(UIScreen Screen)
{
	//local UIInventory_LootRecovered			ParentScreen;
	local XComGameStateHistory				History;
	local XComGameState_BattleData			BattleData;
	//local int								iCaptured, iTotal, i;
	local array<XComGameState_Unit>			arrUnits;
	local XComGameState_Unit				UnitState;
	//local StateObjectReference			AffectedUnitEffect;
	local name								EffectName, LootTableName, LootRoll;
	local XGBattle_SP						Battle;
	local XGAIPlayer_TheLost				LostPlayer;
	//local X2Effect_Persistent				PersistentEffect;
	//local XComGameState_Effect			PersistentState;
	local X2CharacterTemplate				UnitTemplate;
	local LootReference						UnitLoot;
	local X2LootTableManager				LootManager;
	local array<name>						RolledLoot;

	//ParentScreen = UIInventory_LootRecovered(Screen);
	
	History = `XCOMHISTORY;
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	Battle = XGBattle_SP(`BATTLE);
	LootManager = class'X2LootTableManager'.static.GetLootTableManager();

	if(BattleData.IsMultiplayer())
	{
		return; // How are we in multiplayer?
	}
	else
	{
		Battle.GetAIPlayer().GetOriginalUnits(arrUnits); // Dump all enemies into an array

		LostPlayer = Battle.GetTheLostPlayer();
		if (LostPlayer != none)
			LostPlayer.GetOriginalUnits(arrUnits); // Dump all Lost enemies into an array
	}

	foreach arrUnits(UnitState) // For every enemy in the BattleData
	{
		// Try AffectedByEffectNames first, it'll be easier on the processor if it works
		//foreach UnitState.AffectedByEffects(AffectedUnitEffect)
		//{
			//PersistentState = X2Effect_Persistent(History.GetGameStateForObjectID(AffectedUnitEffect.ObjectID);
			//PersistentEffect = PersistentState.GetMyTemplate();
			//if (PersistentEffect.EffectName == class'X2StatusEffects'.default.UnconsciousName)
			//{
			//}
		//}
		foreach UnitState.AffectedByEffectNames(EffectName) // For every effect name on this enemy
		{
			if (EffectName == class'X2StatusEffects'.default.UnconsciousName) // If the effect name is the UnconsciousName (*necessarily* true since ArcThrower uses the same variable)
			{
				UnitTemplate = UnitState.GetMyTemplate(); // Get the unit's template
				foreach UnitTemplate.Loot.LootReferences(UnitLoot) // For each LootReference belonging to the unit's template
				{
					if ( InStr(string(UnitLoot.LootTableName),"BaseLoot") != INDEX_NONE ) // Is it the corpse loot table?
					{
						LootTableName = name(Repl(string(UnitLoot.LootTableName), "BaseLoot", "CapturedLoot")); // Get the CapturedLoot table's name
						LootManager.RollForLootTable(LootTableName, RolledLoot); // Roll on the CapturedLoot table
						foreach RolledLoot(LootRoll) // For every item in the roll (should only ever be one, but may change later for reasons unknown right now)
						{
							BattleData.AutoLootBucket.AddItem(LootRoll); // Add the loot name to the battle data's loot bucket - treat as AutoLoot since I don't know how to block out evacs for now)
						}
						break; // There's only one corpse loot table, so we can skip scanning the rest
					}
				}
				break; // Each enemy can only have one unconscious effect on it at a time, so we can ignore the rest of the effects
			}
		}
	}
}

defaultproperties
{
	ScreenClass = class'UIInventory_LootRecovered';
}*/