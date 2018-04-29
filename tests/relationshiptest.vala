void follow () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	var account_obj_2 = obj.get_array_member ("accounts").get_object_element (1);
	
	// follow
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
	try {
		
		var relationship = app.follow (account_obj_2.get_string_member ("id"));
		
		assert (relationship != null);
		
		assert (relationship.id == account_obj_2.get_string_member ("id"));
		assert (relationship.following);
		
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
	
	try {
		
		var accounts = app.get_following (account_obj.get_string_member ("id"));
		
		assert (accounts.length () > 0);
		assert (accounts.nth_data (0).id == account_obj_2.get_string_member ("id"));
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
	
	// get followers
	var app_2 = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj_2.get_string_member ("access_token"));

	
	try {
		var accounts = app_2.get_followers (account_obj_2.get_string_member ("id"));
		
		assert (accounts.length () > 0);
		assert (accounts.nth_data (0).id == account_obj.get_string_member ("id"));
	} catch (Error e) {
		stderr.printf ("%s\n", e.message);    
		assert (false);
	}
}

void unfollow () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	string account_id = obj.get_array_member ("accounts").get_object_element (1).get_string_member ("id");
	
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

void mute () {
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	string account_id = obj.get_array_member ("accounts").get_object_element (1).get_string_member ("id");
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
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
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	string account_id = obj.get_array_member ("accounts").get_object_element (1).get_string_member ("id");
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
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
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	string account_id = obj.get_array_member ("accounts").get_object_element (1).get_string_member ("id");
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));

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
	
	var obj = load_test_datas ();
	var account_obj = obj.get_array_member ("accounts").get_object_element (0);
	string account_id = obj.get_array_member ("accounts").get_object_element (1).get_string_member ("id");
	
	var app = new Valastodon.ValastodonApp (obj.get_string_member ("instance_website"), obj.get_string_member ("client_key"), obj.get_string_member ("client_secret"), account_obj.get_string_member ("access_token"));
	
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
	// GLib.Test.add_func ("/relationshiptest/unfollow", unfollow);
	GLib.Test.add_func ("/relationshiptest/mute", mute);
	GLib.Test.add_func ("/relationshiptest/unmute", unmute);
	GLib.Test.add_func ("/relationshiptest/block", block);
	GLib.Test.add_func ("/relationshiptest/unblock", unblock);
	
	return GLib.Test.run ();
	
}
