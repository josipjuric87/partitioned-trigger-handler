/**
 *  Base class for any object-specific Partitioned Trigger Handler implementation.
 */
public virtual class PartitionedTriggerHandler {

    /**
     *  Should return all partitions for the trigger handler.
     */
    abstract ITriggerHandlerPartition[] getPartitions();

    /**
     *  Handles a trigger. To be called from the object-trigger.
     */
    public void handleTriggger() {
        ITriggerHandlerPartition[] partitions = getRelevantPartitions();

        SObject[] recordList = Trigger.isDelete ? Trigger.old : Trigger.new;
        for (SObject record : recordList) {
            SObject newRecord = Trigger.isDelete ? null : record;
            SObject oldRecord = Trigger.isInsert || Trigger.isUndelete ? null :
                                Trigger.isUpdate ? Trigger.oldMap.get(record.Id) :
                                null;

            for (ITriggerHandlerPartition partition : partitions) {
                partition.initialIteration(newRecord, oldRecord);
            }
        }

        for (ITriggerHandlerPartition partition : partitions) {
            partition.main();
        }

        for (SObject record : recordList) {
            SObject newRecord = Trigger.isDelete ? null : record;
            SObject oldRecord = Trigger.isInsert || Trigger.isUndelete ? null :
                                Trigger.isUpdate ? Trigger.oldMap.get(record.Id) :
                                null;

            for (ITriggerHandlerPartition partition : partitions) {
                partition.finalIteration(newRecord, oldRecord);
            }
        }
    }

    /**
     *  Returns the partitions relevant for the current trigger.
     */
    private ITriggerHandlerPartition[] getRelevantPartitions() {
        ITriggerHandlerPartition[] relevantPartitions = new ITriggerHandlerPartition[] {};

        for (ITriggerHandlerPartition partition : getPartitions()) {
            System.TriggerOperation[] ops = partition.getOperations();
            if (ops != null) {
                for (System.TriggerOperation op : ops) {
                    if (Trigger.operationType == op) {
                        relevantPartitions.add(partition);
                        break;
                    }
                }
            }
        }

        return relevantPartitions;
    }

}