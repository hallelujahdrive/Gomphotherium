void get_notification () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 notification_id = load_notification_id ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var notification = app.get_notification (notification_id);
    
    output_notification (notification);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_notification_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 notification_id = load_notification_id ();
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_notification_async.begin (notification_id, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try{
      var notification = app.get_notification_async.end (res);
      
      output_notification (notification);
      
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
  
  GLib.Test.add_func ("/getnotification/get_notification", get_notification);
  GLib.Test.add_func ("/getnotification/get_notification_async", get_notification_async);
  
  return GLib.Test.run ();
  
}

