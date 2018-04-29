int main (string[] args) {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
 
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
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
