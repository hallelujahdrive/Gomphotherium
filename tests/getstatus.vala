void get_status () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 status_id = load_status_id ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var status = app.get_status (status_id);
    
    output_status (status);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_status_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 status_id = load_status_id ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_status_async.begin (status_id, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try{
      var status = app.get_status_async.end (res);
      
      output_status (status);
      
      stdout.printf ("\nend async method\n");
    }catch (Error e) {
      stderr.printf ("%s\n", e.message);
    }
    loop.quit();
  });
  stdout.printf ("end function\n");
  loop.run ();
}

int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/getstatus/get_status", get_status);
  GLib.Test.add_func ("/getstatus/get_status_async", get_status_async);
  
  return GLib.Test.run ();
  
}
