void register_app () {
  
  string website = load_website ();
  
  string client_name = "gomphotherium_test";
  string scopes = "read write follow";
  
  try {
    
    var regex = new Regex ("[0-9a-z]{64}");
    
    var app = Gomphotherium.register_app (website, client_name, null, scopes, null);
    
    assert (regex.match_all_full (app.client_id));
    assert (regex.match_all_full (app.client_secret));
  
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
}

int main (string[] args) {
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/registerapptest/registring_app", register_app);
  
  return GLib.Test.run ();
}
