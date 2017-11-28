class X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC extends X2StrategyElement config(GameData_RPO);

var config bool bBuildAmmoInEngineering;
var config bool bBuildGrenadesInEngineering;
var config bool bBuildHeavyWeaponsInEngineering;
var config bool bBuildVestsInEngineering;
var config bool bBuildArmorInEngineering;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	// Proving Ground Techs
	Techs.AddItem(CreateArcThrowingTemplate());
	//Techs.AddItem(CreateAPRoundsTemplate()); // Replacing random ammo tech template with AP rounds tech template instead
	//Techs.AddItem(CreateBluescreenRoundsTemplate()); // Replacing Bluescreen tech template with bluescreen rounds tech template instead
	Techs.AddItem(CreateDragonRoundsTemplate());
	techs.AddItem(CreateHolotargetRoundsTemplate());
	Techs.AddItem(CreateTalonRoundsTemplate());
	Techs.AddItem(CreateTracerRoundsTemplate());
	Techs.AddItem(CreateVenomRoundsTemplate());
	//Techs.AddItem(CreateAcidGrenadeTemplate()); // Replacing random grenade tech template with acid grenade tech template instead
	Techs.AddItem(CreateGasGrenadeTemplate());
	Techs.AddItem(CreateIncendiaryGrenadeTemplate());
	Techs.AddItem(CreateBluescreenGrenadeTemplate());
	Techs.AddItem(CreatePsiBombGrenadeTemplate());
	Techs.AddItem(CreateProximityMineTemplate());
	//Techs.AddItem(CreateFlamethrowerTemplate()); // Replacing random heavy weapon tech template with flamethrower tech template instead
	Techs.AddItem(CreateShredderGunTemplate());
	//Techs.AddItem(CreateHellfireProjectorTemplate()); // Replacing random powered weapon tech template with hellfire projector tech template instead
	Techs.AddItem(CreateBlasterLauncherTemplate());
	Techs.AddItem(CreatePlasmaBlasterTemplate());
	Techs.AddItem(CreateShredstormCannonTemplate());
	Techs.AddItem(CreateFrenzyVestTemplate());
	//Techs.AddItem(CreateHazmatVestTemplate()); // Replacing random vest tech template with hazmat vest tech template instead
	Techs.AddItem(CreateStasisVestTemplate());
	Techs.AddItem(CreatePlatedVestTemplate());
	Techs.AddItem(CreateHellweaveVestTemplate());
	Techs.AddItem(CreateLightEleriumArmorTemplate());
	Techs.AddItem(CreateMediumEleriumArmorTemplate());
	Techs.AddItem(CreateHeavyEleriumArmorTemplate());
	
	// Interrogation Techs
	Techs.AddItem(CreateInterrogateAdventTrooperTemplate());
	Techs.AddItem(CreateInterrogateAdventStunLancerTemplate());
	Techs.AddItem(CreateInterrogateAdventCaptainTemplate());
	Techs.AddItem(CreateInterrogateAdventShieldbearerTemplate());
	Techs.AddItem(CreateInterrogateAdventPriestTemplate());
	Techs.AddItem(CreateInterrogateAdventPurifierTemplate());
	Techs.AddItem(CreateInterrogateAndromedonTemplate());
	Techs.AddItem(CreateInterrogateArchonTemplate());
	Techs.AddItem(CreateInterrogateBerserkerTemplate());
	Techs.AddItem(CreateInterrogateChryssalidTemplate());
	Techs.AddItem(CreateInterrogateCodexTemplate());
	Techs.AddItem(CreateInterrogateFacelessTemplate());
	Techs.AddItem(CreateInterrogateGatekeeperTemplate());
	Techs.AddItem(CreateInterrogateMutonTemplate());
	Techs.AddItem(CreateInterrogateSectoidTemplate());
	Techs.AddItem(CreateInterrogateSpectreTemplate());
	Techs.AddItem(CreateInterrogateViperTemplate());
	Techs.AddItem(CreateInterrogateAdventMEC());
	Techs.AddItem(CreateInterrogateAdventMECMk2());
	Techs.AddItem(CreateInterrogateSectopod());
	Techs.AddItem(CreateInterrogateAdventTurret());

	return Techs;
}

