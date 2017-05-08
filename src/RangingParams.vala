namespace Gomphotherium {
  
  [Compact]
  [Immutable]
  public class RangingParams {
    
    // Property-backing fields
    private int64 _max_id;
    private int64 _since_id;
    private int _limit;
    
    // Properties
    public int64 max_id {
      get { return _max_id; }
    }
    public int64 since_id {
      get { return _since_id; }
    }
    public int limit {
      get { return _limit; }
    }
    
    public RangingParams (int64 max_id = -1, int64 since_id = -1, int limit = -1) {
      _max_id = max_id;
      _since_id = since_id;
      _limit = limit;
    }
  }
}
