void get_relationships () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 account_id = load_account_id ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var list = app.get_relationships ({account_id});
    
    list.foreach ((relationship) => {
      output_relationship (relationship);
    });
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_relationships_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 account_id = load_account_id ();
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_relationships_async.begin ({account_id}, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try {
      var list = app.get_relationships_async.end (res);
      
      list.foreach ((relationship) => {
        output_relationship (relationship);
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
  
  GLib.Test.add_func ("/getrelationships/get_relationships", get_relationships);
  GLib.Test.add_func ("/getrelationships/get_relationships_async", get_relationships_async);
  
  return GLib.Test.run ();
}
