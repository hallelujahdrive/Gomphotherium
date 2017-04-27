namespace Gomphotherium {
  
  public class StreamHead : Gomphotherium.Object {
    
    // Property-backing fields
    private string _content;
    
    // Properties
    public string content {
      get { return _content; }
    }
    
    internal StreamHead (string content) {
      
      _content = content;
      
    }
  }
}
