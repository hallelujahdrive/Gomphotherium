void update_credentials () {
	 
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
 
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	 var avatar = File.new_for_path ("datas/test_avatar.png");
	 var header = File.new_for_path ("datas/test_header.png");
	 
	try {
		var regex = new Regex ("&lt;p&gt;This is a test bio\\.&lt;\\/p&gt;");
		
		var account = app.update_credentials ("test+test", "<p>This is a test bio.</p>", avatar, header);
		
		assert (account != null);
		assert (account.display_name == "test+test");
		assert (regex.match (account.note));
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

void verify_credentials () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (1);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var account = app.verify_credentials ();

		assert (account != null);
		assert (account.username == account_obj.get_string_member ("username"));
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
		assert (false);
	}
}

int main (string[] args) {
	GLib.Test.init (ref args);
	
	// GLib.Test.add_func ("/credentialstest/update_credentials", update_credentials);
	GLib.Test.add_func ("/verifycredentials/verify_credentials", verify_credentials);

	return GLib.Test.run ();
}

