namespace Gomphotherium {
  
  public class Delete : Gomphotherium.Object {
    
    // Property-backing fields
    private int64 _id;
    
    // Properties
    public int64 id {
      get { return _id; }
    }
    
    internal Delete (int64 id) {
      _id = id;
    }
    
  }
}
