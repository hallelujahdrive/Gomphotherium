public string load_website () {
  string read = "";
  try {
    string filename = "website.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return read.replace ("\n", "");
}

public string[] load_ci_cs () {
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

public string[] load_email_pw () {
  string[] email_pw = new string[2];
  try {
    string filename = "email_pw.txt";
    var file = File.new_for_path (filename);
    
    var dis = new DataInputStream (file.read ());
    
    int i = 0;
    string line;
    while ((line = dis.read_line (null)) != null && i < 2) {
      email_pw[i++] = line.split (":")[1];
    }

} catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return email_pw;
}

public string load_access_token () {
  string read = "";
  try {
    string filename = "access_token.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return read.split (":")[1].replace ("\n", "");
}

public int64 load_account_id () {
  string read = "";
  try {
    string filename = "account_id.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return int64.parse (read.split (":")[1].replace ("\n", ""));
}

public int64 load_notification_id () {
  string read = "";
  try {
    string filename = "notification_id.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return int64.parse (read.split (":")[1].replace ("\n", ""));
}
