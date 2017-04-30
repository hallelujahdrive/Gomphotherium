namespace Gomphotherium {
  
  public uint8[] file_to_bytes (File file) throws Error {
    
    try {
      
      var info = file.query_info ("*", FileQueryInfoFlags.NONE);
      var dis = new DataInputStream (file.read ());      
      var bytes = dis.read_bytes ((size_t) info.get_size ());
      
      stdout.printf ("%s\n", Base64.encode (bytes.get_data ()));
      
      return  ("data:image/png;base64," + Base64.encode (bytes.get_data ())).data;
      
    } catch (Error e) {
      throw e;
    }
  }
}
