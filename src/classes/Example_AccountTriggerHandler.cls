/**
 *  Example implementation of PTH for Account.
 */
public class Example_AccountTriggerHandler extends PartitionedTriggerHandler {

    override ITriggerHandlerPartition[] getPartitions() {
        return new ITriggerHandlerPartition[] {
            new Example_Account_UpdateOpportunityAccountType()
        };
    }

}