void get_reports () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var list = app.get_reports ();
    
    list.foreach ((report) => {
      output_report (report);
    });
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_reports_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_reports_async.begin ((obj, res) => {
    stdout.printf ("\nbegin async method");
    try {
      var list = app.get_reports_async.end (res);
      
      list.foreach ((report) => {
        output_report (report);
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
  
  GLib.Test.add_func ("/getreports/get_reports", get_reports);
  GLib.Test.add_func ("/getreports/get_reports_async", get_reports_async);
  
  return GLib.Test.run ();
}

