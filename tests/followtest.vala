void remote_follow () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  string account_uri = "hallelujahdrive@pawoo.net";
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var account = app.remote_follow (account_uri);
    
    assert (account != null);
    
    assert (account.acct== account_uri);
    
    var relationship = app.get_relationship(account.id);
    assert (relationship.following);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
}

void remote_unfollow () {
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // hallelujahdrive@pawoo.net
  int64 account_id = 11960;
  
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

void authorize_follow_requests () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // hallelujahdevelop
  int64 account_id = 181311;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  // Send a follow request
  try {
    
    var relationship = app.follow (account_id);
    assert (relationship != null);
    assert (relationship.id == account_id);
    assert (relationship.requested);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
  string access_token_2 = load_access_token_2 ();
  // hallelujahdrive
  int64 account_id_2 = 116;
  
  var app_2 = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token_2);
  
  // check follow requests
  try {
    var accounts = app_2.get_follow_requests();
    assert (accounts.nth_data (0) != null);
    assert (accounts.nth_data (0).id == account_id_2);
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }

  //authorize a follow request
  try {
    
    app_2.authorize_follow_requests (account_id_2);
    //app_2.reject_follow_requests (account_id_2);
    
    var relationship = app.get_relationship (account_id);
    assert (relationship != null);
    assert (relationship.id == account_id);
    assert (!relationship.requested);
    assert (relationship.following);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
  // unfollow
  try {
    app.unfollow (account_id);
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
  }

}

void reject_follow_requests () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // hallelujahdevelop
  int64 account_id = 181311;
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  // Send a follow request
  try {
    
    var relationship = app.follow (account_id);
    assert (relationship != null);
    assert (relationship.id == account_id);
    assert (relationship.requested);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
  
  string access_token_2 = load_access_token_2 ();
  // hallelujahdrive
  int64 account_id_2 = 116;
  
  var app_2 = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token_2);
  
  // check follow requests
  try {
    var accounts = app_2.get_follow_requests();
    assert (accounts.nth_data (0) != null);
    assert (accounts.nth_data (0).id == account_id_2);
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }

  //reject a follow request
  try {
    
    app_2.reject_follow_requests (account_id_2);
    
    var relationship = app.get_relationship (account_id);
    assert (relationship != null);
    assert (relationship.id == account_id);
    assert (!relationship.requested);
    assert (!relationship.following);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/followtest/remotefollow", remote_follow);
  GLib.Test.add_func ("/followtest/unfollow", remote_unfollow);
  GLib.Test.add_func ("/followtest/authorizefollowrequests", authorize_follow_requests);
  GLib.Test.add_func ("/followtest/rejectfollowrequests", reject_follow_requests);
  
  return GLib.Test.run ();
  
}
