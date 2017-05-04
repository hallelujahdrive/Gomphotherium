void post_status () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's acces token
  string access_token = load_access_token_2 ();
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var regex = new Regex ("This is a test toot\\.");
    
    var status = app.post_status ("This is a test toot.");
    assert (status != null);
    assert (regex.match (status.content));
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void post_status_reply () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's acces token
  string access_token = load_access_token_2 ();
  // @hallelujahdrive
  int64 in_reply_to_id = 6016005;
  int64 account_id = 116;
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var regex = new Regex ("This is a reply test toot\\.");
    
    var status = app.post_status ("This is a reply test toot.", in_reply_to_id);
    assert (status != null);
    assert (regex.match (status.content));
    assert (status.in_reply_to_account_id == account_id);
    assert (status.in_reply_to_id == in_reply_to_id);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void post_status_sensitive () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's acces token
  string access_token = load_access_token_2 ();
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var regex = new Regex ("This is a sensitive test toot\\.");
    
    var status = app.post_status ("This is a sensitive test toot.", -1, null, true);
    assert (status != null);
    assert (regex.match (status.content));
    assert (status.sensitive);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void post_status_spoiler_text () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's acces token
  string access_token = load_access_token_2 ();
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var regex = new Regex ("This is a spoiler text test toot\\.");
    var regex_2 = new Regex ("This is a spiler text.");
    
    var status = app.post_status ("This is a spoiler text test toot.", -1, null, false, "This is a spiler text.");
    assert (status != null);
    assert (regex.match (status.content));
    assert (regex_2.match (status.spoiler_text));
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void post_status_visibility_direct () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's acces token
  string access_token = load_access_token_2 ();
  // @hallelujahdrive
  int64 in_reply_to_id = 6016005;
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var regex = new Regex ("This is a visibility \\(direct\\) test toot\\.");
    
    var status = app.post_status ("This is a visibility (direct) test toot.", in_reply_to_id, null, false, null, "direct");
    assert (status != null);
    assert (regex.match (status.content));
    assert (status.visibility == "direct");
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void post_status_visibility_private () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's acces token
  string access_token = load_access_token_2 ();
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var regex = new Regex ("This is a visibility \\(private\\) test toot\\.");
    
    var status = app.post_status ("This is a visibility (private) test toot.", -1, null, false, null, "private");
    assert (status != null);
    assert (regex.match (status.content));
    assert (status.visibility == "private");
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void post_status_visibility_unlisted () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's acces token
  string access_token = load_access_token_2 ();
  
  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var regex = new Regex ("This is a visibility \\(unlisted\\) test toot\\.");
    
    var status = app.post_status ("This is a visibility (unlisted) test toot.", -1, null, false, null, "unlisted");
    assert (status != null);
    assert (regex.match (status.content));
    assert (status.visibility == "unlisted");
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}

void post_status_visibility_public () {
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop's acces token
  string access_token = load_access_token_2 ();

  var app = new Gomphotherium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var regex = new Regex ("This is a visibility \\(public\\) test toot\\.");
    
    var status = app.post_status ("This is a visibility (public) test toot.", -1, null, false, null, "public");
    assert (status != null);
    assert (regex.match (status.content));
    assert (status.visibility == "public");
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    assert (false);
  }
}


int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/posttest/poststatus", post_status);
  GLib.Test.add_func ("/posttest/poststatusreply", post_status_reply);
  GLib.Test.add_func ("/posttest/poststatussensitive", post_status_sensitive);
  GLib.Test.add_func ("/posttest/poststatussenspolertext", post_status_spoiler_text);
  GLib.Test.add_func ("/posttest/poststatusvisibilitydirect", post_status_visibility_direct);
  GLib.Test.add_func ("/posttest/poststatusvisibilityprivate", post_status_visibility_private);
  GLib.Test.add_func ("/posttest/poststatusvisibilityunlisted", post_status_visibility_unlisted);
  GLib.Test.add_func ("/posttest/poststatusvisibilitypublic", post_status_visibility_public);
  
  return GLib.Test.run ();
  
}
