void remote_follow () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	string account_uri = obj.get_object_member ("remote_account").get_string_member ("account_uri");
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	
	try {
		
		var account = app.remote_follow (account_uri);
		
		assert (account != null);
		assert (account.acct== account_uri);
		
		var relationship = app.get_relationship(account.id);
		assert (relationship.following || relationship.requested); // Probubry, you have not completed follow yet
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
	
}

void remote_unfollow () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	string account_id = obj.get_object_member ("remote_account").get_string_member ("id");
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
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
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	var account_obj_2 = obj.get_array_member ("accounts").get_object_element (2);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	// Send a follow request
	try {
		
		var relationship = app.follow (account_obj_2.get_string_member ("id"));
		assert (relationship != null);
		assert (relationship.id == account_obj_2.get_string_member ("id"));
		assert (relationship.requested);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
	
	var app_2 = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj_2.get_string_member ("access_token"));
	
	// check follow requests
	try {
		var accounts = app_2.get_follow_requests();
		assert (accounts.length () > 0);
		assert (accounts.nth_data (accounts.length () - 1) != null);
		assert (accounts.nth_data (accounts.length () - 1).id == account_obj.get_string_member ("id"));
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}

	//authorize a follow request
	try {
		
		app_2.authorize_follow_request (account_obj.get_string_member ("id"));
		
		var relationship = app.get_relationship (account_obj_2.get_string_member ("id"));
		assert (relationship != null);
		assert (relationship.id == account_obj_2.get_string_member ("id"));
		assert (!relationship.requested);
		assert (relationship.following);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
	
	// unfollow
	try {
		app.unfollow (account_obj_2.get_string_member ("id"));
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
	}

}

void reject_follow_requests () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	var account_obj_2 = obj.get_array_member ("accounts").get_object_element (2);
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	// Send a follow request
	try {
		
		var relationship = app.follow (account_obj_2.get_string_member ("id"));
		assert (relationship != null);
		assert (relationship.id == account_obj_2.get_string_member ("id"));
		assert (relationship.requested);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
	
	
	var app_2 = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj_2.get_string_member ("access_token"));

	//reject a follow request
	try {
		
		app_2.reject_follow_request (account_obj.get_string_member ("id"));
		
		var relationship = app.get_relationship (account_obj_2.get_string_member ("id"));
		assert (relationship != null);
		assert (relationship.id == account_obj_2.get_string_member ("id"));
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
