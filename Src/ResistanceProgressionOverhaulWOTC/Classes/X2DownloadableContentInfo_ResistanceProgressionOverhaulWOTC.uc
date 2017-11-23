class X2DownloadableContentInfo_ResistanceProgressionOverhaulWOTC extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	PatchArcThrowingIntoSkullJack();
	PatchProvingGroundProjects();
	PatchResearchProjects();
	PatchAmmo();
	PatchGrenades();
	PatchVests();
	PatchArmors();
	PatchItems();
	PatchWeapons();
}

static function PatchArcThrowingIntoSkullJack()
{
	local X2ItemTemplateManager ItemManager;
	local X2WeaponTemplate Template;

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	Template = X2WeaponTemplate(ItemManager.FindItemTemplate('Skulljack'));
	Template.Abilities.AddItem('ArcThrowerAbility');
	//Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_ArcThrower'.default.PSIJACK_PSIOFFENSE_BONUS, false, IsPsijackingResearched);
}

static function bool IsArcThrowingResearched()
{
	return class'UIUtilities_Strategy'.static.GetXComHQ().IsTechResearched('ArcThrowing');
}

static function PatchProvingGroundProjects()
{
	local X2StrategyElementTemplateManager StratMgr;
	local X2TechTemplate TechTemplate;

	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

	// Experimental Ammo -> AP Rounds
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('ExperimentalAmmo'));
	TechTemplate.RewardDeck = 'None';
	TechTemplate.Requirements.RequiredTechs.AddItem('MutonInterrogation');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildAmmoInEngineering )
	{
		TechTemplate.ResearchCompletedFn = none;
	}
	else
	{
		TechTemplate.ResearchCompletedFn = class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.static.GiveRandomItemReward;
		TechTemplate.ItemRewards.AddItem('APRounds');
	}

	// Experimental Grenades -> Acid Grenades
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('ExperimentalGrenade'));
	TechTemplate.RewardDeck = 'None';
	TechTemplate.ItemRewards.AddItem('AcidGrenade');
	TechTemplate.Requirements.RequiredTechs.AddItem('AutopsyAndromedon');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildGrenadesInEngineering )
	{
		TechTemplate.ResearchCompletedFn = none;
	}
	else
	{
		TechTemplate.ResearchCompletedFn = class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.static.GiveRandomItemReward;
		TechTemplate.ItemRewards.AddItem('APRounds');
	}

	// Experimental Heavy Weapons -> Flamethrower
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('HeavyWeapons'));
	TechTemplate.RewardDeck = 'None';
	TechTemplate.ItemRewards.AddItem('Flamethrower');
	TechTemplate.Requirements.RequiredTechs.AddItem('AdventPurifierInterrogation');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildHeavyWeaponsInEngineering )
	{
		TechTemplate.ResearchCompletedFn = none;
	}
	else
	{
		TechTemplate.ResearchCompletedFn = class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.static.GiveRandomItemReward;
		TechTemplate.ItemRewards.AddItem('APRounds');
	}

	// Experimental Powered Weapons -> Hellfire Projector
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AdvancedHeavyWeapons'));
	TechTemplate.RewardDeck = 'None';
	TechTemplate.ItemRewards.AddItem('FlamethrowerMk2');
	TechTemplate.Requirements.RequiredTechs.AddItem('AdventPurifierInterrogation');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildHeavyWeaponsInEngineering )
	{
		TechTemplate.ResearchCompletedFn = none;
	}
	else
	{
		TechTemplate.ResearchCompletedFn = class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.static.GiveRandomItemReward;
		TechTemplate.ItemRewards.AddItem('APRounds');
	}

	// Experimental Armor -> Hazmat Vest
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('ExperimentalArmor'));
	TechTemplate.RewardDeck = 'None';
	TechTemplate.ItemRewards.AddItem('HazmatVest');
	TechTemplate.Requirements.RequiredTechs.Length = 0; // Remove AutopsyAdventShieldbearer
	TechTemplate.Requirements.RequiredTechs.AddItem('AutopsyViper');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildVestsInEngineering )
	{
		TechTemplate.ResearchCompletedFn = none;
	}
	else
	{
		TechTemplate.ResearchCompletedFn = class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.static.GiveRandomItemReward;
		TechTemplate.ItemRewards.AddItem('APRounds');
	}

	// Bluescreen -> Bluescreen Rounds
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Bluescreen'));
	TechTemplate.PointsToComplete = class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.static.StafferXDays(1, 10);
	TechTemplate.strImage = "";
	TechTemplate.SortingTier = 3;
	TechTemplate.Requirements.RequiredTechs.RemoveItem('AutopsyAdventMEC');
	TechTemplate.Requirements.RequiredTechs.AddItem('AutopsySpectre');
	if ( !class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildAmmoInEngineering )
	{
		TechTemplate.bRepeatable = true;
		TechTemplate.ResearchCompletedFn = class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.static.GiveRandomItemReward;
		TechTemplate.ItemRewards.AddItem('BluescreenRounds');
	}

	// Spider Suit
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('SpiderSuit'));
	//TechTemplate.Requirements.RequiredTechs.RemoveItem('PlatedArmor'); // Leave in so people can't get before the armor it's based off of
	TechTemplate.Requirements.RequiredTechs.AddItem('ViperInterrogation');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildArmorInEngineering )
	{
		TechTemplate.bRepeatable = false;
		TechTemplate.ResearchCompletedFn = none;
		TechTemplate.ItemRewards.RemoveItem('LightPlatedArmor');
	}

	// Wraith Suit
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('WraithSuit'));
	//TechTemplate.Requirements.RequiredTechs.RemoveItem('PoweredArmor'); // Leave in so people can't get before the armor it's based off of
	TechTemplate.Requirements.RequiredTechs.AddItem('CodexInterrogation');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildArmorInEngineering )
	{
		TechTemplate.bRepeatable = false;
		TechTemplate.ResearchCompletedFn = none;
		TechTemplate.ItemRewards.RemoveItem('LightPoweredArmor');
	}

	// E.X.O. Suit
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('EXOSuit'));
	//TechTemplate.Requirements.RequiredTechs.RemoveItem('PlatedArmor'); // Leave in so people can't get before the armor it's based off of
	TechTemplate.Requirements.RequiredTechs.AddItem('AdventMECInterrogation');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildArmorInEngineering )
	{
		TechTemplate.bRepeatable = false;
		TechTemplate.ResearchCompletedFn = none;
		TechTemplate.ItemRewards.RemoveItem('HeavyPlatedArmor');
	}

	// W.A.R. Suit
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('WARSuit'));
	//TechTemplate.Requirements.RequiredTechs.RemoveItem('PoweredArmor'); // Leave in so people can't get before the armor it's based off of
	TechTemplate.Requirements.RequiredTechs.AddItem('AutopsyAndromedon');
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildArmorInEngineering )
	{
		TechTemplate.bRepeatable = false;
		TechTemplate.ResearchCompletedFn = none;
		TechTemplate.ItemRewards.RemoveItem('HeavyPoweredArmor');
	}

	// Battlefield Medicine
	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BattlefieldMedicine'));
	TechTemplate.Requirements.RequiredTechs.Length = 0;
	TechTemplate.Requirements.RequiredTechs.AddItem('ViperInterrogation');
}

