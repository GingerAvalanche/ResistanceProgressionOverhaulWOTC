class X2Item_RPOArtifact extends X2Item config (GameData_WeaponData_RPO);

var config int BEAMGRENADELAUNCHER_ISOUNDRANGE;
var config int BEAMGRENADELAUNCHER_IENVIRONMENTDAMAGE;
var config int BEAMGRENADELAUNCHER_ICLIPSIZE;
var config int BEAMGRENADELAUNCHER_RADIUSBONUS;
var config int BEAMGRENADELAUNCHER_RANGEBONUS;
var config int BEAMGRENADELAUNCHER_TRADINGPOSTVALUE;
var config int HOLOTARGET_DMGMOD;

var config WeaponDamageValue PSIBOMB_BASEDAMAGE;
var config int PSIBOMB_ISOUNDRANGE;
var config int PSIBOMB_IENVIRONMENTDAMAGE;
var config int PSIBOMB_ISUPPLIES;
var config int PSIBOMB_TRADINGPOSTVALUE;
var config int PSIBOMB_IPOINTS;
var config int PSIBOMB_ICLIPSIZE;
var config int PSIBOMB_RANGE;
var config int PSIBOMB_RADIUS;

var config int GHOSTGRENADE_ISOUNDRANGE;
var config int GHOSTGRENADE_IENVIRONMENTDAMAGE;
var config int GHOSTGRENADE_ISUPPLIES;
var config int GHOSTGRENADE_TRADINGPOSTVALUE;
var config int GHOSTGRENADE_IPOINTS;
var config int GHOSTGRENADE_ICLIPSIZE;
var config int GHOSTGRENADE_RANGE;
var config int GHOSTGRENADE_RADIUS;

static function array<X2DataTemplate> CreateTemplates() // @TODO: Change paths of all resource images
{
	local array<X2DataTemplate> Templates;

	// New Grenade Launcher Template
	Templates.AddItem(CreateBeamGrenadeLauncher());
	Templates.AddItem(CreateTemplate_GrenadeLauncher_Beam_Schematic());

	// New Ammo Templates
	Templates.AddItem(CreateHolotargetRounds());

	// New Armor Templates
	Templates.AddItem(CreateMediumEleriumArmor());
	Templates.AddItem(CreateLightEleriumArmor());
	Templates.AddItem(CreateHeavyEleriumArmor());

	// New Grenade Templates
	Templates.AddItem(CreatePsiBombGrenade());
	Templates.AddItem(CreateGhostGrenade());

	// Data Cluster Templates
	Templates.AddItem(CreateCapturedAdventTrooper());
	Templates.AddItem(CreateCapturedAdventStunLancer());
	Templates.AddItem(CreateCapturedAdventCaptain());
	Templates.AddItem(CreateCapturedAdventShieldbearer());
	Templates.AddItem(CreateCapturedAdventPriest());
	Templates.AddItem(CreateCapturedAdventPurifier());
	Templates.AddItem(CreateCapturedAndromedon());
	Templates.AddItem(CreateCapturedArchon());
	Templates.AddItem(CreateCapturedBerserker());
	Templates.AddItem(CreateCapturedChryssalid());
	Templates.AddItem(CreateCapturedCodex());
	Templates.AddItem(CreateCapturedFaceless());
	Templates.AddItem(CreateCapturedGatekeeper());
	Templates.AddItem(CreateCapturedMuton());
	Templates.AddItem(CreateCapturedSectoid());
	Templates.AddItem(CreateCapturedSpectre());
	Templates.AddItem(CreateCapturedViper());
	Templates.AddItem(CreateCapturedAdventMEC());
	Templates.AddItem(CreateCapturedAdventMECMk2());
	Templates.AddItem(CreateCapturedSectopod());
	Templates.AddItem(CreateCapturedAdventTurret());
	
	// Corpse Templates
	Templates.AddItem(CreateCorpseAdventMECMk2());

	return Templates;
}

