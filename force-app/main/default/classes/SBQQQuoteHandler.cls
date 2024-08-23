/**
 * @description  This class is responsible for handling operations related to the Quote object SBQQ__Quote__c
 */
public class SBQQQuoteHandler {
    /**
     * @description Creates a full copy of the Quote. All fields on the Quote are duplicated in memory, 
     * including relationship fields.
     */
    public static Map<String, SBQQ__Quote__c> cloneQuotes( String oldOppId, String newOppId ){

        Map<String, SBQQ__Quote__c> quotesMap = new Map<String, SBQQ__Quote__c>();

        String fieldsNames = String.join(new List<String>(Schema.getGlobalDescribe().get('SBQQ__Quote__c').getDescribe().fields.getMap().keyset()), ', ');
        
        // Can only duplicate the PRIMARY quote because only one queueable class could be executed
        List<SBQQ__Quote__c> quoteList = Database.query(
            'SELECT ' + fieldsNames + ' FROM SBQQ__Quote__c WHERE SBQQ__Opportunity2__c = \''+oldOppId+'\' AND SBQQ__Primary__c = TRUE LIMIT 1'
        );
  
        if( quoteList.size() > 0 ){

            SBQQ__Quote__c clonedQuote = quoteList.get(0).clone(false, true);
            clonedQuote.SBQQ__Opportunity2__c = newOppId; // Assign the cloned Opportunity Id                
            quotesMap.put( quoteList.get(0).Id,  clonedQuote );
        }

        return quotesMap;
    }
}