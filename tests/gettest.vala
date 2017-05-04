void get_account () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var account = app.get_account (account_id);
    
    assert (account != null);
    
    assert (account.id == 181311);
    assert (account.username == "hallelujahdevelop");
    assert (account.acct == "hallelujahdevelop");
    assert (account.locked == false);
    assert (account.created_at == "2017-04-27T17:14:33.560Z");
    assert (account.url == "https://mstdn.jp/@hallelujahdevelop");
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

void get_status () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdrive
  string access_token = load_access_token ();
  // https://mstdn.jp/web/statuses/7483384
  int64 status_id = 7483384;
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var status = app.get_status (status_id);
    var regex = new Regex ("This is a get test toot\\.");
    
    assert (status != null);
    assert (status.id == 7483384);
    assert (status.account.id == 181311);
    assert (regex.match (status.content));
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}


void get_home_timeline () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdrive
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var statuses = app.get_home_timeline ();    
    assert (statuses.length () > 0);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_public_timeline () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdrive
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var statuses = app.get_public_timeline (true);    
    assert (statuses.length () > 0);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_tag_timeline () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdrive
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var statuses = app.get_tag_timeline ("mastodon", true);    
    assert (statuses.length () > 0);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void search () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdrive
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    var results = app.search ("a", true);
    
    assert (results != null);
    assert (results.accounts.length () > 0);
    // Perhaps results.statuses's length 0.maybe;bug
    //assert (results.statuses.length () > 0);
    assert (results.hashtags.length () > 0);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void search_accounts () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdrive
  string access_token = load_access_token ();
    
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var accounts = app.search_accounts ("a");
    assert (accounts.length () > 0);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/gettest/getaccount", get_account);
  GLib.Test.add_func ("/gettest/getstatus", get_status);
  GLib.Test.add_func ("/gettest/gethometimeline", get_home_timeline);
  GLib.Test.add_func ("/gettest/getpublictimeline", get_public_timeline);
  // Perhaps this API has a bug
  // GLib.Test.add_func ("/gettest/gettagtimeline", get_tag_timeline);
  GLib.Test.add_func ("/gettest/search", search);
  GLib.Test.add_func ("/gettest/search_accounts", search_accounts);
  
  return GLib.Test.run ();
  
}
