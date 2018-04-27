int main (string[] args) {
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  // @hallelujahdevelop
  string access_token = load_access_token_2 ();
    
  var app = new Valastodon.ValastodonApp (website, ci_cs[0], ci_cs[1], access_token);
  
   var avatar = File.new_for_path ("datas/avatar.png");
   var header = File.new_for_path ("datas/header.png");
  
  try {
    app.update_credentials ("hallelujahdrive-develop", "vala用Mastodonライブラリ「Valastodon」のテスト用アカウントです.\n御用の際は@hallelujahdriveまで", avatar, header);
    return 0;
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
    return 1;
  }
}
