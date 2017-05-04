void follow () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  
  // follow
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var relationship = app.follow (account_id);
    
    assert (relationship != null);
    
    assert (relationship.id == account_id);
    assert (relationship.following);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
  // get following  
  int64 account_id_2 = 116;
  try {
    
    var accounts = app.get_following (account_id_2);
    
    assert (accounts.length () > 0);
    assert (accounts.nth_data (0).id == account_id);
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
  // get followers
  string access_token_2 = load_access_token_2 ();
  
  var app_2 = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token_2);
  
  try {
    var accounts = app_2.get_followers (account_id);
    
    assert (accounts.length () > 0);
    assert (accounts.nth_data (0).id == account_id_2);
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

void unfollow () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var relationship = app.unfollow (account_id);
    
    assert (relationship != null);
    
    assert (relationship.id == account_id);
    assert (!relationship.following);

  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  
  }
}

void mute () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  // mute
  try {
    
    var relationship = app.mute (account_id);
    
    assert (relationship != null);
    
    assert (relationship.id == account_id);
    assert (relationship.muting);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
  // get mutes
  try {
    var accounts = app.get_mutes ();
    
    assert (accounts.length () > 0);
    assert (accounts.nth_data (0).id == account_id);
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

void unmute () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var relationship = app.unmute (account_id);
    
    assert (relationship != null);
    
    assert (relationship.id == account_id);
    assert (!relationship.muting);

  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

void block () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var relationship = app.block (account_id);
    
    assert (relationship != null);
    
    assert (relationship.id == account_id);
    assert (relationship.blocking);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }

  try {
    var accounts = app.get_blocks ();
    
    assert (accounts.length () > 0);
    assert (accounts.nth_data (0).id == account_id);
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

void unblock () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var relationship = app.unblock (account_id);
    
    assert (relationship != null);
    
    assert (relationship.id == account_id);
    assert (!relationship.blocking);

  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  
  }
}

int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/relationshiptest/follow", follow);
  GLib.Test.add_func ("/relationshiptest/unfollow", unfollow);
  GLib.Test.add_func ("/relationshiptest/mute", mute);
  GLib.Test.add_func ("/relationshiptest/unmute", unmute);
  GLib.Test.add_func ("/relationshiptest/block", block);
  GLib.Test.add_func ("/relationshiptest/unblock", unblock);
  
  return GLib.Test.run ();
  
}
