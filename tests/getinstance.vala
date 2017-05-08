void get_instance () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var instance = app.get_instance ();
    
    output_instance (instance);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_instance_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_instance_async.begin ((obj, res) => {
    stdout.printf ("\nbegin async method");
    try {
      var instance = app.get_instance_async.end (res);
      
      output_instance (instance);
      
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
  
  GLib.Test.add_func ("/getinstance/get_instance", get_instance);
  GLib.Test.add_func ("/getinstance/get_instance_async", get_instance_async);
  
  return GLib.Test.run ();
  
}

