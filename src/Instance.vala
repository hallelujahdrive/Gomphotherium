using Json;

namespace Valastodon {
  
  public class Instance {
    
    // Propery-backing fields
    private string _url;  // URI of the current instance
    private string _title;  // The instance's title
    private string _description;  // A description for the instance
    private string _email;  // An email address which can be used to contact the instance administrator
    
    // Properties
    public string url {
      get { return _url; }
    }
    public string title {
      get { return _title; }
    }
    public string description {
      get { return _description; }
    }
    public string email {
      get { return _email; }
    }
    
    internal Instance (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "url" : _url = node.get_string ();
          break;
          case "title" : _title = node.get_string ();
          break;
          case "description" : _description = node.get_string ();
          break;
          case "email" : _email = node.get_string ();
          break;
        }
        
      });
    } 
  }
}
