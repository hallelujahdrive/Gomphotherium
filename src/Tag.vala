using Json;

namespace Gomphoterium {
  
  public class Tag {
    
    // Property-backing fields
    private string _name; // The hashtag, not including the preceding #
    private string _url;  // The URL of the hashtag
    
    // Properties
    public string name {
      get { return _name; }
    }
    public string url {
      get { return _name; }
    }
        
    internal Tag (Json.Object json_obj) {

    }
    
  }
}
