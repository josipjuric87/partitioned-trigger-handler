/**
 *  Interface to be implemented by Trigger Partitions.
 */
public interface ITriggerHandlerPartition {

    /**
     *  To return the relevant Trigger Operations.
     */
    public System.TriggerOperation[] getOperations();

    /**
     *  Initial iteration over the trigger records.
     */
    public void initialIteration(SObject newRecord, SObject oldRecord);

    /**
     *  Main part of the partition logic (after the initial iteration, before the final iteration).
     */
    public void main();

    /**
     *  Final iteration ove rthe trigger records.
     */
    public void finalIteration(SObject newRecord, SObject oldRecord);

}