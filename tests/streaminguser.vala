void streaming_user () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 account_id = load_account_id ();
    
  var stream = new Gomphotherium.GomphoStream (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    if (stream.streaming_user ((event, object) => {
      switch (event) {
        case "delete" : stdout.printf ("%s :\n%" + int64.FORMAT + "\n", event, ((Gomphotherium.Delete) object).id);
        break;
        case "notification" :
        stdout.printf ("%s :\n", event);
        output_notification ((Gomphotherium.Notification) object);
        break;
        case "update" :
        stdout.printf ("%s :\n", event);
        output_status ((Gomphotherium.Status) object);
        break;
      }
    })) {
      stdout.printf ("return\n");
    }
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
  }
  
  loop.run ();
}

int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/streaminguser/streaming_user", streaming_user);
  
  return GLib.Test.run ();
}

