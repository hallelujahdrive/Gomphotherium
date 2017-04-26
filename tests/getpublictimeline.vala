void get_public_timeline () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var list = app.get_public_timeline (true);
    
    list.foreach ((status) => {
      output_status (status);
    });
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_public_timeline_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_public_timeline_async.begin (true, -1, -1, -1, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try{
      var list = app.get_public_timeline_async.end (res);
      
      list.foreach ((status) => {
        output_status (status);
      });
      
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
  
  GLib.Test.add_func ("/getpublictimeline/get_public_timeline", get_public_timeline);
  GLib.Test.add_func ("/getpublictimeline/get_public_timeline_async", get_public_timeline_async);
  
  return GLib.Test.run ();
}

