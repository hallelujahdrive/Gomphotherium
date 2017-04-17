using Json;

namespace Gomphoterium {
  public class Account {
    
    // Property-backing fields
    private long _id;
    private string _username;
    // private string _acct;
    private string _display_name;
    private bool _locked;
    private string _created_at;
    private long _followers_count;
    private long _following_count;
    private long _statuses_count;
    private string _note;
    // private string _url;
    private string _avatar;
    private string _avatar_static;
    private string _header;
    private string _header_static;
    
    public Account (Json.Object json_obj) {
      
    }
  }
}
