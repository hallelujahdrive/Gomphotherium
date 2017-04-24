void search () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var results = app.search ("a", true);
    
    output_results (results);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void search_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.search_async.begin ("a", true, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try{
      var results = app.search_async.end (res);
      
      output_results (results);
      
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
  
  GLib.Test.add_func ("/search/search", search);
  GLib.Test.add_func ("/search/search_async", search_async);
  
  return GLib.Test.run ();
  
}

