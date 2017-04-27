namespace Gomphotherium {
  
  private void file_to_bytes (File file) throws Error {
    
    var info = file.query_info ("*", FileQueryInfoFlags.NONE);
    string content_type = info.get_content_type ();
    
    
    var data_input_stream = new DataInputStream (file.read ());
    
    
  }
}
