class X2StrategyElement_LaboratoryUpgrade extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Upgrades;

	Upgrades.AddItem(CreateLaboratory_TestUpgrade());

	return Upgrades;
}

static function X2DataTemplate CreateLaboratory_TestUpgrade()
{
	local X2FacilityUpgradeTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'Laboratory_TestUpgrade');
	Template.PointsToComplete = 0;
	Template.MaxBuild = 1;
	Template.strImage = "img:///UILibrary_StrategyImages.FacilityIcons.ChooseFacility_Laboratory_AdditionalResearchStation";
	//Template.OnUpgradeAddedFn = OnUpgradeAdded_UnlockStaffSlot;

	// Stats
	Template.iPower = 0;
	Template.UpkeepCost = 10;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 50;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}