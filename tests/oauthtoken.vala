void oauth_token () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string[] email_pw = load_email_pw ();
  string scope = "read write follow";
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1]);
  
  try {
    stdout.printf ("access_token : %s\n", app.oauth_token(email_pw[0], email_pw[1], scope));
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  } 
}

void oauth_token_async () {
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string[] email_pw = load_email_pw ();
  string scope = "read write follow";
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1]);
  
  stdout.printf ("begin function\n");
  app.oauth_token_async.begin (email_pw[0], email_pw[1], scope, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try{
      string access_token = app.oauth_token_async.end (res);
  
      stdout.printf ("access_token : %s\n", access_token);
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
  
  GLib.Test.add_func ("/oauthtoken/oauth_token", oauth_token);
  GLib.Test.add_func ("/oauthtoken/oauth_token_async", oauth_token_async);
  
  return GLib.Test.run ();
}
