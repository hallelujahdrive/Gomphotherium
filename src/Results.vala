using Json;

namespace Valastodon {
  
  public class Results {
    
    // Property-backing fields
    private List<Account> _accounts = new List<Account> (); // An array of matched Accounts
    private List <Status> _statuses = new List<Status> (); // An array of matched Statuses
    private List <string> _hashtags = new List<string> (); // An array of matched hashtags, as strings
    
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
