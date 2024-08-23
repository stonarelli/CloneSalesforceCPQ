/**
 * @description CPQ API references several CPQ data models. To use the Salesforce CPQ API, 
 * create classes for each data model in your org.
 */
public class CPQAPIModels {

    public class QuoteModel {
        public SBQQ__Quote__c record;
        public QuoteLineModel[] lineItems;
        public QuoteLineGroupModel[] lineItemGroups;
        public Integer nextKey;
        public Boolean applyAdditionalDiscountLast;
        public Boolean applyPartnerDiscountFirst;
        public Boolean channelDiscountsOffList;
        public Decimal customerTotal;
        public Decimal netTotal;
        public Decimal netNonSegmentTotal;
    }
    
    public class QuoteLineModel {
        public SBQQ__QuoteLine__c record;
        public Boolean amountDiscountProrated;
        public Integer parentGroupKey;
        public Integer parentItemKey;
        public Integer key;
        public Boolean upliftable;
        public String configurationType;
        public String configurationEvent;
        public Boolean reconfigurationDisabled;
        public Boolean descriptionLocked;
        public Boolean productQuantityEditable;
        public Decimal productQuantityScale;
        public String dimensionType;
        public Boolean productHasDimensions;
        public Decimal targetCustomerAmount;
        public Decimal targetCustomerTotal;
    }
    
    public class QuoteLineGroupModel {
        public SBQQ__QuoteLineGroup__c record;
        public Decimal netNonSegmentTotal;
        public Integer key;
    }
    
    public class CalculatorContext {
        public QuoteModel quote;
        public CalculatorContext(){}
        public CalculatorContext(QuoteModel quote) {
            this.quote = quote;
        }
    }    
}