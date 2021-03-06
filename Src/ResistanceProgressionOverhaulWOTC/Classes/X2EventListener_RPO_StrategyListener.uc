class X2EventListener_RPO_StrategyListener extends X2EventListener;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Templates;

    Templates.AddItem(CreateListenerTemplate_OnCleanupTacticalMission());

    return Templates;
}

static function CHEventListenerTemplate CreateListenerTemplate_OnCleanupTacticalMission()
{
    local CHEventListenerTemplate Template;

    `CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'RPOCleanupTacticalMission');

    Template.RegisterInTactical = true;
    Template.RegisterInStrategy = false;

    Template.AddCHEvent('CleanupTacticalMission', OnCleanupTacticalMission, ELD_Immediate);
    `LOG("Register Event CleanupTacticalMission",, 'RPO');

    return Template;
}

static function EventListenerReturn OnCleanupTacticalMission(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	//local XComGameState						NewGameState;
	local XComGameStateHistory				History;
    local XComGameState_BattleData			BattleData;
	local XGBattle_SP						Battle;
	local XGAIPlayer_TheLost				LostPlayer;
	local X2LootTableManager				LootManager;
	local array<XComGameState_Unit>			arrUnits;
	local XComGameState_Unit				UnitState;
	local name								EffectName, LootTableName, LootRoll;
	local X2CharacterTemplate				UnitTemplate;
	local LootReference						UnitLoot;
	local array<name>						RolledLoot;
	
	History = `XCOMHISTORY;
	//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Updating BattleData to add captured enemies as loot");
	BattleData = XComGameState_BattleData(EventData);
	BattleData = XComGameState_BattleData(GameState.ModifyStateObject(class'XComGameState_BattleData', BattleData.ObjectID));
	Battle = XGBattle_SP(`BATTLE);
	LootManager = class'X2LootTableManager'.static.GetLootTableManager();

	`LOG(GetFuncName(), , 'RPO');
	
	if(BattleData.IsMultiplayer())
	{
		return ELR_NoInterrupt; // How are we in multiplayer?
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
			`LOG("Checking" @ UnitState.ObjectID @ "'s" @ EffectName @ "for match with:" @ class'X2StatusEffects'.default.UnconsciousName, , 'RPO');
			if (EffectName == class'X2StatusEffects'.default.UnconsciousName) // If the effect name is the UnconsciousName (*necessarily* true since ArcThrower uses the same variable)
			{
				UnitTemplate = UnitState.GetMyTemplate(); // Get the unit's template
				foreach UnitTemplate.Loot.LootReferences(UnitLoot) // For each LootReference belonging to the unit's template
				{
					if ( InStr(string(UnitLoot.LootTableName),"BaseLoot") != INDEX_NONE ) // Is it the corpse loot table?
					{
						LootTableName = name(Repl(string(UnitLoot.LootTableName), "BaseLoot", "CapturedLoot")); // Get the CapturedLoot table's name
						LootManager.RollForLootTable(LootTableName, RolledLoot); // Roll on the CapturedLoot table
						`LOG("LootManager rolling on" @ LootTableName @ ". Loot found:" @ RolledLoot[0], , 'RPO');
						break; // There's only one corpse loot table, so we can skip scanning the rest
					}
				}
				break; // Each enemy only needs one unconscious effect on it, so we can ignore the rest of the effects
			}
		}
	}

	if (RolledLoot.Length > 0)
	{
		foreach RolledLoot(LootRoll) // For every item in the roll
		{
			BattleData.AutoLootBucket.AddItem(LootRoll); // Add the loot name to the battle data's loot bucket - treat as AutoLoot since I don't know how to block out evacs for now
		}
	}

	History.AddGameStateToHistory(GameState);
	History.CleanupPendingGameState(GameState);

	return ELR_NoInterrupt;
}