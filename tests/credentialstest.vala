void update_credentials () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token_2 ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
   var avatar = File.new_for_path ("datas/test_avatar.png");
   var header = File.new_for_path ("datas/test_header.png");
  
  try {
    app.update_credentials ("test+\"&debug", null, avatar, header);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

int main (string[] args) {
  GLib.Test.init (ref args);
  
  //GLib.Test.add_func ("/verifycredentials/verify_credentials", verify_credentials);
  GLib.Test.add_func ("/credentialstest/update_credentials", update_credentials);
  
  return GLib.Test.run ();
}

