/**
 *  Example implementation of Partition, where the value of Account.Type is set a custom
 *  field on all new Opportunities.
 */
public class Example_Opportunity_SetAccountType implements ITriggerHandlerPartition {

    Set<Id> accountIds = new Set<Id>();
    Map<Id, Account> accountMap;

    public System.TriggerOperation[] getOperations() {
        return new System.TriggerOperation[] { System.TriggerOperation.BEFORE_INSERT };
    }

    public void initialIteration(SObject newRecord, SObject oldRecord) {
        Opportunity opp = (Opportunity) newRecord;

        this.accountIds.add(opp.AccountId);
    }

    public void main() {
        // Retrieve data to be used in final iteration
        this.accountMap = new Map<Id, Account>([
            SELECT Type
            FROM Account
            WHERE Id IN :this.accountIds
        ]);
    }

    public void finalIteration(SObject newRecord, SObject oldRecord) {
        Opportunity opp = (Opportunity) newRecord;

        opp.Account_Type__c = this.accountMap.get(opp.AccountId).Type;
    }

}
