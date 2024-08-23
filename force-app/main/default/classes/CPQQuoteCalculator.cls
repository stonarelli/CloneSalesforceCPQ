/**
 * @description Calculate Quote API performances handles calculations similarly to the 
 * speed of asynchronous calculations in Salesforce CPQ
 */
public class CPQQuoteCalculator {  
    
    public static CPQAPIModels.QuoteModel calculate( String quoteId ) {
        
        String jsonResult = SBQQ.ServiceRouter.read('SBQQ.QuoteAPI.QuoteReader', (String) quoteId);
        CPQAPIModels.QuoteModel quoteModel = (CPQAPIModels.QuoteModel) JSON.deserialize(jsonResult, CPQAPIModels.QuoteModel.class);
        
        CPQAPIModels.CalculatorContext ctx = new CPQAPIModels.CalculatorContext(quoteModel);
        CPQAPIModels.QuoteModel calculatedQuoteModel = SBQQ.ServiceRouter.load('SBQQ.QuoteAPI.QuoteCalculator', null, JSON.serialize(ctx));   
        
        String savedQuoteJSON = SBQQ.ServiceRouter.save( 'SBQQ.QuoteAPI.QuoteSaver', JSON.serialize(calculatedQuoteModel) );
        CPQAPIModels.QuoteModel updatedQuoteModel = (CPQAPIModels.QuoteModel) JSON.deserialize(savedQuoteJSON, CPQAPIModels.QuoteModel.class);

        return updatedQuoteModel;
    }
}