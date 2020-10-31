/**
 *  Example implementation of Partition, where any changes to Account.Type are propagated to all 
 *  Opportunities of the Account.
 */
public class Example_Account_UpdateOpportunityAccountType implements ITriggerHandlerPartition {

    Set<Id> accountIdsWithChangedType = new Set<Id>();

    public System.TriggerOperation[] getOperations() {
        return new System.TriggerOperation[] { System.TriggerOperation.AFTER_UPDATE };
    }

    public void initialIteration(SObject newRecord, SObject oldRecord) {
        Account acc = (Account) newRecord;
        Account oldAcc = (Account) oldRecord;

        if (acc.Type != oldAcc.Type) {
            accountIdsWithChangedType.add(acc.Id);
        }
    }

    public void main() {
        if (accountIdsWithChangedType.size() > 0) {
            Opportunity[] relatedOpps = [SELECT AccountId
                            FROM Opportunity
                            WHERE AccountId IN :accountIdsWithChangedType];
            for (Opportunity opp : relatedOpps) {
                Account acc = (Account) Trigger.newMap.get(opp.AccountId);
                opp.Account_Type__c = acc.Type;
            }
            udpate relatedOpps
        }
    }

    public void finalIteration(SObject newRecord, SObject oldRecord) {
    }

}