namespace Valastodon {
  
  public class Delete : Valastodon.Object {
    
    // Property-backing fields
    private string _id;
    
    // Properties
    public string id {
      get { return _id; }
    }
    
    internal Delete (string id) {
      _id = id;
    }
    
  }
}
