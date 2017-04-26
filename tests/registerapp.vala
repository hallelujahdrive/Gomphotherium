void register_app () {
  
  string website = load_website ();
  
  string client_name = "gomphotherium_test";
  string scopes = "read write follow";
  
  try {
    
    var app = Gomphotherium.register_app (website, client_name, null, scopes, null);
    stdout.printf ("\nwebsite : %s\nclient_id : %s\nclient_secret : %s\n", app.website, app.client_id, app.client_secret);
  
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
}

void register_app_async () {
  var loop = new MainLoop ();
  
  string website = load_website ();
  
  string client_name = "gomphotherium_test";
  string scopes = "read write follow";
  
  stdout.printf ("begin function\n");
  Gomphotherium.register_app_async.begin (website, client_name, null, scopes, null, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try {
      var app = Gomphotherium.register_app_async.end (res);
      stdout.printf ("\nwebsite : %s\nclient_id : %s\nclient_secret : %s\n", app.website, app.client_id, app.client_secret);
      stdout.printf ("\nend async method\n");
    } catch (Error e) {
      stderr.printf ("%s\n", e.message);
    }
    loop.quit();
  });
  stdout.printf ("end function\n");
  loop.run ();
}

int main (string[] args) {
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/registerapp/registring_app", register_app);
  GLib.Test.add_func ("/registerapp/registring_app_async", register_app_async);
  
  return GLib.Test.run ();
}