static function PatchResearchProjects()
{
	//nothing as of yet
}

static function PatchAmmo()
{
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate ItemTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildAmmoInEngineering )
	{
		// AP Rounds
		ItemTemplate = ItemTemplateManager.FindItemTemplate('APRounds');
		ItemTemplate.RewardDecks.RemoveItem('ExperimentalAmmoRewards');
		ItemTemplate.CanBeBuilt = true;
		ItemTemplate.Requirements.RequiredTechs.AddItem('APRoundsTech');

		// Tracer Rounds
		ItemTemplate = ItemTemplateManager.FindItemTemplate('TracerRounds');
		ItemTemplate.RewardDecks.RemoveItem('ExperimentalAmmoRewards');
		ItemTemplate.CanBeBuilt = true;
		ItemTemplate.Requirements.RequiredTechs.AddItem('TracerRoundsTech');

		// Incendiary Rounds
		ItemTemplate = ItemTemplateManager.FindItemTemplate('IncendiaryRounds');
		ItemTemplate.RewardDecks.RemoveItem('ExperimentalAmmoRewards');
		ItemTemplate.CanBeBuilt = true;
		ItemTemplate.Requirements.RequiredTechs.AddItem('IncendiaryRoundsTech');

		// Talon Rounds
		ItemTemplate = ItemTemplateManager.FindItemTemplate('TalonRounds');
		ItemTemplate.RewardDecks.RemoveItem('ExperimentalAmmoRewards');
		ItemTemplate.CanBeBuilt = true;
		ItemTemplate.Requirements.RequiredTechs.AddItem('TalonRoundsTech');

		// Venom Rounds
		ItemTemplate = ItemTemplateManager.FindItemTemplate('VenomRounds');
		ItemTemplate.RewardDecks.RemoveItem('ExperimentalAmmoRewards');
		ItemTemplate.CanBeBuilt = true;
		ItemTemplate.Requirements.RequiredTechs.AddItem('VenomRoundsTech');
	}
	
	if ( !class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildAmmoInEngineering )
	{
		// Bluescreen Rounds
		ItemTemplate = ItemTemplateManager.FindItemTemplate('BluescreenRounds');
		ItemTemplate.CanBeBuilt = false;
		ItemTemplate.Requirements.RequiredTechs.RemoveItem('Bluescreen');
	}
}

