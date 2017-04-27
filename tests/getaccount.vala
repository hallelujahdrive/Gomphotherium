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
    assert (account.display_name == "hallelujahdrive-develop");
    assert (account.locked == false);
    assert (account.created_at == "2017-04-27T17:14:33.560Z");
    assert (account.url == "https://mstdn.jp/@hallelujahdevelop");
    assert (account.avatar == "https://media.mstdn.jp/images/accounts/avatars/000/181/311/original/c70120481d744208.png?1493313570");
    assert (account.avatar_static == "https://media.mstdn.jp/images/accounts/avatars/000/181/311/original/c70120481d744208.png?1493313570");
    assert (account.header == "https://media.mstdn.jp/images/accounts/headers/000/181/311/original/31ff4b1384d5a3ce.png?1493313844");
    assert (account.header_static == "https://media.mstdn.jp/images/accounts/headers/000/181/311/original/31ff4b1384d5a3ce.png?1493313844");
    
    output_account (account);
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);    
    assert (false);
  }
}

void get_account_async () {
  
  var loop = new MainLoop ();
  
  string website = "https://mstdn.jp";
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  // @hallelujahdevelop
  int64 account_id = 181311;
  
  int develop_flag = 0;
    
  var app = new Gomphotherium.AsyncGomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  develop_flag++;
  app.get_account_async.begin (account_id, (obj, res) => {
    assert (develop_flag == 2);
    develop_flag++;
    try{
      var account = app.get_account_async.end (res);
      
      output_account (account);
      
      assert (develop_flag == 3);
      develop_flag++;
    }catch (Error e) {
      stderr.printf ("%s\n", e.message);
      assert (false);
    }
    loop.quit();
  });
  assert (develop_flag == 1);
  develop_flag++;
  
  loop.run ();
}

int main (string[] args) {
  
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/getaccount/get_account", get_account);
  GLib.Test.add_func ("/getaccount/get_account_async", get_account_async);
  
  return GLib.Test.run ();
  
}
