/**
 *  Example implementation of PTH for Opportunity.
 */
public class Example_OpportunityTriggerHandler extends PartitionedTriggerHandler {

    override ITriggerHandlerPartition[] getPartitions() {
        return new ITriggerHandlerPartition[] {
            new Example_Opportunity_SetAccountType()
        };
    }

}