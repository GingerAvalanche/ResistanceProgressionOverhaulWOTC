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

    Template.RegisterInTactical = false;
    Template.RegisterInStrategy = true;

    Template.AddCHEvent('CleanupTacticalMission', OnCleanupTacticalMission, ELD_OnStateSubmitted);
    `LOG("Register Event CleanupTacticalMission",, 'RPG');

    return Template;
}

static function EventListenerReturn OnCleanupTacticalMission(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
    // Do ish here
}
