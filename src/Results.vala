using Json;

namespace Gomphotherium {
  
  public class Results {
    
    // Property-backing fields
    private List<Account> _accounts = new List<Account> ();
    private List <Status> _statuses = new List<Status> ();
    private List <string> _hashtags = new List<string> ();
    
    // Properties
    public weak List<Account> accounts {
      get { return _accounts; }
    }
    public weak List<Status> statuses {
      get { return _statuses; }
    }
    public weak List<string> hashtags {
      get { return _hashtags; }
    }
    
    internal Results (Json.Object json_obj) {
      
      json_obj.foreach_member ((obj, mem, node) => {
        
        switch (mem) {
          case "accounts" :
          node.get_array ().foreach_element ((array, index, node) => {
            _accounts.append (new Account (node.get_object ()));
          });
          break;
          case "statuses" :
          node.get_array ().foreach_element ((array, index, node) => {
            _statuses.append (new Status (node.get_object ()));
          });
          break;
          case "hashtags" :
          node.get_array ().foreach_element ((array, index, node) => {
            _hashtags.append (node.get_string ());
          });
          break;
        }
        
      });
      
    }
  }
}
