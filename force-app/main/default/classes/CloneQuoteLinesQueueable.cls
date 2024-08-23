/**
 * @description this Queueable class clone the all CPQ Quote Lines from the oldest CPQ Quote
 */
public class CloneQuoteLinesQueueable implements Queueable, System.Finalizer {
    private Id oldQuoteId;
    private Id newQuoteId;

    public CloneQuoteLinesQueueable( Id oldQuoteId, Id newQuoteId ) {
        this.oldQuoteId = oldQuoteId;
        this.newQuoteId = newQuoteId;
    }

    public void execute(QueueableContext context) {
        
        List<SBQQ__QuoteLine__c> clonedQuoteLinesList = SBQQQuoteLineHandler.cloneQuoteLineItems( this.oldQuoteId, this.newQuoteId );

        if ( clonedQuoteLinesList.size() > 0 ) {

            SBQQ.TriggerControl.disable(); // Disables built-in CPQ triggers within the current transaction.

            insert clonedQuoteLinesList;
        }
    }
    
    public void execute(System.FinalizerContext ctx) {

        String parentJobId = '' + ctx.getAsyncApexJobId();
  
        SBQQ.TriggerControl.enable(); // Enables built-in CPQ triggers if they had previously been disabled.

        if (ctx.getResult() == ParentJobResult.SUCCESS) {
            System.debug( 'CloneQuoteLinesQueueable queueable job [' + parentJobId + '] completed successfully.');
        } else {
            System.debug( 'CloneQuoteLinesQueueable queueable job [' + parentJobId + '] failed due to unhandled exception: ' + ctx.getException().getMessage());
        }
    }
}
