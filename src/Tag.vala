using Json;

namespace Valastodon {
  
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
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "name" : _name = node.get_string ();
          break;
          case "url" : _url = node.get_string ();
          break;
        }
        
      });
    
    }
  }
}
