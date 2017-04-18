using Json;

namespace Gomphoterium {
  
  public class Mention {
    
    // Property-backing fields
    private string _url;  // URL of user's profile (can be remote)
    private string _username; // The username of the account
    private string _acct; // Equals username for local users, includes @domain for remote ones
    private int64 _id;  // Account ID
    
    // Properties;
    public unowned string url {
      get { return _url; }
    }
    public unowned string username {
      get { return _username; }
    }
    public unowned string acct {
      get { return _acct; }
    }
    public unowned int64 id {
      get { return _id; }
    }
    
    internal Mention (Json.Object json_obj) {
      
    }
  }
}
