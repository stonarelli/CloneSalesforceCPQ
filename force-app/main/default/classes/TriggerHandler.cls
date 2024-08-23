/**
 * @description a version of the trigger handler framework
 * @see OpportunityTriggerHandler
 */
public abstract class TriggerHandler {
    public Boolean isExecuting = false;

    public void run() {
        if (!isExecuting) {
            isExecuting = true;
            if (Trigger.isBefore) {
                if (Trigger.isInsert) beforeInsert();
                if (Trigger.isUpdate) beforeUpdate();
                if (Trigger.isDelete) beforeDelete();
            } else if (Trigger.isAfter) {
                if (Trigger.isInsert) afterInsert();
                if (Trigger.isUpdate) afterUpdate();
                if (Trigger.isDelete) afterDelete();
                if (Trigger.isUndelete) afterUndelete();
            }
            isExecuting = false;
        }
    }

    protected virtual void beforeInsert() {}
    protected virtual void beforeUpdate() {}
    protected virtual void beforeDelete() {}
    protected virtual void afterInsert() {}
    protected virtual void afterUpdate() {}
    protected virtual void afterDelete() {}
    protected virtual void afterUndelete() {}
}