// #######################################################################################
// -------------------- TIER 3 GRENADE LAUNCHER  -----------------------------------------
// #######################################################################################

static function X2GrenadeLauncherTemplate CreateBeamGrenadeLauncher()
{
	local X2GrenadeLauncherTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, 'GrenadeLauncher_BM');

	Template.strImage = "";
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";

	Template.iSoundRange = default.BEAMGRENADELAUNCHER_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.BEAMGRENADELAUNCHER_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.BEAMGRENADELAUNCHER_TRADINGPOSTVALUE;
	Template.iClipSize = default.BEAMGRENADELAUNCHER_ICLIPSIZE;
	Template.Tier = 2;

	Template.IncreaseGrenadeRadius = default.BEAMGRENADELAUNCHER_RADIUSBONUS;
	Template.IncreaseGrenadeRange = default.BEAMGRENADELAUNCHER_RANGEBONUS;

	Template.GameArchetype = "WP_GrenadeLauncher_MG.WP_GrenadeLauncher_MG";

	Template.CreatorTemplateName = 'GrenadeLauncher_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'GrenadeLauncher_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRangeBonusLabel, , default.BEAMGRENADELAUNCHER_RANGEBONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRadiusBonusLabel, , default.BEAMGRENADELAUNCHER_RADIUSBONUS);

	return Template;
}

static function X2DataTemplate CreateTemplate_GrenadeLauncher_Beam_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'GrenadeLauncher_BM_Schematic');

	Template.ItemCat = 'weapon'; 
	Template.strImage = ""; // TODO: Add beam grenade launcher image
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'GrenadeLauncher_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMECMk2');
	Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 150;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = 15;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = 15;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

// #######################################################################################
// -------------------- NEW AMMO TEMPLATES -----------------------------------------------
// #######################################################################################

static function X2AmmoTemplate CreateHolotargetRounds()
{
	local X2AmmoTemplate Template;
	local ArtifactCost Resources;
	local WeaponDamageValue DamageValue;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, 'HolotargetRounds');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Tracer_Rounds";
	Template.TradingPostValue = 30;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('HoloTargeting');
	DamageValue.Damage = default.HOLOTARGET_DMGMOD;
	Template.AddAmmoDamageModifier(none, DamageValue);
	Template.Tier = 1;
	Template.EquipSound = "StrategyUI_Ammo_Equip";
	
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildAmmoInEngineering )
	{
		Template.CanBeBuilt = true;
	}
	else
	{
		Template.CanBeBuilt = false;
	}

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 75;
	Template.Cost.ResourceCosts.AddItem(Resources);
		
	//FX Reference
	Template.GameArchetype = "Ammo_Tracer.PJ_Tracer";
	
	return Template;
}

// #######################################################################################
// -------------------- NEW ARMOR TEMPLATES ----------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateLightEleriumArmor()
{
	local X2ArmorTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'LightEleriumArmor');
	Template.strImage = ""; // TODO: Get image from graphicker
	Template.ItemCat = 'armor';
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 170;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('LightEleriumArmorStats');
	Template.Abilities.AddItem('GrapplePowered');
	Template.Abilities.AddItem('WallPhasing');
	Template.Abilities.AddItem('Ghosting'); // TODO: Code Ghosting ability. TODO: What is ghosting?
	Template.ArmorTechCat = 'elerium';
	Template.ArmorClass = 'light';
	Template.Tier = 5;
	Template.AkAudioSoldierArmorSwitch = 'Wraith';
	Template.EquipNarrative = ""; // TODO: Build new narrative moment?
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ArcThrower'.default.LIGHT_ELERIUM_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_ArcThrower'.default.LIGHT_ELERIUM_MOBILITY_BONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DodgeLabel, eStat_Dodge, class'X2Ability_ArcThrower'.default.LIGHT_ELERIUM_DODGE_BONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DefenseLabel, eStat_Defense, class'X2Ability_ArcThrower'.default.LIGHT_ELERIUM_DEFENSE_BONUS);

	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildArmorInEngineering )
	{
		Template.CanBeBuilt = true;

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

		Artifacts.ItemTemplateName = 'EleriumCore';
		Artifacts.Quantity = 1;
		Template.Cost.ResourceCosts.AddItem(Artifacts);
	}
		
	return Template;
}

