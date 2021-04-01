/**
 *  Interface to be implemented by Trigger Partitions.
 */
public interface ITriggerHandlerPartition {

    /**
     *  To return the relevant Trigger Operations.
     */
    System.TriggerOperation[] getOperations();

    /**
     *  Initial iteration over the trigger records.
     */
    void initialIteration(SObject newRecord, SObject oldRecord);

    /**
     *  Main part of the partition logic (after the initial iteration, before the final iteration).
     */
    void main();

    /**
     *  Final iteration ove rthe trigger records.
     */
    void finalIteration(SObject newRecord, SObject oldRecord);

}
