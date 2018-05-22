class X2Action_ExplodingUnitDeathAction_DeathOnly extends X2Action_Death deprecated;
/*
var private XComGameStateContext_Ability FutureAbilityContext;
var private XComGameState FutureVisualizeGameState;
var private bool bIsUnconscious;

static function bool AllowOverrideActionDeath(VisualizationActionMetadata ActionMetadata, XComGameStateContext Context)
{
	return true;
}

function Init()
{
	local XComGameStateContext ChainContext;
	local XComGameStateContext_Ability TestContext;
	local XComGameState_Unit UnitState;

	super.Init();

	ChainContext = StateChangeContext;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectId(Unit.ObjectID));

	for( ChainContext = StateChangeContext.GetNextStateInEventChain().GetContext(); ChainContext != none && !ChainContext.bLastEventInChain; ChainContext = ChainContext.GetNextStateInEventChain().GetContext() )
	{
		TestContext = XComGameStateContext_Ability(ChainContext);

		if( TestContext != None &&
			TestContext.InputContext.AbilityTemplateName == GetAssociatedAbilityName() &&
			TestContext.InputContext.PrimaryTarget.ObjectID == Unit.ObjectID )
		{
			if( UnitState != none && !UnitState.IsUnconscious() ) // only set the state and context if DeathExplosion should be used
			{
				// We are looking for an associated (Gatekeeper, Sectopod, etc.) Unit's DeathExplosion ability that is being brought forward
				FutureAbilityContext = TestContext;
				FutureVisualizeGameState = TestContext.AssociatedState;
			}
			else if( UnitState != none && UnitState.IsUnconscious() ) // if unconscious, instead set that
				bIsUnconscious = true;
			break;
		}
	}
}

simulated function name GetAssociatedAbilityName()
{
	return 'DeathExplosion';
}

simulated function Name ComputeAnimationToPlay()
{
	// Always allow new animations to play.  (fixes sectopod never breaking out of its wrath cannon idle)
	UnitPawn.GetAnimTreeController().SetAllowNewAnimations(true);

	if( bIsUnconscious ) // if unconscious, 
		return 'HL_DeathDefault';

	return 'HL_Death';
}

event OnAnimNotify(AnimNotify ReceiveNotify)
{	
	super.OnAnimNotify(ReceiveNotify);

	if( (XComAnimNotify_NotifyTarget(ReceiveNotify) != none) && (FutureAbilityContext != none) )
	{
		// Notify the targets of the future explosion abiilty
		// A history index is required but -1 means the notify doesn't need to be associated
		// with a specific history
		DoNotifyTargetsAbilityApplied(FutureVisualizeGameState, FutureAbilityContext, -1);
		bWaitUntilNotified = false;
	}
	else if( (XComAnimNotify_NotifyTarget(ReceiveNotify) != none) && bIsUnconscious )
		bWaitUntilNotified = false; // don't tell the game to keep waiting if the unit is unconscious because there's no FutureAbilityContext
}

defaultproperties
{
	OutputEventIDs.Add( "Visualizer_WorldDamage" )		//World damage application

	bWaitUntilNotified=true
}*/