//---------------------------------------------------------------------------------------
// Helper function for calculating project time
static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

// #######################################################################################
// -------------------- PROVING GROUND TECHS ---------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateArcThrowingTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts, Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ArcThrowing');
	Template.PointsToComplete = StafferXDays(1, 11);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 1;
	
	Template.TechAvailableNarrative = "X2NarrativeMoments.Strategy.Shen_Support_Modify_Skulljack";

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('Skullmining');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 100;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

//static function X2DataTemplate CreateAPRoundsTemplate() // Replacing random ammo tech template with AP rounds tech template instead

//static function X2DataTemplate CreateBluescreenRoundsTemplate() // Replacing Bluescreen tech template with bluescreen rounds tech template instead

static function X2DataTemplate CreateDragonRoundsTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'DragonRoundsTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildAmmoInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('IncendiaryRounds');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventPurifier');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateHolotargetRoundsTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'HolotargetRoundsTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildAmmoInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('HolotargetRounds');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventStunLancer');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateTalonRoundsTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'TalonRoundsTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildAmmoInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('TalonRounds');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyBerserker');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateTracerRoundsTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'TracerRoundsTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildAmmoInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('TracerRounds');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AdventCaptainInterrogation');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateVenomRoundsTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'VenomRoundsTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildAmmoInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('VenomRounds');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyViper');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

//static function X2DataTemplate CreateAcidGrenadeTemplate() // Replacing random grenade tech template with acid grenade tech template instead

static function X2DataTemplate CreateGasGrenadeTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'GasGrenadeTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildGrenadesInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('GasGrenade');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyViper');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateIncendiaryGrenadeTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'IncendiaryGrenadeTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildGrenadesInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('Firebomb');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventPurifier');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateBluescreenGrenadeTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BluescreenGrenadeTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildGrenadesInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('EMPGrenade');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMEC');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreatePsiBombGrenadeTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'PsiBombGrenadeTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildGrenadesInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('PsiBombGrenade');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AvatarInterrogation');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateProximityMineTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ProximityMineTech');
	Template.PointsToComplete = StafferXDays(1, 10);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildGrenadesInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('ProximityMine');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyChryssalis');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

//static function X2DataTemplate CreateFlamethrowerTemplate() // Replacing random heavy weapon tech template with flamethrower tech template instead

static function X2DataTemplate CreateShredderGunTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ShredderGunTech');
	Template.PointsToComplete = StafferXDays(1, 12);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildHeavyWeaponsInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('ShredderGun');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyBerserker');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

//static function X2DataTemplate CreateHellfireProjectorTemplate() // Replacing random powered weapon tech template with hellfire projector tech template instead