static function X2DataTemplate CreateMediumEleriumArmor()
{
	local X2ArmorTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'MediumEleriumArmor');
	Template.strImage = ""; // TODO: Get image from graphicker
	Template.ItemCat = 'armor';
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 100;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumEleriumArmorStats');
	Template.Abilities.AddItem('PillarArmor');
	Template.ArmorTechCat = 'elerium';
	Template.ArmorClass = 'medium';
	Template.Tier = 5;
	Template.AkAudioSoldierArmorSwitch = 'Warden';
	Template.EquipNarrative = ""; // TODO: Build new narrative moment?
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ArcThrower'.default.MEDIUM_ELERIUM_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_ArcThrower'.default.MEDIUM_ELERIUM_MITIGATION_AMOUNT);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseLabel, eStat_PsiOffense, class'X2Ability_ArcThrower'.default.MEDIUM_ELERIUM_PSIOFFENSE_BONUS);

	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildArmorInEngineering )
	{
		Template.CanBeBuilt = true;

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

		Artifacts.ItemTemplateName = 'EleriumCore';
		Artifacts.Quantity = 1;
		Template.Cost.ResourceCosts.AddItem(Artifacts);
	}
		
	return Template;
}

static function X2DataTemplate CreateHeavyEleriumArmor()
{
	local X2ArmorTemplate Template;
	local ArtifactCost Resources, Artifacts;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'HeavyEleriumArmor');
	Template.strImage = ""; // TODO: Get image from graphicker
	Template.ItemCat = 'armor';
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 205;
	Template.PointsToComplete = 0;
	Template.bHeavyWeapon = true;
	Template.Abilities.AddItem('HeavyEleriumArmorStats');
	Template.Abilities.AddItem('HighCoverGenerator');
	Template.Abilities.AddItem('SamsonProtocol'); // TODO: Code Samson Protocol ability
	Template.ArmorTechCat = 'elerium';
	Template.ArmorClass = 'heavy';
	Template.Tier = 5;
	Template.AkAudioSoldierArmorSwitch = 'WAR';
	Template.EquipNarrative = ""; // TODO: Build new narrative moment?
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ArcThrower'.default.HEAVY_ELERIUM_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_ArcThrower'.default.HEAVY_ELERIUM_MITIGATION_AMOUNT);

	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildArmorInEngineering )
	{
		Template.CanBeBuilt = true;

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

		Artifacts.ItemTemplateName = 'EleriumCore';
		Artifacts.Quantity = 1;
		Template.Cost.ResourceCosts.AddItem(Artifacts);
	}
	
	return Template;
}

// #######################################################################################
// -------------------- NEW GRENADE TEMPLATES --------------------------------------------
// #######################################################################################

static function X2DataTemplate CreatePsiBombGrenade()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'PsiBombGrenade');

	Template.WeaponCat = 'utility';
	Template.ItemCat = 'utility';
	Template.strImage = ""; // TODO: Get image from graphicker
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', ""); // TODO: Get icon from graphicker
	Template.AddAbilityIconOverride('LaunchGrenade', ""); // TODO: Get icon from graphicker
	Template.iRange = default.PSIBOMB_RANGE;
	Template.iRadius = default.PSIBOMB_RADIUS;

	Template.BaseDamage = default.PSIBOMB_BASEDAMAGE;
	Template.iSoundRange = default.PSIBOMB_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PSIBOMB_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.PSIBOMB_TRADINGPOSTVALUE;
	Template.PointsToComplete = default.PSIBOMB_IPOINTS;
	Template.iClipSize = default.PSIBOMB_ICLIPSIZE;
	Template.DamageTypeTemplateName = 'Psi';
	Template.Tier = 3;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.bFriendlyFireWarning = true;

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';	
	WeaponDamageEffect.bIgnoreArmor = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;

	Template.GameArchetype = "WP_Grenade_Flashbang.WP_Grenade_Flashbang";
	
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildGrenadesInEngineering )
		Template.CanBeBuilt = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.PSIBOMB_ISUPPLIES;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Soldier Bark
	Template.OnThrowBarkSoundCue = 'ThrowGrenade';

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.PSIBOMB_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.PSIBOMB_RADIUS);

	return Template;
}

