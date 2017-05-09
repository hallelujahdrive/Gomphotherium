namespace Gomphotherium {
  
  [Compact]
  [Immutable]
  public class RangingParams {
    
    // Properties
    public int64 max_id;
    public int64 since_id;
    public int limit;
    
    // @max_id : (oprional) Get a list of items with ID less than or equal this value
    // @since_id : (optional) Get a list of items with ID greater than this value
    // @limit : (optional) Maximum number of items to get (Default 40, Max 80)
    public RangingParams (int64 max_id = -1, int64 since_id = -1, int limit = -1) {
      this.max_id = max_id;
      this.since_id = since_id;
      this.limit = limit;
    }
    
    // @query : The query of the url returned from a request
    public RangingParams.new_from_query (string query) {
      
      int64 max_id = -1;
      int64 since_id = -1;
      int limit = -1;
      
      try {
        var regex = new Regex ("=|&");
        var splited = regex.split (query);
        
        var hashtable = new HashTable<string, string> (str_hash, str_equal);
        
        for (int i = 0; i < splited.length; i = i + 2) {
          hashtable.insert (splited[i], splited[i + 1]);
        }
        
        string max_id_str = hashtable.get ("max_id");
        stdout.printf ("%s\n", max_id_str);
        if (max_id_str != null) {
          max_id = int.parse (max_id_str);
        }
        string since_id_str = hashtable.get ("since_id");
        stdout.printf ("%s\n", since_id_str);
        if (since_id_str != null) {
          since_id = int.parse (since_id_str);
        }
        string limit_str = hashtable.get ("limit");
        stdout.printf ("%s\n", limit_str);
        if (limit_str != null) {
          limit = int.parse (limit_str);
        }
      } catch (Error e) {
        stderr.printf ("%s\n",e.message);
      }
      
      this (max_id, since_id, limit);
    }
  }
}