static function X2DataTemplate CreateBlasterLauncherTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BlasterLauncherTech');
	Template.PointsToComplete = StafferXDays(1, 15);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildHeavyWeaponsInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('BlasterLauncher');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AdventMECMk2Interrogation');

	// Cost
 	Resources.ItemTemplateName = 'Supplies';
 	Resources.Quantity = 50;
 	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreatePlasmaBlasterTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'PlasmaBlasterTech');
	Template.PointsToComplete = StafferXDays(1, 15);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildHeavyWeaponsInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('PlasmaBlaster');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AndromedonInterrogation');

	// Cost
 	Resources.ItemTemplateName = 'Supplies';
 	Resources.Quantity = 50;
 	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateShredstormCannonTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ShredstormCannonTech');
	Template.PointsToComplete = StafferXDays(1, 15);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.SortingTier = 3;

	if ( !default.bBuildHeavyWeaponsInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('ShredstormCannon');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('SectopodInterrogation');

	// Cost
 	Resources.ItemTemplateName = 'Supplies';
 	Resources.Quantity = 50;
 	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateFrenzyVestTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'FrenzyVestTech');
	Template.PointsToComplete = StafferXDays(1, 12);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.SortingTier = 3;

	if ( !default.bBuildVestsInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('FrenzyVest');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyArchon');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

//static function X2DataTemplate CreateHazmatVestTemplate() // Replacing random vest tech template with hazmat vest tech template instead

static function X2DataTemplate CreateStasisVestTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'StasisVestTech');
	Template.PointsToComplete = StafferXDays(1, 12);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.SortingTier = 3;

	if ( !default.bBuildVestsInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('StasisVest');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyFaceless');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreatePlatedVestTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'PlatedVestTech');
	Template.PointsToComplete = StafferXDays(1, 12);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.SortingTier = 3;

	if ( !default.bBuildVestsInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('PlatedVest');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventShieldbearer');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateHellweaveVestTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'HellweaveVestTech');
	Template.PointsToComplete = StafferXDays(1, 12);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.SortingTier = 3;

	if ( !default.bBuildVestsInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('Hellweave');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventPurifier');

	// Cost
	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateLightEleriumArmorTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'LightEleriumArmorTech');
	Template.PointsToComplete = StafferXDays(1, 12);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.SortingTier = 3;

	if ( !default.bBuildArmorInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('LightEleriumArmor');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('SpectreInterrogation');
	Template.Requirements.RequiredTechs.AddItem('LightPoweredArmor');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 75;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = 15;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = 10;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'CorpseSpectre';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateMediumEleriumArmorTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'MediumEleriumArmorTech');
	Template.PointsToComplete = StafferXDays(1, 12);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.SortingTier = 3;

	if ( !default.bBuildArmorInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('MediumEleriumArmor');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('GatekeeperInterrogation');
	Template.Requirements.RequiredTechs.AddItem('PoweredArmor');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 75;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = 15;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = 10;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'CorpseGatekeeper';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateHeavyEleriumArmorTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'HeavyEleriumArmorTech');
	Template.PointsToComplete = StafferXDays(1, 12);
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.SortingTier = 3;

	if ( !default.bBuildArmorInEngineering )
	{
		Template.bRepeatable = true;
		Template.ResearchCompletedFn = GiveRandomItemReward;

		// Item Reward
		Template.ItemRewards.AddItem('HeavyEleriumArmor');
	}
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AndromedonInterrogation');
	Template.Requirements.RequiredTechs.AddItem('HeavyPoweredArmor');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 75;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = 15;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = 10;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'CorpseAndromedon';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

// #######################################################################################
// -------------------- AUTOPSY TECHS ----------------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateAutopsyAdventMECMk2()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyAdventMECMk2');
	Template.PointsToComplete = 3600;
	Template.strImage = "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyMEC";
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CorpseAdventMECMk2');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMEC');

	// Cost
	Artifacts.ItemTemplateName = 'CorpseAdventMECMk2';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

// #######################################################################################
// -------------------- INTERROGATION TECHS ----------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateInterrogateAdventTrooperTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventTrooperInterrogation');
	Template.PointsToComplete = 960;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventTrooper');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventTrooper');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventTrooper';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAdventStunLancerTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventStunLancerInterrogation');
	Template.PointsToComplete = 1800;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventStunLancer');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventStunLancer');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventStunLancer';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAdventCaptainTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventCaptainInterrogation');
	Template.PointsToComplete = 1200;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventCaptain');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventOfficer');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventCaptain';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAdventShieldbearerTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventShieldbearerInterrogation');
	Template.PointsToComplete = 2200;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventShieldBearer');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventShieldbearer');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventShieldBearer';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAdventPriestTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventPriestInterrogation');
	Template.PointsToComplete = 1600;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventPriest');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventPriest');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventPriest';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAdventPurifierTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventPurifierInterrogation');
	Template.PointsToComplete = 2000;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventPurifier');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventPurifier');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventPurifier';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAndromedonTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AndromedonInterrogation');
	Template.PointsToComplete = 4200;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAndromedon');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAndromedon');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAndromedon';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateArchonTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ArchonInterrogation');
	Template.PointsToComplete = 4000;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedArchon');
	Template.Requirements.RequiredTechs.AddItem('AutopsyArchon');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedArchon';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateBerserkerTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BerserkerInterrogation');
	Template.PointsToComplete = 2880;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedBerserker');
	Template.Requirements.RequiredTechs.AddItem('AutopsyBerserker');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedBerserker';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateChryssalidTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ChryssalidInterrogation');
	Template.PointsToComplete = 3600;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedChryssalid');
	Template.Requirements.RequiredTechs.AddItem('AutopsyChryssalid');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedChryssalid';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateCodexTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'CodexInterrogation');
	Template.PointsToComplete = 5000;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedCyberus');
	Template.Requirements.RequiredTechs.AddItem('CodexBrainPt1');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedCyberus';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateFacelessTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'FacelessInterrogation');
	Template.PointsToComplete = 5000;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedFaceless');
	Template.Requirements.RequiredTechs.AddItem('AutopsyFaceless');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedFaceless';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateGatekeeperTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'GatekeeperInterrogation');
	Template.PointsToComplete = 4800;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedGatekeeper');
	Template.Requirements.RequiredTechs.AddItem('AutopsyGatekeeper');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedGatekeeper';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateMutonTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'MutonInterrogation');
	Template.PointsToComplete = 2880;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedMuton');
	Template.Requirements.RequiredTechs.AddItem('AutopsyMuton');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedMuton';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateSectoidTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'SectoidInterrogation');
	Template.PointsToComplete = 1080;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedSectoid');
	Template.Requirements.RequiredTechs.AddItem('AutopsySectoid');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedSectoid';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateSpectreTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'SpectreInterrogation');
	Template.PointsToComplete = 3300;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedSpectre');
	Template.Requirements.RequiredTechs.AddItem('AutopsySpectre');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedSpectre';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateViperTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ViperInterrogation');
	Template.PointsToComplete = 1800;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedViper');
	Template.Requirements.RequiredTechs.AddItem('AutopsyViper');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedViper';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAdventMEC()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventMECInterrogation');
	Template.PointsToComplete = 2400;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventMEC');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMEC');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventMEC';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAdventMECMk2()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventMECMk2Interrogation');
	Template.PointsToComplete = 3600;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventMECMk2');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMECMk2');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventMECMk2';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateSectopod()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'SectopodInterrogation');
	Template.PointsToComplete = 5040;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedSectopod');
	Template.Requirements.RequiredTechs.AddItem('AutopsySectopod');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedSectopod';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateInterrogateAdventTurret()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdventTurretInterrogation');
	Template.PointsToComplete = 5040;
	Template.strImage = ""; // TODO: Get content from graphicker and insert image string
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('CapturedAdventTurret');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventTurret');

	// Cost
	Artifacts.ItemTemplateName = 'CapturedAdventTurret';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

// #######################################################################################
// -------------------- DELEGATE FUNCTIONS -----------------------------------------------
// #######################################################################################

static function GiveRandomItemReward(XComGameState NewGameState, XComGameState_Tech TechState)
{
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate ItemTemplate;
	local array<name> ItemRewards;
	local int iRandIndex;
	
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	
	ItemRewards = TechState.GetMyTemplate().ItemRewards;
	iRandIndex = `SYNC_RAND_STATIC(ItemRewards.Length);
	ItemTemplate = ItemTemplateManager.FindItemTemplate(ItemRewards[iRandIndex]);

	GiveItemReward(NewGameState, TechState, ItemTemplate);
}

private static function GiveItemReward(XComGameState NewGameState, XComGameState_Tech TechState, X2ItemTemplate ItemTemplate)
{	
	class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, ItemTemplate);

	TechState.ItemRewards.Length = 0; // Reset the item rewards array in case the tech is repeatable
	TechState.ItemRewards.AddItem(ItemTemplate); // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = false; // Reset the research report for techs that are repeatable
}