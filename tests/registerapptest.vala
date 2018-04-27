void register_app () {
  
  string website = load_website ();
  
  string client_name = "valastodon_test";
  string scopes = "read write follow";
  
  try {
    
    var regex = new Regex ("[0-9a-z]{64}");
    
    var map = Valastodon.register_app (website, client_name, null, scopes, null);
    
    assert (regex.match_all_full (map[Valastodon.CLIENT_ID]));
    assert (regex.match_all_full (map[Valastodon.CLIENT_SECRET]));
    
    stdout.printf ("\nclient_id : %s\n", map[Valastodon.CLIENT_ID]);
    stdout.printf ("client_secret : %s\n", map[Valastodon.CLIENT_SECRET]);
      
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
}

int main (string[] args) {
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/registerapptest/registring_app", register_app);
  
  return GLib.Test.run ();
}
