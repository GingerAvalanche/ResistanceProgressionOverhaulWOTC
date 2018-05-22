class X2Action_ExplodingUnitDeathAction_RPO extends X2Action_ExplodingUnitDeathAction;

simulated function Name ComputeAnimationToPlay()
{
	// Always allow new animations to play.  (fixes sectopod never breaking out of its wrath cannon idle)
	UnitPawn.GetAnimTreeController().SetAllowNewAnimations(true);

	if( XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectId(Unit.ObjectID)).IsUnconscious() )
	{
		bWaitUntilNotified = false;
		return 'HL_DeathDefault';
	}

	return 'HL_Death';
}