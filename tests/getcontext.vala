void get_context () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 status_id = load_status_id ();
    
  var app = new Valastodon.ValastodonApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var context = app.get_context (status_id);
    
    output_context (context);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_context_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 status_id = load_status_id ();
    
  var app = new Valastodon.AsyncValastodonApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_context_async.begin (status_id, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try {
      var context = app.get_context_async.end (res);
      
      output_context (context);
      
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
  
  GLib.Test.add_func ("/getcontext/get_context", get_context);
  GLib.Test.add_func ("/getcontext/get_context_async", get_context_async);
  
  return GLib.Test.run ();
  
}
