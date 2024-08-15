/*
    The builder pattern is used to instantiate an object of a complex class 
    using the step-by-step approach and return a constructed object at once.

    This pattern is very useful when many parameters are needed to construct 
    and initialize an object.
*/

@isTest
public class OppTestDataDirector {
    public Opportunity Construct(IOppTestDataBuilder oppBuilder) {
        oppBuilder.createManager();
        oppBuilder.createAreaOffice();
        oppBuilder.createOpportunity();
        return oppBuilder.getOpportunity(); 
    }
}

public interface IOppTestDataBuilder {
    //Insert manager record
    void createManager();
    
    //Insert Area office with manager field populated
    void createAreaOffice();
    
    //Create Opportunity but do not insert it
    void createOpportunity();
    
    //return created opportunity
    Opportunity getOpportunity(); 
}

@isTest
public class OppTestDataImpl implements IOppTestDataBuilder {
    
    public Opportunity opp;
    private User u;
    private Area_Office__c aofc;
    
    public void createManager(){
        //create user record so that it can be used while 
        //creating Area office records
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        
        //Use Crypto.getRandomInteger() to get random 
        //string to make sure username is unique
        u = new User(
            Alias = 'standt', 
            Email='dummyEmail@email.com', 
            EmailEncodingKey='UTF-8', 
            LastName='Testing', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = p.Id,  
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='dummyEmail'+Crypto.getRandomInteger()+'@email.com'
        );
        
        insert u;
        
    }
    public void createAreaOffice(){
        Area_Office__c ofc = new Area_Office__c(
            Manager__c = u.Id,
            State__c = 'CT',
            City__c = 'Manchester'
        );
        
       insert ofc ; 
    }
    
    public void createOpportunity(){
        opp = new Opportunity(
            Name = 'Test Opportunity Test',
            CloseDate = Date.today().addDays(7),
            StageName = 'Prospecting',
            State__c = 'CT',
            City__c = 'Manchester'
        ) ;
    }  
    
    public Opportunity getOpportunity(){ 
        return opp;
    }
}

@isTest
public class OpportunityTriggerTest {
    static testMethod void validateState() { 
        OppTestDataDirector director = new OppTestDataDirector(); 
        Opportunity opp =  director.Construct(new OppTestDataImpl()) ;
        
        Test.startTest();
        insert opp;
        Test.stopTest();
        
        Opportunity oppInserted = [SELECT Area_Office__c FROM Opportunity Where Id=:opp.Id];
        
        //Confirm that Area office lookup is not blank
        System.assertNotEquals(oppInserted.Area_Office__c, null) ; 
    }
}