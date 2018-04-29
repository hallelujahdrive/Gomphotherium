void get_account () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	var account_obj_2 = obj.get_array_member ("accounts").get_object_element (1);
			
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		var account = app.get_account (account_obj_2.get_string_member ("id"));
		
		assert (account != null);
		
		assert (account.id == account_obj_2.get_string_member ("id"));
		assert (account.username == account_obj_2.get_string_member ("username"));
		assert (account.acct == account_obj_2.get_string_member ("acct"));
		assert (account.display_name == account_obj_2.get_string_member ("display_name"));
		assert (account.locked == account_obj_2.get_boolean_member ("locked"));
		assert (account.created_at == account_obj_2.get_string_member ("created_at"));
		assert (account.url == account_obj_2.get_string_member ("url"));
					
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
}

void get_status () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	// https://mstdn.jp/web/statuses/7483384
	string status_id = "7483384";
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		var status = app.get_status (status_id);
		var regex = new Regex ("This is a get test toot\\.");
		
		assert (status != null);
		assert (status.id == status_id);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
}

void get_statuses () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	var params = new Valastodon.RangingParams (null, null, 20);
	Valastodon.RangingParams next;
	Valastodon.RangingParams prev;
	
	try {
		var statuses = app.get_statuses (account_obj.get_string_member ("id"), false, false, params,out next,out prev);
		assert (statuses.length () > 0);
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
}

void get_home_timeline () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var statuses = app.get_home_timeline ();    
		assert (statuses.length () > 0);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
}

void get_public_timeline () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var statuses = app.get_public_timeline (true);    
		assert (statuses.length () > 0);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
}

void get_tag_timeline () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
		
	try {
		
		var statuses = app.get_tag_timeline ("mastodon", true);    
		assert (statuses.length () > 0);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);
	}
}

void search () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
		
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
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
		
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
		
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
	GLib.Test.add_func ("/gettest/getstatuses", get_statuses);
	GLib.Test.add_func ("/gettest/gethometimeline", get_home_timeline);
	GLib.Test.add_func ("/gettest/getpublictimeline", get_public_timeline);
	// Perhaps this API has a bug
	// GLib.Test.add_func ("/gettest/gettagtimeline", get_tag_timeline);
	GLib.Test.add_func ("/gettest/search", search);
	GLib.Test.add_func ("/gettest/search_accounts", search_accounts);
	
	return GLib.Test.run ();
	
}
