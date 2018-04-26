using Json;

namespace Valastodon {
  
  public class Mention {
    
    // Property-backing fields
    private string _url;  // URL of user's profile (can be remote)
    private string _username; // The username of the account
    private string _acct; // Equals username for local users, includes @domain for remote ones
    private int64 _id;  // Account ID
    
    // Properties
    public string url {
      get { return _url; }
    }
    public string username {
      get { return _username; }
    }
    public string acct {
      get { return _acct; }
    }
    public int64 id {
      get { return _id; }
    }
    
    internal Mention (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "url" : _url = node.get_string ();
          break;
          case "username" : _username = node.get_string ();
          break;
          case "acct" : _acct = node.get_string ();
          break;
          case "id" : _id = node.get_int ();
          break;
        }
      
      });
      
    }
  }
}
