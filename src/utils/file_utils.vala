namespace Gomphotherium {
  
  public string file_to_base64 (File file) throws Error {
    
    try {
      
      var info = file.query_info ("*", FileQueryInfoFlags.NONE);
      var dis = new DataInputStream (file.read ());      
      var bytes = dis.read_bytes ((size_t) info.get_size ());
      
      stdout.printf ("%s\n", Base64.encode (bytes.get_data ()));
      
      return  Base64.encode (bytes.get_data ());
      
    } catch (Error e) {
      throw e;
    }
  }
}
