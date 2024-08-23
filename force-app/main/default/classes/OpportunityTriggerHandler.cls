/**
 * @description Called automatically by the trigger framework this class extends
 * @see TriggerHandler
 */
public class OpportunityTriggerHandler extends TriggerHandler {
    private List<Opportunity> triggerNew;
    private List<Opportunity> triggerOld;
    private Map<Id, Opportunity> triggerMapNew;
    private Map<Id, Opportunity> triggerMapOld;
    
    private final String changedStageName = 'Delivery';

    /**
     * @description Constructor that sets class variables based on Trigger context vars
     */
    public OpportunityTriggerHandler() {
        this.triggerOld = (List<Opportunity>) Trigger.old;
        this.triggerNew = (List<Opportunity>) Trigger.new;
        this.triggerMapNew = (Map<Id, Opportunity>) Trigger.newMap;
        this.triggerMapOld = (Map<Id, Opportunity>) Trigger.oldMap;
    }
    /**
     * @description before update context method. Whenever an Opportunity is moved to the 
     * stage changedStageName initiate a series of chained queueables that create a clone of 
     * the Opportunity, the CPQ Quote, and the CPQ Quotelines
     */
    protected override void afterUpdate() {

        List<Opportunity> opportunities = new List<Opportunity>();

        for (Opportunity opp : this.triggerNew ) {
            if (opp.StageName == this.changedStageName && this.triggerMapOld.get(opp.Id).StageName != this.changedStageName ) {
                opportunities.add(opp);
            }
        }

        if (!opportunities.isEmpty()) {
            for (Opportunity opp : opportunities) {
                System.enqueueJob(new CloneOpportunityQueueable(opp.Id));
            }
        }
    }
}