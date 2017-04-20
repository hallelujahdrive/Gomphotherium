void get_account () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 account_id = load_account_id ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var account = app.get_account (account_id);
    
    output_account (account);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_account_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 account_id = load_account_id ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_account_async.begin (account_id, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try{
      var account = app.get_account_async.end (res);
      
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

void output_account (Gomphotherium.Account account) {
  
  stdout.printf ("""
  id : %""" + int64.FORMAT + """
  username : %s
  acct : %s
  display_name : %s
  locked : %s
  created_at : %s
  followers_count : %""" + int64.FORMAT + """
  following_count : %""" + int64.FORMAT + """
  statuses_count : %""" + int64.FORMAT + """
  note : %s
  url : %s
  avatar : %s
  avatar_static : %s
  header : %s
  header_static %s
  """, account.id, account.username, account.acct, account.display_name,
  account.locked.to_string (), account.created_at, account.followers_count, account.following_count,
  account.statuses_count, account.note, account.url, account.avatar,
  account.avatar_static, account.header, account.header_static);
}

int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/getaccount/get_account", get_account);
  GLib.Test.add_func ("/getaccount/get_account_async", get_account_async);
  
  return GLib.Test.run ();
  
}
