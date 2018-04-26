using Json;

namespace Valastodon {
  
  public class Account {
    
    // Property-backing fields
    private int64 _id;  // The ID of the account
    private string _username; // The username of the account
    private string _acct; // Equals username for local users, includes @domain for remote ones
    private string _display_name; // The account's display name
    private bool _locked; // The account cannot be followed without waiting for approval first
    private string _created_at; //  The time the account was created
    private int64 _followers_count; // The number of followers for the account
    private int64 _following_count; // The number of accounts the given account is following
    private int64 _statuses_count;  // The number of statuses the account has made
    private string _note; // Biography of user
    private string _url;  // URL of the user's profile page (can be remote)
    private string _avatar; // URL to the avatar image
    private string _avatar_static;  // URL to the avatar static image (gif)
    private string _header; // URL to the header image
    private string _header_static;  // URL to the header static image (gif)
    
    // Propaties
    public int64 id {
      get { return _id; }
    }
    public string username {
      get { return _username; }
    }
    public string acct {
      get { return _acct; }
    }
    public string display_name {
      get { return _display_name; }
    }
    public bool locked {
      get { return _locked; }
    }
    public string created_at {
      get { return _created_at; }
    }
    public int64 followers_count {
      get { return _followers_count; }
    }
    public int64 following_count {
      get { return _following_count; }
    }
    public int64 statuses_count {
      get { return _statuses_count; }
    }
    public string note {
      get { return _note; }
    }
    public string url {
      get { return _url; }
    }
    public string avatar {
      get { return _avatar; }
    }
    public string avatar_static {
      get { return _avatar_static; }
    }
    public string header {
      get { return _header; }
    }
    public string header_static {
      get { return _header_static; }
    }
    
    internal Account (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "id" : _id = node.get_int ();
          break;
          case "username" : _username = node.get_string ();
          break;
          case "acct" : _acct = node.get_string ();
          break;
          case "display_name" : _display_name = node.get_string ();
          break;
          case "locked" : _locked = node.get_boolean ();
          break;
          case "created_at" : _created_at = node.get_string ();
          break;
          case "followers_count" : _followers_count = node.get_int ();
          break;
          case "following_count" : _following_count = node.get_int ();
          break;
          case "statuses_count" : _statuses_count = node.get_int ();
          break;
          case "note" : _note = node.get_string ();
          break;
          case "url" : _url = node.get_string ();
          break;
          case "avatar" : _avatar = node.get_string ();
          break;
          case "avatar_static" : _avatar_static = node.get_string ();
          break;
          case "header" : _header = node.get_string ();
          break;
          case "header_static" : _header_static = node.get_string ();
          break;
        }
        
      });
      
    }
  }
}
