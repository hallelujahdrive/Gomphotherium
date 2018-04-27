void get_mutes () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Valastodon.ValastodonApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var list = app.get_mutes ();
    
    list.foreach ((account) => {
      output_account (account);
    });
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_mutes_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Valastodon.AsyncValastodonApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_mutes_async.begin (-1, -1, -1, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try {
      var list = app.get_mutes_async.end (res);
      
      list.foreach ((account) => {
        output_account (account);
      });
      
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
  
  GLib.Test.add_func ("/getmutes/get_mutes", get_mutes);
  GLib.Test.add_func ("/getmutes/get_mutes_async", get_mutes_async);
  
  return GLib.Test.run ();
}
