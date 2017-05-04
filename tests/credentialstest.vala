void update_credentials () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop
  string access_token = load_access_token_2 ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
   var avatar = File.new_for_path ("datas/test_avatar.png");
   var header = File.new_for_path ("datas/test_header.png");
   
  try {
    var regex = new Regex ("&lt;p&gt;This is a test bio\\.&lt;\\/p&gt;");
    
    var account = app.update_credentials ("test+test", "<p>This is a test bio.</p>", avatar, header);
    
    assert (account != null);
    assert (account.display_name == "test+test");
    assert (regex.match (account.note));
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void verify_credentials () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop
  string access_token = load_access_token_2 ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var regex = new Regex ("&lt;p&gt;This is a test bio\\.&lt;\\/p&gt;");
    
    var account = app.verify_credentials ();

    assert (account != null);
    assert (account.display_name == "test+test");
    assert (regex.match (account.note));
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

int main (string[] args) {
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/credentialstest/update_credentials", update_credentials);
  GLib.Test.add_func ("/verifycredentials/verify_credentials", verify_credentials);

  
  return GLib.Test.run ();
}

