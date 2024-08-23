/**
 * @description queueables that create a clone of the Opportunity, concatenate the creation of CPQ Quote
 */
public class CloneOpportunityQueueable implements Queueable, System.Finalizer {
    private Id oppId;

    public CloneOpportunityQueueable(Id oppId) {
        this.oppId = oppId;
    }

    public void execute(QueueableContext context) {
        
        Opportunity clonedOpp = OpportunityHandler.cloneOpportunity( this.oppId );

        insert clonedOpp;

        System.enqueueJob(new CloneQuoteQueueable(this.oppId, clonedOpp.Id));
    }
    
    public void execute(System.FinalizerContext ctx) {

        String parentJobId = '' + ctx.getAsyncApexJobId();

        if (ctx.getResult() == ParentJobResult.SUCCESS) {
            System.debug( 'CloneOpportunityQueueable queueable job [' + parentJobId + '] completed successfully.');
        } else {
            System.debug( 'CloneOpportunityQueueable queueable job [' + parentJobId + '] failed due to unhandled exception: ' + ctx.getException().getMessage());
        }
    }
}
