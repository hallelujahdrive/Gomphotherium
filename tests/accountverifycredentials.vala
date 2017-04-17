void account_verify_credentials () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  
  stdout.printf ("ClientID : %s\nClientSecret : %s\nAccessToken : %s\n", ci_cs[0], ci_cs[1], access_token);
  
  var app = new Gomphoterium.Application (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var account = app.account_verify_credentials ();
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
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
  
  GLib.Test.add_func ("/accountverifycredentials/account_verify_credentials", account_verify_credentials);
  
  return GLib.Test.run ();
}
