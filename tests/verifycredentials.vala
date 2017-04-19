void verify_credentials () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
    
  var app = new Gomphoterium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
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
    
  var app = new Gomphoterium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var account = app.verify_credentials ();
    
    output_account (account);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    
  }
  
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

void output_account (Gomphoterium.Account account) {
  
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

string load_website () {
  string read = "";
  try {
    string filename = "website.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return read.replace ("\n", "");
}

string[] load_ci_cs () {
  string[] ci_cs = new string[2];
  try {
    string filename = "ci_cs.txt";
    var file = File.new_for_path (filename);
    
    var dis = new DataInputStream (file.read ());
    
    int i = 0;
    string line;
    while ((line = dis.read_line (null)) != null && i < 2) {
      ci_cs[i++] = line.split (":")[1];
    }

} catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return ci_cs;
}

string load_access_token () {
  string read = "";
  try {
    string filename = "access_token.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return read.split (":")[1].replace ("\n", "");
}

int main (string[] args) {
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/verifycredentials/verify_credentials", verify_credentials);
  GLib.Test.add_func ("/tverifycredentials/verify_credentials_async", verify_credentials_async);
  
  return GLib.Test.run ();
}
