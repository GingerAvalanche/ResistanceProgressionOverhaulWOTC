class X2StrategyElement_CombatGeneticsLab extends X2StrategyElement_DefaultFacilities;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Facilities;

	// Additional Facilities
	Facilities.AddItem(CreateCombatGeneticsLabTemplate());

	return Facilities;
}

static function X2DataTemplate CreateCombatGeneticsLabTemplate()
{
	local X2FacilityTemplate Template;
	local ArtifactCost Resources;
	//local StaffSlotDefinition StaffSlotDef;

	`CREATE_X2TEMPLATE(class'X2FacilityTemplate', Template, 'CombatGeneticsLab');
	
	Template.ScienceBonus = 0;
	Template.bIsCoreFacility = false;
	Template.bIsUniqueFacility = true;
	Template.bIsIndestructible = false;
	Template.MapName = "AVG_CombatGeneticsLab";
	//Template.AnimMapName = "AVG_Laboratory_A_Anim";
	Template.FlyInRemoteEvent = '';
	Template.strImage = "img:///UILibrary_StrategyImages.FacilityIcons.ChooseFacility_ProvingGrounds";
	Template.SelectFacilityFn = SelectFacility;

	Template.FillerSlots.AddItem('Soldier');

	Template.bHideStaffSlotOpenPopup = true;

	Template.UIFacilityClass = class'UIFacility_Labs';
	Template.FacilityEnteredAkEvent = "Play_AvengerLaboratory_Unoccupied";
	Template.FacilityCompleteNarrative = "X2NarrativeMoments.Strategy.Avenger_Lab_Complete";
	Template.FacilityUpgradedNarrative = "X2NarrativeMoments.Strategy.Avenger_Lab_Upgraded";
	Template.ConstructionStartedNarrative = "X2NarrativeMoments.Strategy.Avenger_Tutorial_Labratory_Construction";

	Template.BaseMinFillerCrew = 1;
	Template.MaxFillerCrew = 1;

	// Requirements

	// Stats
	Template.PointsToComplete = GetFacilityBuildDays(1);
	Template.iPower = -1;
	Template.UpkeepCost = 35;
	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 10;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}