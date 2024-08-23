/**
 * @description  This class is responsible for handling operations related to the CPQ Quote Line Item 
 * object (SBQQ__QuoteLine__c) 
 */
public class SBQQQuoteLineHandler {

    /**
     * @description Creates a full copy of the CPQ Quote Line Item. All fields on the CPQ Quote Line Item are duplicated in memory, 
     * including relationship fields.
     */    
    public static List<SBQQ__QuoteLine__c> cloneQuoteLineItems( String oldQuoteId, String newQuoteId ){
        
        List<SBQQ__QuoteLine__c> clonedQuoteLinesList = new List<SBQQ__QuoteLine__c>();

        String fieldsNames = String.join(new List<String>(Schema.getGlobalDescribe().get('SBQQ__QuoteLine__c').getDescribe().fields.getMap().keyset()), ', ');

        List<SBQQ__QuoteLine__c> quoteLinesList = Database.query(
            'SELECT ' + fieldsNames + ' FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = \''+oldQuoteId+'\' '
        ); 

        for (SBQQ__QuoteLine__c qli : quoteLinesList) {
            SBQQ__QuoteLine__c clonedQli = qli.clone(false, true); // Creates a full copy of the Quote Line Item.
            clonedQli.SBQQ__Quote__c = newQuoteId;
            clonedQuoteLinesList.add(clonedQli);
        }

        return clonedQuoteLinesList;
    }
}