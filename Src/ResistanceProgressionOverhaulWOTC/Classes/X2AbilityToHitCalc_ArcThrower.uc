class X2AbilityToHitCalc_ArcThrower extends X2AbilityToHitCalc config(RPO_WOTC);

var localized string BaseChance;
var localized string HealthModifier;

var config int BASE_CHANCE;			//  base chance before hp adjustments
var config int HP_THRESHOLD_CHANCE;	//  additional chance when target hp <= HP_THRESHOLD
var config int HP_THRESHOLD;		//  hp amount where things are easier while <= this value
var config int HP_MODIFIER;			//  amount to add to chance per point of hp below HP_THRESHOLD
var config int CLAMPED_MIN;			//  absolute minimum hit chance
var config int CLAMPED_MAX;			//  absolute maximum hit chance

function RollForAbilityHit(XComGameState_Ability kAbility, AvailableTarget kTarget, out AbilityResultContext ResultContext)
{
	local int Chance, RandRoll;
	//local XComGameState_Unit TargetUnit;
	//local XComGameStateHistory History;
	local ShotBreakdown m_ShotBreakdown;

	ResultContext.HitResult = eHit_Miss;
	Chance = GetHitChance(kAbility, kTarget, m_ShotBreakdown, true);

	if (`CHEATMGR != none)
	{
		if (`CHEATMGR.bDeadEye)
		{
			`log("DeadEye cheat forcing a hit.", true, 'XCom_HitRolls');
			ResultContext.HitResult = eHit_Success;
			return;
		}
		if (`CHEATMGR.bNoLuck)
		{
			`log("NoLuck cheat forcing a miss.", true, 'XCom_HitRolls');
			ResultContext.HitResult = eHit_Miss;			
			return;
		}
	}

	if (Chance > 0)
	{
		RandRoll = `SYNC_RAND_TYPED(100, ESyncRandType_Generic);
		`log("StasisLance hit chance" @ Chance @ "rolled" @ RandRoll $ "...", true, 'XCom_HitRolls');
		if (RandRoll <= Chance)
		{
			ResultContext.HitResult = eHit_Success;
			`log("      Success!!!", true, 'XCom_HitRolls');
		}
		else
		{
			`log("      Failed.", true, 'XCom_HitRolls');
		}
	}
	else
	{
		`log("StasisLance hit chance was 0.", true, 'XCom_HitRolls');
	}
}

protected function int GetHitChance(XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional bool bDebugLog = false)
{
	local XComGameState_Unit TargetUnit;
	local XComGameStateHistory History;
	local int TargetHP, Chance, TotalMod;
	local ShotBreakdown EmptyShotBreakdown;

	History = `XCOMHISTORY;
	TargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(kTarget.PrimaryTarget.ObjectID));
	m_ShotBreakdown = EmptyShotBreakdown;

	if (TargetUnit != none && !`XENGINE.IsMultiplayerGame())
	{
		AddModifier(default.BASE_CHANCE, class'XLocalizedData'.default.BaseChance, m_ShotBreakdown, eHit_Success, bDebugLog);


		TargetHP = TargetUnit.GetCurrentStat(eStat_HP);
		if (TargetHP <= default.HP_THRESHOLD)
		{
			Chance = default.BASE_CHANCE + default.HP_THRESHOLD_CHANCE + (default.HP_THRESHOLD - TargetHP) * HP_MODIFIER;
		}
		else
		{
			Chance = default.BASE_CHANCE;
		}
		Chance = Clamp(Chance, default.CLAMPED_MIN, default.CLAMPED_MAX);

		if (Chance > default.BASE_CHANCE)
			TotalMod = Chance - default.BASE_CHANCE;
		else
			TotalMod = (default.BASE_CHANCE - Chance) * -1;

		AddModifier(TotalMod, default.HealthModifier, m_ShotBreakdown, eHit_Success, bDebugLog);
		FinalizeHitChance(m_ShotBreakdown, bDebugLog);
	}
	
	return m_ShotBreakdown.FinalHitChance;
}