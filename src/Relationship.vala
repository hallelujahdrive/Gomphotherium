using Json;

namespace Gomphotherium {
  
  public class Relationship {
    
    // Property-backing fields
    private int64 _id;  // Target account id
    private bool _following;  // Whether the user is currently following the account
    private bool _followed_by;  // Whether the user is currently being followed by the account
    private bool _blocking; // Whether the user is currently blocking the account
    private bool _muting;  // Whether the user is currently muting the account
    private bool _requested;  //  	Whether the user has requested to follow the account
    
    // Properties
    public int64 id {
      get { return _id; }
    }
    public bool following {
      get { return _following; }
    }
    public bool followed_by {
      get { return _followed_by; }
    }
    public bool blocking {
      get { return _blocking; }
    }
    public bool muting {
      get { return _muting; }
    }
    public bool requested {
      get { return _requested; }
    }
    
    internal Relationship (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "id" : _id = node.get_int ();
          break;
          case "following" : _following = node.get_boolean ();
          break;
          case "followed_by" : _followed_by = node.get_boolean ();
          break;
          case "blocking" : _blocking = node.get_boolean ();
          break;
          case "muting" : _muting = node.get_boolean ();
          break;
          case "requested" : _requested = node.get_boolean ();
          break;
        }
        
      });
      
    }
    
  }
  
}