static function PatchGrenades()
{
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate ItemTemplate;
	local ArtifactCost Resources, Artifacts;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	
	ItemTemplate = ItemTemplateManager.FindItemTemplate(‘EMPGrenade’);
	if (!class’X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC’.default.bBuildGrenadesInEngineering)
	{
		ItemTemplate.CanBeBuilt = false;
	}
}

static function PatchVests()
{
}

static function PatchArmors()
{
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate ItemTemplate;
	local ArtifactCost Resources, Artifacts;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildArmorInEngineering )
	{
		// Light Plated Armor
		ItemTemplate = ItemTemplateManager.FindItemTemplate('LightPlatedArmor');
		ItemTemplate.CanBeBuilt = true;
		Resources.ItemTemplateName = 'Supplies';
		Resources.Quantity = 25;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Resources.ItemTemplateName = 'CorpseAdventTrooper';
		Resources.Quantity = 1;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Artifacts.ItemTemplateName = 'EleriumCore';
		Artifacts.Quantity = 1;
		ItemTemplate.Cost.ArtifactCosts.AddItem(Artifacts);

		// Heavy Plated Armor
		ItemTemplate = ItemTemplateManager.FindItemTemplate('HeavyPlatedArmor');
		ItemTemplate.CanBeBuilt = true;
		Resources.ItemTemplateName = 'Supplies';
		Resources.Quantity = 25;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Resources.ItemTemplateName = 'CorpseAdventTrooper';
		Resources.Quantity = 1;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Artifacts.ItemTemplateName = 'EleriumCore';
		Artifacts.Quantity = 1;
		ItemTemplate.Cost.ArtifactCosts.AddItem(Artifacts);

		// Light Powered Armor
		ItemTemplate = ItemTemplateManager.FindItemTemplate('LightPoweredArmor');
		ItemTemplate.CanBeBuilt = true;
		Resources.ItemTemplateName = 'Supplies';
		Resources.Quantity = 50;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Resources.ItemTemplateName = 'AlienAlloy';
		Resources.Quantity = 10;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Resources.ItemTemplateName = 'EleriumDust';
		Resources.Quantity = 5;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Artifacts.ItemTemplateName = 'EleriumCore';
		Artifacts.Quantity = 1;
		ItemTemplate.Cost.ArtifactCosts.AddItem(Artifacts);

		// Heavy Powered Armor
		ItemTemplate = ItemTemplateManager.FindItemTemplate('HeavyPoweredArmor');
		ItemTemplate.CanBeBuilt = true;
		Resources.ItemTemplateName = 'Supplies';
		Resources.Quantity = 50;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Resources.ItemTemplateName = 'AlienAlloy';
		Resources.Quantity = 10;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Resources.ItemTemplateName = 'EleriumDust';
		Resources.Quantity = 5;
		ItemTemplate.Cost.ResourceCosts.AddItem(Resources);
		Artifacts.ItemTemplateName = 'EleriumCore';
		Artifacts.Quantity = 1;
		ItemTemplate.Cost.ArtifactCosts.AddItem(Artifacts);
	}
}

static function PatchItems()
{
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate ItemTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	
	ItemTemplate = ItemTemplateManager.FindItemTemplate('MindShield');
	ItemTemplate.Requirements.RequiredTechs.Length = 0;
	ItemTemplate.Requirements.RequiredTechs.AddItem('SectoidInterrogation');
	
	// Haven't determined where RefractionField goes
	//ItemTemplate = ItemTemplateManager.FindItemTemplate('RefractionField');
	//ItemTemplate.Requirements.RequiredTechs.Length = 0;
	//ItemTemplate.Requirements.RequiredTechs.AddItem('FacelessInterrogation');
	
	ItemTemplate = ItemTemplateManager.FindItemTemplate('SustainingSphere');
	ItemTemplate.Requirements.RequiredTechs.Length = 0;
	ItemTemplate.Requirements.RequiredTechs.AddItem('AdventPriestInterrogation');
	
	ItemTemplate = ItemTemplateManager.FindItemTemplate('MimicBeacon');
	ItemTemplate.Requirements.RequiredTechs.Length = 0;
	ItemTemplate.Requirements.RequiredTechs.AddItem('FacelessInterrogation');
}

static function PatchWeapons()
{
	//local X2ItemTemplateManager ItemTemplateManager;
	//local X2WeaponTemplate WeaponTemplate;

	//ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	
	//Placeholder. Will be used eventually.
}