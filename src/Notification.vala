using Json;

namespace Valastodon {
  
  public class Notification : Valastodon.Object {
    
    // Property-backing fields
    private int64 _id;
    private string _type;
    private string _created_at;
    private Account _account;
    private Status _status;
    
    // Properties
    public int64 id {
      get { return _id; }
    }
    public string notification_type {
      get { return _type; }
    }
    public string created_at {
      get { return _created_at; }
    }
    public weak Account account {
      get { return _account; }
    }
    public weak Status status {
      get { return _status; }
    }
    
    internal Notification (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "id" : _id = node.get_int ();
          break;
          case "type" : _type = node.get_string ();
          break;
          case "created_at" : _created_at = node.get_string ();
          break;
          case "account" : _account = new Account (node.get_object ());
          break;
          case "status" : _status = new Status (node.get_object ());
          break;
        }
        
      });
      
    }
    
  }
  
}
