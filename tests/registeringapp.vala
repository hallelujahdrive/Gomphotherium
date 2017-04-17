void registering_app () {
  
  var website = load_website ();
  
  var client_name = "gomphoterium_test";
  var scope = "read write follow";
  
  var app = Gomphoterium.registering_app (website, client_name, null, scope, null);
  
  stdout.printf ("\nwebsite : %s\nclient_id : %s\nclient_secret : %s\n", app.website, app.client_id, app.client_secret);
  
}

void registering_app_async () {
  var loop = new MainLoop ();
  var website = load_website ();
  
  var client_name = "gomphoterium_test";
  var scope = "read write follow";
  
  stdout.printf ("begin function\n");
  Gomphoterium.registering_app_async.begin (website, client_name, null, scope, null, (obj, res) => {
    stdout.printf ("\nbegin async method");
    var app = Gomphoterium.registering_app_async.end (res);
  
    stdout.printf ("\nwebsite : %s\nclient_id : %s\nclient_secret : %s\n", app.website, app.client_id, app.client_secret);
    stdout.printf ("\nend async method\n");
    loop.quit();
  });
  stdout.printf ("end function\n");
  loop.run ();
}

string load_website () {
  string read = "";
  try {
    string filename = "website.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return read;
}

int main (string[] args) {
  GLib.Test.init (ref args);
  GLib.Test.add_func ("/registeringapp/registring_app", registering_app);
  GLib.Test.add_func ("/registeringapp/registring_app_async", registering_app_async);
  return GLib.Test.run ();
}
