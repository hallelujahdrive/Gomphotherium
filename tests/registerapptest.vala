void register_app () {
  
  string website = load_website ();
  
  string client_name = "valastodon_test";
  string scopes = "read write follow";
  
  try {
    
    var regex = new Regex ("[0-9a-z]{64}");
    
    var app = Valastodon.register_app (website, client_name, null, scopes, null);
    
    assert (regex.match_all_full (app.client_id));
    assert (regex.match_all_full (app.client_secret));
    
    stdout.printf ("\nclient_id : %s\n", app.client_id);
    stdout.printf ("client_secret : %s\n", app.client_secret);
  
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
}

int main (string[] args) {
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/registerapptest/registring_app", register_app);
  
  return GLib.Test.run ();
}
