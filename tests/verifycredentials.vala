void verify_credentials () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var account = app.verify_credentials ();
    
    output_account (account);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void verify_credentials_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.verify_credentials_async.begin ((obj, res) => {
    stdout.printf ("\nbegin async method");
    try{
      var account = app.verify_credentials_async.end (res);
      
      output_account (account);
      
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
  
  GLib.Test.add_func ("/verifycredentials/verify_credentials", verify_credentials);
  GLib.Test.add_func ("/tverifycredentials/verify_credentials_async", verify_credentials_async);
  
  return GLib.Test.run ();
}