static function X2DataTemplate CreateGhostGrenade()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplySmokeGrenadeToWorld WeaponEffect;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'GhostGrenade');

	Template.WeaponCat = 'utility';
	Template.ItemCat = 'utility';
	Template.strImage = ""; // TODO: Get image from graphicker
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', ""); // TODO: Get icon from graphicker
	Template.AddAbilityIconOverride('LaunchGrenade', ""); // TODO: Get icon from graphicker
	Template.iRange = default.GHOSTGRENADE_RANGE;
	Template.iRadius = default.GHOSTGRENADE_RADIUS;

	Template.iSoundRange = default.GHOSTGRENADE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.GHOSTGRENADE_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.GHOSTGRENADE_TRADINGPOSTVALUE;
	Template.PointsToComplete = default.GHOSTGRENADE_IPOINTS;
	Template.iClipSize = default.GHOSTGRENADE_ICLIPSIZE;
	Template.Tier = 3;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.bFriendlyFireWarning = false;

	WeaponEffect = new class'X2Effect_ApplySmokeGrenadeToWorld';	
	Template.ThrownGrenadeEffects.AddItem(WeaponEffect);
	Template.ThrownGrenadeEffects.AddItem(class'X2Item_DefaultGrenades'.static.SmokeGrenadeEffect());
	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;

	Template.GameArchetype = "WP_Grenade_Smoke.WP_Grenade_Smoke_Lv2";
	
	if ( class'X2StrategyElement_Techs_ResistanceProgressionOverhaulWOTC'.default.bBuildGrenadesInEngineering )
		Template.CanBeBuilt = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.GHOSTGRENADE_ISUPPLIES;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Soldier Bark
	Template.OnThrowBarkSoundCue = 'ThrowGrenade';

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.GHOSTGRENADE_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.GHOSTGRENADE_RADIUS);

	return Template;
}

// #######################################################################################
// -------------------- DATA CLUSTER TEMPLATES -------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateCapturedAdventTrooper()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventTrooper');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAdventStunLancer()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventStunLancer');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAdventCaptain()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventCaptain');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAdventShieldbearer()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventShieldBearer');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAdventPriest()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventPriest');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAdventPurifier()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventPurifier');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAndromedon()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAndromedon');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedArchon()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedArchon');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedBerserker()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedBerserker');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedChryssalid()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedChryssalid');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedCodex()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedCyberus');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedFaceless()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedFaceless');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedGatekeeper()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedGatekeeper');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedMuton()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedMuton');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedSectoid()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedSectoid');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedSpectre()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedSpectre');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedViper()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedViper');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAdventMEC()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventMEC');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAdventMECMk2()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventMECMk2');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedSectopod()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedSectopod');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

static function X2DataTemplate CreateCapturedAdventTurret()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CapturedAdventTurret');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Elerium_Core";
	Template.strInventoryImage = "img:///UILibrary_XPACK_StrategyImages.Invx_Elerium_Core";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 15;

	return Template;
}

// #######################################################################################
// -------------------- CORPSE TEMPLATES -------------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateCorpseAdventMECMk2()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseAdventMECMk2');

	Template.strImage = "img:///UILibrary_StrategyImages.CorpseIcons.Corpse_MEC2";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 4;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}