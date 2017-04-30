void get_notifications () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  
  // hallelujahdrive's access_token
  string access_token = load_access_token ();
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  int64[] ids = {5500062, 5500083, 5500098, 5500124, 5500213};
  
  try {
    foreach (int64 id in ids) {
      app.favourite (id);
    }    
  } catch (Error e) {
    stdout.printf ("%s\n", e.message);
  }
  
  
  // @hallelujahdevelop's access token
  string access_token_2 = load_access_token_2 ();
  var app_2 = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token_2);
  
  try {
    
    var list = app_2.get_notifications ();
    assert (list.length () > 0);    
    var notification = app_2.get_notification (list.nth_data (0).id);
    assert (notification.id == list.nth_data (0).id);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void clear_notifications () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's access token
  string access_token_2 = load_access_token_2 ();
  var app_2 = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token_2);
  
  int64[] ids = {5500062, 5500083, 5500098, 5500124, 5500213};
  
  try {
    app_2.clear_notifications ();
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }

  // hallelujahdrive's access_token
  string access_token = load_access_token ();
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    foreach (int64 id in ids) {
      app.unfavourite (id);
    }    
  } catch (Error e) {
    stdout.printf ("%s\n", e.message);
  }
}


int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/notificationstest/getnotifications", get_notifications);
  GLib.Test.add_func ("/notificationstest/clearnotitications", clear_notifications);
  
  return GLib.Test.run ();
  
}
