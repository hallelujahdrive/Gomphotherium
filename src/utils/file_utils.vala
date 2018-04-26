namespace Valastodon {
  
  public string file_to_base64_encoded (File file) throws Error {
    
    try {
      
      var info = file.query_info ("*", FileQueryInfoFlags.NONE);
      var dis = new DataInputStream (file.read ());      
      var bytes = dis.read_bytes ((size_t) info.get_size ());
      
      return  "data:" + info.get_content_type () + ";base64," + Base64.encode (bytes.get_data ());
      
    } catch (Error e) {
      throw e;
    }
  }
}
