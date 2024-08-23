/**
 * @description this Queueable class clone only PRIMARY quote from oldest Opportunity,
 * concatenate creation of CPQ Quote Line Items
 */
public class CloneQuoteQueueable implements Queueable, System.Finalizer {
    private Id oldOppId;
    private Id newOppId;

    public CloneQuoteQueueable(Id oldOppId, Id newOppId ) {
        this.oldOppId = oldOppId;
        this.newOppId = newOppId;
    }

    public void execute(QueueableContext context) {
        
        Map<String, SBQQ__Quote__c> quotesMap = SBQQQuoteHandler.cloneQuotes( this.oldOppId, this.newOppId );

        SBQQ.TriggerControl.disable(); // Disables built-in CPQ triggers within the current transaction.
        
        insert quotesMap.values();
            
        for( String quoteId : quotesMap.keySet() ){
            System.enqueueJob(new CloneQuoteLinesQueueable( quoteId, quotesMap.get(quoteId).Id));                 
        }
    }
    
    public void execute(System.FinalizerContext ctx) {

        String parentJobId = '' + ctx.getAsyncApexJobId();

        if (ctx.getResult() == ParentJobResult.SUCCESS) {
            System.debug( 'CloneQuoteQueueable queueable job [' + parentJobId + '] completed successfully.');
        } else {
            System.debug( 'CloneQuoteQueueable queueable job [' + parentJobId + '] failed due to unhandled exception: ' + ctx.getException().getMessage());
        }
    }
}