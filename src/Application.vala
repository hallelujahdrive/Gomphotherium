using Json;

namespace Gomphoterium {
  
  public class Application {
    
    // Property-backing fields
    private string _name; // Name of the app
    private string _website;  // Homepage URL of the app
    
    // Propaties
    public unowned string name {
      get { return _name; }
    }
    public unowned string? website {
      get { return _name; }
    }
    
    internal Application (Json.Object json_obj) {
      
    }
    
  }
}
