    // Parse regist json
    private Json.Object parse_json_data (uint8[] regist_data) throws Error {
      
      try {
        var parser = new Json.Parser ();
        parser.load_from_data ((string) regist_data, -1);
        
        var root_object = parser.get_root ().get_object();

        return root_object;
      } catch (Error e) {
        throw e;
      }
    }
