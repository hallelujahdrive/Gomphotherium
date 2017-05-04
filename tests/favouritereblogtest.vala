void reblog () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop
  string access_token = load_access_token_2 ();
  // https://mstdn.jp/web/statuses/5049643
  int64 status_id = 5049643;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  // reblog
  try {
    
    var status = app.reblog (status_id);
    
    assert (status != null);
    assert (status.reblog.id == status_id);
    assert (status.reblogged);
    assert (status.reblog.reblogged);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
  // get reblogged by
  string access_token_2 = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  var app_2 = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token_2);
  try {
    
    var list = app_2.get_reblogged_by (status_id);
    
    assert (list.length () > 0);
    assert (list.nth_data (list.length () - 1).id == account_id);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void unreblog () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop
  string access_token = load_access_token_2 ();
  // https://mstdn.jp/web/statuses/5049643
  int64 status_id = 5049643;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var status = app.unreblog (status_id);
    
    assert (status != null);
    assert (status.id == status_id);
    assert (!status.reblogged);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

void favourite () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token_2 ();
  // https://mstdn.jp/web/statuses/5049547
  int64 status_id = 5049547;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  
  // favourite
  try {

    var status = app.favourite (status_id);
    
    assert (status != null);
    assert (status.id == status_id);
    assert (status.favourited);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
  // get favourites
  try {
    
    var statuses = app.get_favourites ();
    
    assert (statuses.length () > 0);
    assert (statuses.nth_data (statuses.length () - 1).id == status_id);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
  // get favourited by
  string access_token_2 = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  var app_2 = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token_2);
  try {
    
    var accounts = app_2.get_favourited_by (status_id);
    
    assert (accounts.length () > 0);
    assert (accounts.nth_data (accounts.length () - 1).id == account_id);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void unfavourite () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token_2 ();
  // https://mstdn.jp/web/statuses/5049547
  int64 status_id = 5049547;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {

    var status = app.unfavourite (status_id);
    
    assert (status != null);
    assert (status.id == status_id);
    assert (!status.favourited);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/reblogreblogtest/reblog", reblog);
  GLib.Test.add_func ("/reblogreblogtest/unreblog", unreblog);
  GLib.Test.add_func ("/favouritereblogtest/favourite", favourite);
  GLib.Test.add_func ("/favouritereblogtest/unfavourite", unfavourite);
  
  return GLib.Test.run ();
  
}
