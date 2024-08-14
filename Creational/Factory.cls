/*
The factory method pattern is used to create objects of classes from the same 
family without knowing the exact class name at design time.
*/

/* 
in custom setting

Name            Class Name
Basic           BasicSupport
Premium         PremiumSupport
Platinum        PlatinumSupport
*/

public class SupportFactory {
    public static ISupport getInstance(String supporttype) {
        
        //Read Custom setting to get actual class name on basis of Support type
        Support_Type__c supportTypeInfo = Support_Type__c.getValues(supporttype);
        
        //from custom setting get appropriate class name
        Type t = Type.forName(supportTypeInfo.Class_Name__c);
        
		ISupport result = (ISupport) t.newInstance();
        return result;
    } 
}

public Interface ISupport {
    Integer getSLA();
}

public class PremiumSupport{          
    public Integer getSLA() {
        return 12;
    }
}