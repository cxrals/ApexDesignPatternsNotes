/*

The abstract factory pattern is used to return a set of factories that when combined together
represents a related product. 
Unlike the factory method pattern, which returns a concrete class, the abstract factory pattern returns another factory.

*/

public interface IComputerFactory {
    IProcessor getProcessor();
    IStorage getStorage();
    IMonitor getMonitor();  
}

public class HighPerformance implements IComputerFactory{
    public IProcessor getProcessor(){
        return ProcessorFactory.getInstance('QuadCore');
    }
    public IStorage getStorage(){
        return StorageFactory.getInstance('SSDStorage');
    }
    public IMonitor getMonitor(){
        return MonitorFactory.getInstance('LEDMonitor');
    }
}
 
 
public class StandardConfiguration implements IComputerFactory{
    public virtual IProcessor getProcessor(){
        return ProcessorFactory.getInstance('DualCore');
    }
    public virtual IStorage getStorage(){
        return StorageFactory.getInstance('HDDStorage');
    }
    public virtual IMonitor getMonitor(){
        return MonitorFactory.getInstance('LCDMonitor');
    }
}

public class ProcessorFactroy {
    //Factory method to return instance of concrete class of Processor
    public static IProcessor getInstance(String processorType){ 
        IProcessor retVal = null;
        if (processorType == 'QuadCore'){ // change 4 custom setting / metadata type
            retVal = new QuadCore();
        } else if(processorType == 'DualCore'){
            retVal = new DualCore();  
        }         
        return retVal;         
    }    
}

public class StorageFactory{ 
    //Factory method to return instance of concrete class of Storage
    public static IStorage getInstance(String storageName){
        IStorage retVal = null;
        if (storageName == 'SSDStorage'){
            retVal = new SSDStorage();            
        } else if(storageName == 'HDDStorage'){
            retVal = new HDDStorage();
        }   
        return retVal; 
    }
}

public class MonitorFactory {
   //Factory method to return instance of concrete class of monitor
   public static IMonitor getInstance(String monitorType){ 
       IMonitor retVal = null;
        if (monitorType == 'LEDMonitor'){
           retVal = new LEDMonitor();
        } else if(monitorType == 'LCDMonitor'){
           retVal = new LCDMonitor();
        }          
       return retVal;         
   }    
}

public interface IProcessor{ 
    void performOperation(); 
}

public interface IStorage {
    void storeData(); 
}

public interface IMonitor {
    void display(); 
}

class QuadCore implements IProcessor{ 
    public void performOperation(){
        System.debug('Fast Processor');
    }
}

class DualCore implements IProcessor{
     
    public void performOperation(){
        System.debug('Average Processor');
    }
}

class SSDStorage implements IStorage{ 
    public void storeData(){ 
        System.debug('Storage Operation is Solid State Drive');
    }
}

class HDDStorage implements IStorage{ 
    public void storeData(){ 
        System.debug('Storage Operation is HDD'); 
    }
}

class LEDMonitor implements IMonitor{
         
    public void display(){
        System.debug('LED Monitor');
    }
} 

class LCDMonitor implements IMonitor{
     
    public void display(){
        System.debug('LCD Monitor');
    }
} 

// ======================================================================

public class AssembleComputer {
    IComputerFactory computer ;
    IProcessor processor ;
    IStorage storage ;
    IMonitor monitor ;
    
    /**
     * Constructor to instatiate all factories
     * */
    public AssembleComputer(IComputerFactory comp) {
        computer = comp;
        processor = computer.getProcessor();
        storage = computer.getStorage();
        monitor = computer.getMonitor();
    }
    
    /**
     * run test to see if all factories are assembled together
     * */
    public void runSystemDiagnosis() { 
        processor.performOperation();
        storage.storeData();    
        monitor.display();
    }
}


//Snippet 1:
IComputerFactory highConfig = new HighPerformanceConfiguration();
AssembleComputer highConfig_Computer = new AssembleComputer(highConfig);
highConfig_Computer.runSystemDiagnosis();

//Snippet 2:
IComputerFactory stdConfig = new StandardConfiguration();
AssembleComputer stdConfig_Computer = new AssembleComputer(stdConfig);
stdConfig_Computer.runSystemDiagnosis();


