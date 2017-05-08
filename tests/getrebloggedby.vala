void get_reblogged_by () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 status_id = load_status_id ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var list = app.get_reblogged_by (status_id);
    
    list.foreach ((account) => {
      output_account (account);
    });
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_reblogged_by_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 status_id = load_status_id ();
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_reblogged_by_async.begin (status_id, -1, -1, -1, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try {
      var list = app.get_reblogged_by_async.end (res);
      
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
  
  GLib.Test.add_func ("/getrebloggedby/get_reblogged_by", get_reblogged_by);
  GLib.Test.add_func ("/getrebloggedby/get_reblogged_by_async", get_reblogged_by_async);
  
  return GLib.Test.run ();
}

