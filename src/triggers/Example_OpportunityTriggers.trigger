trigger Example_OpportunityTriggers on Opportunity (after update) {

    new Example_OpportunityTriggerHandler().handleTrigger();

}