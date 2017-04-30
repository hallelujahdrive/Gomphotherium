void upload_media () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token_2 ();
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  var image = File.new_for_path ("datas/test_image.png");
  
  try {
    var attachment = app.upload_media (image);
    
    app.post_status ("This is a media uplaod test toot.", -1, {attachment.id});
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
}


int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/uploadtest/uploadmedia", upload_media);
  
  return GLib.Test.run ();
}
