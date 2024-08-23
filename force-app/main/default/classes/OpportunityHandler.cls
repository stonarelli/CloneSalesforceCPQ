/**
 * @description  This class is responsible for handling operations related to the Opportunity object
 * @see CloneOpportunityQueueable
 */
public class OpportunityHandler {

    /**
     * @description Creates a full copy of the Opportunity. All fields on the Opportunity are duplicated in memory, 
     * including relationship fields.
     */
    public static Opportunity cloneOpportunity( String oppId ){

        String fieldsNames = String.join(new List<String>(Schema.getGlobalDescribe().get('Opportunity').getDescribe().fields.getMap().keyset()), ', ');
        
        List<Opportunity> opportunityList = Database.query(
            'SELECT ' + fieldsNames + ' FROM Opportunity WHERE Id = \''+oppId+'\' LIMIT 1'
        );
        return opportunityList.get(0).clone(false, true);
    }
}