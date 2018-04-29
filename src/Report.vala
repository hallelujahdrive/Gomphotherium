using Json;

namespace Valastodon {
  
  public class Report {
    
    // Properties-backing field
    private string _id;  // The ID of the report
    private bool _action_taken; // The action taken in response to the report
    
    // Properties
    public string id {
      get { return _id; }
    }
    public bool action_taken {
      get { return _action_taken; }
    }
    
    internal Report (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node)=> {
        
        switch (mem) {
          case "id" : _id = node.get_string ();
          break;
          case "action_taken" : _action_taken = node.get_boolean ();
          break;
        }
        
      });
      
    }
  }
}
