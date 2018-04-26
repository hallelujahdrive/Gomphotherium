namespace Valastodon {
  
  // Parse string to json object
  private Json.Object parse_json_object (string json_str) throws Error {
    
    try {
      
      var parser = new Json.Parser ();
      parser.load_from_data (json_str, -1);
      
      return  parser.get_root ().get_object();
    
    } catch (Error e) {
      throw e;
    }
  }
  
  // Parse string to json object
  private Json.Array parse_json_array (string json_str) throws Error {
    
    try {
      
      var parser = new Json.Parser ();
      parser.load_from_data (json_str, -1);
      
     return parser.get_root ().get_array ();

    } catch (Error e) {
      throw e;
    }
  }
}
